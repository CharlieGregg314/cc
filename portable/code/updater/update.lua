local update = {}
function update.get_git(path)
    return http.get("https://raw.githubusercontent.com/CharlieGregg314/cc/master/portable/" .. path,
        { ["Cache-Control"] = "no-cache" }).readAll()
end

function split(value, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(value, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function update.force_update()
    fs.delete("/code")
    local files = split(update.get_git("file_list"), "\n")
    for i, path in pairs(files) do
        local dir = string.match(path, ".+(?=/)")
        -- local file = string.match(path, "[^/]+$")
        if dir ~= nil and not fs.exists(dir) then
            fs.makeDir(dir)
        end
        f = fs.open(path, "w")
        f.write(update.get_git(path))
        f.close()
    end
    return #files
end
function update.check_for_update() 
    local at_version = fs.open("version.lua", "r").readAll()
    local new_version = update.get_git("version.lua")
    if at_version ~= new_version then
    print("updating from "..at_version)
    local files = update.force_update()
    print("updated to "..new_version..", "..tostring(files).." files downloaded.")
    else
    print("up to date at "..at_version)
    end
end
return update