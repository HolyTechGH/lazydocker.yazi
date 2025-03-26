-- Modified from https://github.com/Lil-Dank/lazygit.yazi

return {
    entry = function()
        local output = Command("docker"):arg("ps"):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "lazydocker",
                content = "Docker ps did not pass",
                level = "warn",
                timeout = 5,
            })
        else
            permit = ya.hide()
            local output, err_code = Command("lazydocker"):stderr(Command.PIPED):output()
            if err_code ~= nil then
                ya.notify({
                    title = "Failed to run lazydocker command",
                    content = "Status: " .. err_code,
                    level = "error",
                    timeout = 5,
                })
            elseif not output.status.success then
                ya.notify({
                    title = "lazydocker in" .. cwd .. "failed, exit code " .. output.status.code,
                    content = output.stderr,
                    level = "error",
                    timeout = 5,
                })
            end
        end
    end,
}

