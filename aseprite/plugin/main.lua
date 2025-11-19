-- Note: Aseprite API only works wtih dofile, not require
local poink_export = dofile("poink_clink_export.lua")
local project_export = dofile("project_export.lua")

function init(plugin)
  -- print("Initializing plugin.")

  -- initialize plugin preferences:
  if plugin.preferences.inklecate_path == nil then
    -- tbh, probably better to leave it as nil?
    -- plugin.preferences.inklecate_path == ""
  end


  -- Create export commands ------------------------------------
  -- TODO move everything to a "Poink" group rather than "Export" group?
  -- Export is okay for now.
  plugin:newMenuGroup{
    id="poink_export_group",
    title="Poink Export",
    group="file_export"
  }

  plugin:newCommand{
    id="PoinkLegacyExport",
    title="Legacy Export",
    group="poink_export_group",
    onclick=function()
      poink_export()
    end
  }

  plugin:newCommand{
    id="PoinkProjectExport",
    title="Export Project",
    group="poink_export_group",
    onclick=function()
        project_export(plugin)
    end
  }
  --[[
  TODO: export with template and inklecate compilation
    - during dev, no need to set inklecate path (already in system path)
    - for prod, need to make "inklecate path" configurable.
    - move from slices-as-clickables to layers-as-clickables
  ]]

  -- Project & Plugin Settings -------------------------------------------
  plugin:newMenuSeparator{
    group="poink_export_group"
  }

  plugin:newCommand{
    id="PoinkPluginSettings",
    title="Project Settings",
    group="poink_export_group",
    onclick=function()
      print("Not yet implemented.")
    end
  }
  
  plugin:newCommand{
    id="PoinkPluginSettings",
    title="Global Plugin Settings",
    group="poink_export_group",
    onclick=function()
      print("Not yet implemented.")
    end
  }

  --[[
  - plugin settings
    - inklecate path?
  - project/sprite settings
    - main ink file
    - export as gifs or spritesheets?
  ]]

  -- Layer settings -------------------------------------
  --[[
  - Add commands (in context menu and "Layer" menu)
    - create new group in existing 'layer_popup_properties'
    - flatten on export? (for groups, false by default)
    - clickable? (true by default)
    - clickable only? (false by default)
  ]]

end

function exit(plugin)
    --
end

