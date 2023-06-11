update = require("update")

local at_version = fs.open("version.lua", "r").readAll()
local new_version = update.get_git("version.lua")
if at_version ~= new_version then
  print("updating from "..at_version)
  local files = update.update()
  print("updated to "..new_version..", "..tostring(files).." files downloaded.")
else
  print("up to date at "..at_version)
end