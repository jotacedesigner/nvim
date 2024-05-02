return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
    plugins = {
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = true,
        g = false,
      },
    },

    icons = {
      breadcrumb = "",
      separator = " ",
      group = "",
    },
    layout = {
      spacing = 5,
      align = "center",
    },
    show_help = false,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["]"] = { name = "Next" },
        ["["] = { name = "Prev" },
        ["<leader>"] = {
          b = { name = " Buffer" },
          c = { name = " Code" },
          d = { name = " Debug" },
          f = { name = " Find" },
          g = { name = " Git" },
          l = { name = " LSP" },
          m = { name = " Markdown" },
          n = { name = "󰵚 Notification" },
          t = { name = " Test" },
          o = { name = "󰘵 Option" },
        },
      })
    end,
  },
}
