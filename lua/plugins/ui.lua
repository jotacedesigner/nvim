local header = {
  thor = [[
    ████████╗██╗  ██╗ ██████╗ ██████╗
    ╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗
       ██║   ███████║██║   ██║██████╔╝
       ██║   ██╔══██║██║   ██║██╔══██╗
       ██║   ██║  ██║╚██████╔╝██║  ██║
       ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
  ]],
}
local logo = string.rep("\n\n", 1) .. header.thor .. "\n"
return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
      theme = "hyper",
      config = {
        header = vim.split(logo, "\n"),
        center = {},
        shortcut = {
          { desc = " Upadate ", group = "@property", action = "Lazy update", key = "u" },
          {
            desc = "Find File ",
            keymap = "",
            key = "f",
            icon = "  ",
            icon_h1 = "@variable",
            group = "Label",
            action = "Telescope find_files",
          },
          { desc = " Apps ", group = "DiagnosticHint", actions = "Telescope app", key = "a" },
          { desc = "New File", group = "dashboardShortCut", keymap = "", key = "n", icon = "  ", action = "enew" },
          {
            desc = "Manage Extensions",
            group = "@commands",
            keymap = "",
            key = "e",
            icon = "  ",
            action = "Mason",
          },
        },
        --vim.cmd("highlight  DashboardRecentFiles guifg=#d78698"),
        mru = {
          limit = 6,
          group = "DashboardIcon",
          icon = "  ",
          label = "Recent Files",
          cwd_only = false,
        },
        footer = function()
          vim.cmd("highlight DashboardFooter guifg=#d78700")
          return {
            "", -- Este es el salto de línea agregado
            "JotaCe Designer  " .. os.date(" %H:%M \t 󰃭 %a,%d %b") .. "",
          }
        end,
      },
    },
  },
}
