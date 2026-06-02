return {
  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = { italic = false },
        variables = { italic = false },
        identifiers = { italic = false },
      },
    },
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      no_italic = true,
    },
  },

  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_disable_italic_comment = 1
    end,
  },

  -- Koda
  {
    "oskarnurm/koda.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local transparent_groups = {
            "Normal",
            "NormalNC",
            "NormalFloat",
            "FloatBorder",
            "SignColumn",
            "EndOfBuffer",
            "StatusLine",
            "StatusLineNC",
            "FoldColumn",
          }

          for _, group in ipairs(transparent_groups) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE" })
          end
        end,
      })
    end,
  },

  -- Default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "koda-dark",
    },
  },
}
