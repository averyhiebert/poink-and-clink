-- NOTE: This script is slightly modified from "better_export.lua" by Colin Lienard, which was originall released under the MIT license. The following block comment is the description found in the original script.  Subsequent block comments were added by me, Avery Hiebert.
--[[

Description:
This script will flatten the groups of layers and then export a sprite sheet.
This is useful if you work with several groups of layers but you want each group to be a single layer when exporting.
You can choose to export only the visible layers or all of them (they will be automatically made visible).

GitHub:
https://github.com/ColinLienard/aseprite-scripts

]]--

--[[ The script was originally distributed under the following license:
-----------------------------------------------------------------------------

MIT License

Copyright (c) 2022 Colin Lienard

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

----------------------------------------------------------------------

I (Avery Hiebert) license this derivative script under the same license.

Modifications from the original script are as follows.
 - make all layers fully opaque before exporting
 - keep group name as name of new flattened layer
 - export JSON as well (assume same base filename as the png)
 - changes to export format options

]]--

local sprite = app.activeSprite


-- AVERY
local function hideAllLayers(layers)
  for index, layer in ipairs(layers) do
    layer.isVisible = false
    if layer.isGroup then
      hideAllLayers(layer.layers)
    end
  end
end

-- Flatten groups of layers if visible
local function flattenGroups()
  for index, layer in ipairs(sprite.layers) do
    if layer.isGroup and layer.isVisible then
      -- MODIFIED to preserve group name
      local i = layer.stackIndex
      local group_name = layer.name
      app.range.layers = { layer }
      app.command.FlattenLayers()
      sprite.layers[i].name = group_name
    end
  end
end

-- AVERY
function dirFromFile(file)
    a,b = string.find(file,".*/")
    return string.sub(file,a,b)
end

-- AVERY: export a gif of the given layer and tag
local function exportLayerTag(path,layer,tag)
    local dir_name
    if path:sub(-4) == ".txt" then
        i, j = string.find(path,".*/")
        dir_name = dirFromFile(path)
    else
        -- TODO Less hacky way to specify directory
        print("Filename specified should be a .txt, not ".. file)
        return
    end
    
    --Make export dir if it doesn't already exist
    -- TODO Set name correctly
    -- TODO do this earlier, not in this function
    os.execute("mkdir " .. dir_name .. "/test_export")

    --Export gif of given layer and tag to this dir.
    local new_filename = dir_name .. "/test_export/" .. layer.name .. "." .. tag.name .. ".gif"

	app.transaction(function() -- Store sprite modifications
        hideAllLayers(sprite.layers)
        layer.isVisible = true
    end)

    app.command.SaveFileCopyAs{
        ui=false,
        filename=new_filename,
        tag=tag.name,
    }
    app.undo()
end

-- AVERY
local function exportAllTags(path)
    local sprite = app.activeSprite
    for i,tag in ipairs(sprite.tags) do
        for i,layer in ipairs(sprite.layers) do
            --TODO maybe check whether to export this tag for this layer
            exportLayerTag(path,layer,tag)
        end
    end
end

-- TODO implement this
local function exportSliceData(path) end

-- Get the output file
local dialog = Dialog()
dialog:label{ id="label", text="Export to where?" }
--dialog:file{ id="file", open=false, save=true, filetypes={ "txt" }, focus=true }
dialog:file{ id="file", open=false, save=true, focus=true }
dialog:button{ id="ok", text="Export" }
dialog:button{ id="cancel", text="Cancel", onclick = function() dialog:close() end }
dialog:show()

-- Perform everything
print(dialog.data.file)

if dialog.data.ok and dialog.data.file then
  app.transaction(function() -- Store sprite modifications
    flattenGroups()
  end)
  exportAllTags(dialog.data.file)
  app.undo() -- Undo sprite modifications
end
