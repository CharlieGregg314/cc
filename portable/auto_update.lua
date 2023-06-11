function get_git(path)
  return http.get("https://raw.githubusercontent.com/CharlieGregg314/cc/master/portable/"..path).readAll()
end

function split(value, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(value, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function update()
  local files = split(get_git("file_list"), "\n")
  for i, path in pairs(files) do
    local dir = string.match(path, ".+(?=/)")
    -- local file = string.match(path, "[^/]+$")
    if dir ~= nil and not fs.exists(dir) then
      fs.makeDir(dir)
    end
    f = fs.open(path, "w")
    f.write(get_git(path))
    f.close()
  end
  return #files
end

local at_version = fs.open("version.lua", "r").readAll()
local new_version = get_git("version.lua")
if at_version ~= new_version then
  print("updating from version: "..at_version)
  local files = update()
  print("updated to version: "..new_version..", "..tostring(files).." files downloaded.")
end