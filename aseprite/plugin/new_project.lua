--[[
Functions to create a new, empty Poink project.

New projects should consist of:
 - new directory (named according to project name)
     - one aseprite file (project_name.aseprite)
     - a main ink file (main.ink) in same directory
        - (with stub code)
     - EXPORT.ink file
        - (initially empty)
]]

local function new_project(plugin)
    local dialog = Dialog()
    dialog:label{ id="label", text="New Project" }
    dialog:entry{
        id="title",
        label="Project title",
        text="my-project"
    }
    dialog:newrow{always=false}
    dialog:number{id="width", label="width x height", text="100", decimals=0}
    dialog:number{id="height", text="100", decimals=0}
    dialog:newrow{}
    dialog:file{
        id="path",
        label="Save as...",
        title="Select directory for new project (pick any file)",
        save=true,
        entry=true,
        basepath=app.fs.currentPath
    }
    dialog:button{ id="ok", text="Create New Project" }
    dialog:button{ id="cancel", text="Cancel", onclick = function() dialog:close() end }
    dialog:show()
    
    -- If the user hit cancel, then cancel
    if not dialog.data.ok then
        return
    end

    if not dialog.data.path then
        -- annoyingly, this doesn't work?
        print("Error: must select a path for new project")
    end
    -- TODO validate project title, path, and dimensions


    -- Create new project directory
    -- (slightly hacky, as file select interface only selects a directory)
    local base_path = app.fs.filePath(dialog.data.path)
    local base_path = app.fs.joinPath(base_path,dialog.data.title)
    app.fs.makeAllDirectories(base_path)

    local w = dialog.data.width
    local h = dialog.data.height
    
    -- Create main.ink file and EXPORT.ink
    local main_filename = app.fs.joinPath(base_path,"main.ink")
    local export_filename = app.fs.joinPath(base_path,"EXPORT.ink")
    local file = io.open(main_filename,"w")
    local header_content = {
        "# TITLE: " .. dialog.data.title .."\n",
        "# IM_PREFIX: images/\n",
        "# CANVAS_SHAPE: "..w.." "..h.."\n"
    }
    file:write(table.unpack(header_content))
    file:write([[

INCLUDE EXPORT.ink

-> start
=== start ===
Insert game here.
+ [ok]
-
Game over.
-> END
]])
    file:close()
    file = io.open(export_filename,"w")
    file:write([[
// AUTO-GENERATED FILE - DO NOT MODIFY
// (any changes will be overwritten when exporting)
]])
    file:close()

    -- Create and save new aseprite sprite file
    local sprite = Sprite(w,h)
    local filename = app.fs.joinPath(base_path,"main.aseprite")
    local tag = sprite:newTag(1,1)
    tag.name = "default"
    app.command.SaveFile{
        filename=filename,
        ui=false
    }
end


return new_project
