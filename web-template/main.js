// Loosely based on main.js from default Inky export functionality
// TODO Proper modularization
// TODO Standardized naming convention (snake case)

var story = new inkjs.Story(storyContent);

// Some globals needed for certain functionality
var click_anywhere_callback = function(){};
var image_prefix = "images/"

function main(storyContent) {
    let globalTags = story.globalTags;
    if (story.globalTags){
        story.globalTags.forEach(parse_global_tag);
    }
    continueStory();
}

function continueStory() {
    while(story.canContinue) {
        printLine();
    }
    story.currentChoices.forEach(addChoice);
}

function printLine() {
    let paragraphText = format_text(story.Continue());
    let tags = story.currentTags;

    let skip_line = false;

    // Any special tags included with this line
    let customClasses =[];

    // Process split tags
    for (tag of story.currentTags) {
        let splitTag = splitPropertyTag(tag);
        if (splitTag){
            var [property, val] = splitTag;
        }
        // TODO Implement all the tags
        if (!splitTag) {
            // Todo some checks
            if (tag == "CLEAR"){
                clear_text();
            }else if (tag == "RESTART"){
                clear_text();
                restart();
                return;
            }
        } else if (property == "IM_SHOW") {
            add_image(image_prefix + val);
        } else if (property == "IM_HIDE") {
            remove_image(image_prefix + val);
        } else if (property == "SCENE") {
            reset_image(image_prefix + val);
        } else if (property == "IM_REPLACE") {
            // TODO better error checking
            let [path1, path2] = val.split(/\s+/);
            replace_image(image_prefix + path1, image_prefix + path2);
        } else if (property == "IM_PREFIX") {
            image_prefix = val;
        } else if (property == "CLASS"){
            customClasses.push(val);
        } else if (property == "TEXTMODE"){
            customClasses.push("sr-only");
        } else if (property == "AUDIO") {
            /* Note: copied from Inky export */
            let src = val;
            if('audio' in this) {
              this.audio.pause();
              this.audio.removeAttribute('src');
              this.audio.load();
            }
            this.audio = new Audio(val);
            this.audio.play();
        } else if (property == "AUDIOLOOP") {
            /* Note: copied from Inky export */
            let do_update = true;
            let src = val 
            if('audioLoop' in this) {
              // If the same audio is already playing, do not change anything.
              old_src = this.audioLoop.getAttribute("src");
              if (this.audioLoop.getAttribute("src") == src){
                  do_update = false;
                  
              } else {
                  this.audioLoop.pause();
                  this.audioLoop.removeAttribute('src');
                  this.audioLoop.load();
              }
            }
            if (do_update){
                this.audioLoop = new Audio(src);
                this.audioLoop.play();
                this.audioLoop.loop = true;
            }
        }
    } // for each tag

    var paragraphElement = document.createElement('p');
    paragraphElement.innerHTML = paragraphText;

    // Add any custom classes derived from ink tags
    for(var i=0; i<customClasses.length; i++) {
        paragraphElement.classList.add(customClasses[i]);
    }
    
    // TODO Inline links?
    let storySection = document.getElementById("story");
    storySection.appendChild(paragraphElement);
}

function addChoice(choice) {
    var text = choice.text
    
    // Add the given choice to the UI
    var choose_this = function() {
        console.log("Chose a choice");
        // Clear existing choices and clickables
        //removeAll(".choice");
        removeAll("#story button");
        removeAll("#clickmap area");
        set_click_anywhere(function(){});
        story.ChooseChoiceIndex(choice.index);
        if (global_settings.CLEAR_AFTER_CHOICES) {
            clear_text();
        }
        if (global_settings.SKIP_CHOICE_TEXT) {
            story.Continue(); // Skip a line of output
        }
        // Aaand loop
        continueStory();
    }
    
    var clickable = parse_clickable_choice(choice);
    if (clickable && clickable.coords) {
        // TODO Also suppress choice text when it prints?
        //  (not high priority, can just use [ ] in Ink)

        var area = document.createElement("area");
        // href is unfortunately necessary
        //  (or else it won't be clickable via tab/enter)
        // I have not found a way to get rid of the browser status bar
        //  while still maintaining tab accessibility.
        // TODO make this configurable?
        area.setAttribute("href","javascript:;");
        area.setAttribute("shape","rect");
        area.setAttribute("coords",clickable.coords);
        if (clickable.text) {
            // TODO alt should be mandatory (accessibility)
            area.setAttribute("alt",clickable.text);
            area.onmousemove = function() {
                set_hovertext(clickable.text);
            }
        }
        //area.onclick = choose_this;
        area.addEventListener("click",function(event) {
            event.preventDefault(); // Don't follow <a> link
            choose_this();
        });

        var map = document.getElementById("clickmap");
        map.appendChild(area);
    } else if (clickable) {
        // This is a "click anywhere" choice
        setTimeout(function(){
            set_click_anywhere(choose_this);
        },100); // timeout to prevent the current click from triggering it.
        // (it's hacky but probably fairly robust)
    } else {
        // Regular text-based choice

        var storySection = document.getElementById("story");
        var choiceParagraphElement = document.createElement('p');
        choiceParagraphElement.classList.add("choice");
        choiceParagraphElement.innerHTML = `<button>${format_text(text)}</button>`
        storySection.appendChild(choiceParagraphElement);

        // Make the choice clickable
        // Note: we use button, not link, for better semantic HTML
        var buttonEl = choiceParagraphElement.querySelectorAll("button")[0]
        buttonEl.addEventListener("click",function(event) {
            //event.preventDefault(); // Don't follow <a> link
            choose_this();
        });
    }
    // TODO Inline links?
}

