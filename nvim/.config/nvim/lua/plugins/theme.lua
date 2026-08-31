return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = false,

      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },

      on_highlights = function(hl, _)
        -- Remove italics everywhere
        for _, group in pairs(hl) do
          if type(group) == "table" then
            group.italic = false
          end
        end
      end,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = false,
      no_italic = true,
    },
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      -- Gruvbox Material Dark Hard
      vim.g.gruvbox_material_background = "hard"

      -- Let Kitty handle terminal opacity
      vim.g.gruvbox_material_transparent_background = 2

      -- No italics anywhere
      vim.g.gruvbox_material_enable_italic = false
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
