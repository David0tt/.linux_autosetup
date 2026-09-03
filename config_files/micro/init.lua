local micro = import("micro")
local shell = import("micro/shell")
local homeDirectory = os.getenv("HOME") or "."

local function selectedPath(dialogType, initialPath, title)
    local output, err = shell.ExecCommand(
        "kdialog",
        dialogType,
        initialPath,
        "--title",
        title
    )

    -- kdialog exits with a non-zero status when the user cancels.
    if err ~= nil then
        return nil
    end

    -- ExecCommand includes kdialog's trailing newline.
    return output:gsub("[\r\n]+$", "")
end

local function quotedCommandArgument(value)
    value = value:gsub("\\", "\\\\")
    value = value:gsub('"', '\\"')
    return '"' .. value .. '"'
end

function guiOpen(bp)
    local path = selectedPath("--getopenfilename", homeDirectory, "Open File")
    if path ~= nil and path ~= "" then
        bp:HandleCommand("open " .. quotedCommandArgument(path))
    end
end

function guiSaveAs(bp)
    local path = selectedPath("--getsavefilename", homeDirectory, "Save File As")
    if path ~= nil and path ~= "" then
        bp:HandleCommand("save " .. quotedCommandArgument(path))
    end
end

function guiSave(bp)
    if bp.Buf.Path == "" then
        guiSaveAs(bp)
    else
        bp:Save()
    end
end