// Set global configuration options based on global Ink tags
function parse_global_tag(tag) {
    let splitTag = splitPropertyTag(tag);
    if (!splitTag) {
        return;
    }
    let [property, val] = splitTag;
    switch (property){
        case "TITLE":
            document.title = val;
            break;
        case "CANVAS_WIDTH":
            var canvas = document.getElementById("canvas");
            canvas.style.width = val;
        case "CANVAS_SHAPE":
            var canvas = document.getElementById("canvas");
            let [x,y] = val.split(/\s+/);
            console.log("ratio is:");
            console.log(x/y);
            canvas.style["aspect-ratio"] = x/y;
        case "CLEAR_AFTER_CHOICES":
        case "REPLACE_UNDERSCORES":
        case "SKIP_CHOICE_TEXT":
            global_settings[property] = str_to_bool(val);
            break;
    }
}

// Adding/removing images =====================================================
// TODO make this more DRY

function add_image(path) {
    var canvas = document.getElementById("canvas");
    var exists = document.querySelector(`#canvas img[src="${path}"]`);

    if (exists) {
        // Just move to front.
        canvas.removeChild(exists);
        canvas.appendChild(exists);
    } else {
        var img = document.createElement("img");
        img.setAttribute("draggable",false);
        img.setAttribute("usemap","#clickmap");
        img.setAttribute("src",path);
        img.setAttribute("alt","");
        canvas.appendChild(img);
    }
}

function remove_image(path) {
    removeAll(`#canvas img[src="${path}"]`);
}

function reset_image(path) {
    var canvas = document.getElementById("canvas");
    var current_images = document.querySelectorAll("#canvas img");

    // Add new image *before* removing old ones
    add_image(path);

    for(var i=0; i<current_images.length; i++) {
        var img = current_images[i];
        canvas.removeChild(img);
    }
}

function replace_image(path1, path2){
    var exists = document.querySelector(`#canvas img[src="${path1}"]`);
    if (exists) {
        // Just move to front.
        exists.setAttribute("src",path2);
    } else {
        // Add the image if not already there
        add_image(path2);
    }
}

// Choice parsing stuff =================================================

function parse_clickable_choice(choice) {
    // Return null if "choice" is not a clickable choice, otherwise
    //  return {coords, text}
    result = /(\d+,\d+,\d+,\d+) (.*)/.exec(choice.text)
    if (result) {
        // Is a clickable choice with rectangular coordinates
        return {coords: result[1], text: result[2]};
    }

    result = /,,, (.*)/.exec(choice.text)
    if (result) {
        // Is a "click anywhere" choice.
        return {coords: null, text: result[1]};
    }
    
    // Otherwise, not a clickable choice
    return null;
}

function set_hovertext(text) {
    var hovertext = document.getElementById("hovertext");
    hovertext.innerHTML = text;
    hovertext.removeAttribute("hidden");
}

function clear_hovertext() {
    var hovertext = document.getElementById("hovertext");
    hovertext.innerHTML = "";
    hovertext.setAttribute("hidden","true");
}


function set_click_anywhere(cb) {
    click_anywhere_callback = cb;
    // TODO: set pointer settings?
}

function handle_keypress(e) {
    if (e.key == " "){
        // Space triggers "click anywhere to continue" events
        click_anywhere_callback();
    }
}


// Utils/Small Functions ==================================================

function restart() {
    story.ResetState();
    clear_text();
}

function clear_text() {
    // Clear all text from story
    document.getElementById("story").innerHTML = "";
}

function format_text(str) {
    // Perform transformation on all text produced by ink story.
    // Currently, mainly for replacing underscores with spaces.
    if (global_settings.REPLACE_UNDERSCORES) {
        str = str.replaceAll("_"," ");
    }
    return str;
}

// Remove all elements that match the given selector. Used for removing choices after
// you've picked one, as well as for the CLEAR and RESTART tags.
function removeAll(selector) {
    //let storyDiv = document.getElementById("story");
    //var allElements = storyDiv.querySelectorAll(selector);
    let body = document.body;
    var allElements = body.querySelectorAll(selector);
    for(var i=0; i<allElements.length; i++) {
        var el = allElements[i];
        el.parentNode.removeChild(el);
    }
}

// (Simplified from Inky main.js)
function splitPropertyTag(tag) {
    let [property, ...val] = tag.split(":");
    if (val.length){
        return [property.trim(), val.join(":").trim()];
    }
    return null;
}

// Helpful parser for global tag settings.
function str_to_bool(str) {
    truthy = {"true":null,"t":null,"1":null}
    str = str.toLowerCase().trim();
    return (str in truthy);
}

// Finally, run main
main(storyContent);    

// Using 3rd-party library to fix scale of image map areas to match rescaled images:
imageMapResize();
