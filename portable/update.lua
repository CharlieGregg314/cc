function get_git(path)
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