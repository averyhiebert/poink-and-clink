// Loosely based on main.js from default Inky export functionality
// TODO Proper modularization
// TODO Standardized naming convention (snake case)

var story = new inkjs.Story(storyContent);

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
            add_image(val);
        } else if (property == "IM_HIDE") {
            remove_image(val);
        } else if (property == "SCENE") {
            reset_image(val);
        } else if (property == "IM_REPLACE") {
            // TODO better error checking
            let [path1, path2] = val.split(/\s+/);
            replace_image(path1,path2);
        } else if (property == "CLASS"){
            customClasses.push(val);
        } else if (property == "TEXTMODE"){
            customClasses.push("sr-only");
        } else if (property == "AUDIO") {
            // TODO Implement
        } else if (property == "AUDIOLOOP") {
            // TODO Implement
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
        // Clear existing choices and clickables
        removeAll(".choice");
        removeAll("#clickmap area");
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
    if (clickable) {
        // TODO Also suppress choice text when it prints?
        //  (not high priority, can just use [ ] in Ink)

        var area = document.createElement("area");
        area.setAttribute("href","javascript:;");
        area.setAttribute("shape","rect");
        area.setAttribute("coords",clickable.coords);
        if (clickable.text) {
            // TODO title attribute should be optional (global config)
            area.setAttribute("title",clickable.text); // TODO Optional?
            // TODO alt should be mandatory (accessibility)
            area.setAttribute("alt",clickable.text);
        }
        area.onclick = choose_this;

        var map = document.getElementById("clickmap");
        map.appendChild(area);
    } else {
        // Regular text-based choice

        var storySection = document.getElementById("story");
        var choiceParagraphElement = document.createElement('p');
        choiceParagraphElement.classList.add("choice");
        choiceParagraphElement.innerHTML = `<a>${format_text(text)}</a>`
        storySection.appendChild(choiceParagraphElement);

        // Make the choice clickable
        var choiceAnchorEl = choiceParagraphElement.querySelectorAll("a")[0]
        choiceAnchorEl.addEventListener("click",function(event) {
            event.preventDefault(); // Don't follow <a> link
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
        return {coords: result[1], text: result[2]}
    } else {
        return null;
    }
}


// Utils/Small Functions ==================================================

function restart() {
    story.ResetState();
    continueStory();
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

imageMapResize();
