local dap = require("dap")
dap.adapters.codelldb = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
        command = "/Users/marius/Downloads/codelldb-aarch64-darwin/extension/adapter/codelldb",
        args = {"--port", "${port}", "--liblldb", "/Applications/Xcode_15.2_beta.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"}
    }
}

dap.configurations.swift = {
    {
        name = "Build app and launch lldb",
        type = "codelldb",
        request = "launch",
        program = function()
            vim.fn.system("swift build")
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.build/debug/App", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false
    },
    {
        name = "Debug tests",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false
    }
}
