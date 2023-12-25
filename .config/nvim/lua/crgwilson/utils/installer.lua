local random = math.random
local fn = vim.fn

local M = {}

local function new_uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and random(0, 0xf) or random(8, 0xb)
        return string.format("%x", v)
    end)
end

local function download(url, path)
    fn.system({
        "wget",
        url,
        "-O",
        path,
    })
end

function M.install_from_git(repo, path)
    fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        repo,
        path,
    })
    vim.notify("Installing git repository " .. repo, 3)
end

function M.install_from_tar(url, path)
    local tmp_file = "/tmp/" .. new_uuid() .. ".tar.gz"
    download(url, tmp_file)

    fn.system({
        "mkdir",
        "-p",
        path,
    })

    fn.system({
        "tar",
        "-xzvf",
        tmp_file,
        "-C",
        path,
        "--strip-components",
        "1",
    })

    fn.system({
        "rm",
        tmp_file,
    })
end

return M
