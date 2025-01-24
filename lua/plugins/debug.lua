return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      {
        "mfussenegger/nvim-dap",
        config = function()
          local dap = require("dap")
          dap.adapters.chrome = {
            type = "executable",
            command = "node",
            args = { os.getenv("HOME") .. "/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
          }
          dap.configurations.javascriptreact = { -- change this to javascript if needed
            {
              type = "chrome",
              request = "attach",
              -- program = "${file}",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = "inspector",
              port = 3000,
              webRoot = "${workspaceFolder}",
            },
          }

          dap.configurations.typescriptreact = { -- change to typescript if needed
            {
              type = "chrome",
              request = "launch",
              sourceMaps = true,
              url = "http://localhost:3000",
              webRoot = "${workspaceFolder}",
              -- outFiles = { "${workspaceFolder}/.next/**/*.js" },
              resolveSourceMapLocations = { "${workspaceFolder}/", "!/node_modules/**" },
            },
          }
          -- dap.configurations.javascriptreact = { -- change this to javascript if needed
          --   {
          --     type = "chrome",
          --     request = "launch",
          --     name = "Launch React against localhost",
          --     url = "http://localhost:3000",
          --     webRoot = "${workspaceFolder}",
          --   },
          -- }
          --
          -- dap.configurations.typescriptreact = { -- change this to javascript if needed
          --   {
          --     type = "chrome",
          --     request = "launch",
          --     name = "Launch React against localhost",
          --     url = "http://localhost:3000",
          --     webRoot = "${workspaceFolder}",
          --   },
          -- }
        end,
      },
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}