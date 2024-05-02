return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzy-native.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      dependencies = {
        "junegunn/fzf.vim",
        dependencies = {
          "tpope/vim-dispatch",
          cmd = { "Make", "Dispatch" },
          {
            "junegunn/fzf",
            build = ":call fzf#install()",
          },
        },
      },
    },
    { "nvim-lua/popup.nvim" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-file-browser.nvim",
    "folke/todo-comments.nvim",
  },
  config = function()
    -- select_dir_for_grep = function(prompt_bufnr)
    --   local action_state = require("telescope.actions.state")
    --   local fb = require("telescope").extensions.file_browser
    --   local lga = require("telescope").extensions.live_grep_args
    --   local current_line = action_state.get_current_line()
    -- end

    local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")
    local purple1 = "#333352"
    local purple2 = "#232338"
    local purple3 = "#12121c"
    local red1 = "#ba3648"
    local green1 = "#37ad39"
    local blue1 = "#0985de"

    ----------------------------------------------------------------------
    --                              Prompt                              --
    ----------------------------------------------------------------------
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", {
      fg = purple3,
      bg = purple3,
    })

    vim.api.nvim_set_hl(0, "TelescopePromptNormal", {
      fg = normal_hl.foreground,
      bg = purple3,
    })

    vim.api.nvim_set_hl(0, "TelescopePromptTitle", {
      fg = normal_hl.foreground,
      bg = red1,
    })

    vim.api.nvim_set_hl(0, "TelescopePromptCounter", {
      fg = red1,
      bg = purple3,
    })

    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {
      fg = red1,
      bg = purple3,
    })
    ----------------------------------------------------------------------
    --                              Result                              --
    ----------------------------------------------------------------------
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {
      fg = purple2,
      bg = purple2,
    })

    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {
      fg = normal_hl.foreground,
      bg = purple2,
    })

    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", {
      fg = normal_hl.foreground,
      bg = blue1,
    })

    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", {
      fg = blue1,
      bg = vim.api.nvim_get_hl_by_name("TelescopeSelection", true).background,
    })
    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        path_display = { "smart" },
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.95,
          height = 0.85,
          -- preview_cutoff = 120,
          prompt_position = "top",
        },
        --borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        file_ignore_patterns = {
          "^.git/.*$",
          "dist",
          "target",
          "node_modules",
          "pack/plugins",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
        },

        --         mapping = {
        --               i = {
        --                 ["<C-p>"] = select_dir_for_grep,
        --                 ["<C-s>"] = lga_actions.quote_prompt({ postfix = ' -t'}),
        --             },
        --         },
        --       },
        --   file_browser {
        --     auto_depth = true,
        --     display_stat = false,
        --     grouped = true,
        --     hide_parent_dir = true,
        --         mappings = {
        --           i = {
        --           ['N'] = fb_actions.create,
        --           ['!'] = fb_actions.remove,
        --           --fb actions.move ,
        --           --fb_actions.rename ,
        --         },
        --       },
        --     select_buffer = true,
        --     },
        --   },
      },
    })
    telescope.load_extension("fzf")
    require("telescope").load_extension("file_browser")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
