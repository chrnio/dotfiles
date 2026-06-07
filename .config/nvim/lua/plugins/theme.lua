return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,

    config = function()
      require("cyberdream").setup({
        transparent = true,
        italic_comments = false,
        hide_fillchars = false,
        borderless_telescope = true,

        terminal_colors = true,

        overrides = function(colors)
          return {
            Normal = { bg = "NONE" },
            NormalNC = { bg = "NONE" },
            NormalFloat = { bg = "NONE" },
            FloatBorder = { bg = "NONE" },

            SignColumn = { bg = "NONE" },
            FoldColumn = { bg = "NONE" },
            EndOfBuffer = { bg = "NONE" },

            LineNr = {
              bg = "NONE",
              fg = colors.grey,
            },

            CursorLineNr = {
              bg = "NONE",
              fg = colors.magenta,
            },

            CursorLine = {
              bg = colors.bgHighlight,
            },

            StatusLine = { bg = "NONE" },
            StatusLineNC = { bg = "NONE" },

            TabLine = { bg = "NONE" },
            TabLineFill = { bg = "NONE" },

            TabLineSel = {
              bg = "NONE",
              fg = colors.blue,
            },

            WinSeparator = {
              bg = "NONE",
              fg = colors.grey,
            },

            Pmenu = {
              bg = colors.bgAlt,
              fg = colors.fg,
            },

            PmenuSel = {
              bg = colors.bgHighlight,
              fg = colors.fg,
              bold = true,
            },

            PmenuSbar = {
              bg = colors.bgAlt,
            },

            PmenuThumb = {
              bg = colors.grey,
            },

            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = {
              bg = "NONE",
              fg = colors.grey,
            },

            TelescopePromptNormal = { bg = "NONE" },

            TelescopePromptBorder = {
              bg = "NONE",
              fg = colors.blue,
            },

            TelescopeResultsNormal = { bg = "NONE" },
            TelescopePreviewNormal = { bg = "NONE" },

            DiagnosticVirtualTextError = {
              bg = "NONE",
              fg = colors.red,
            },

            DiagnosticVirtualTextWarn = {
              bg = "NONE",
              fg = colors.yellow,
            },

            DiagnosticVirtualTextInfo = {
              bg = "NONE",
              fg = colors.cyan,
            },

            DiagnosticVirtualTextHint = {
              bg = "NONE",
              fg = colors.green,
            },
          }
        end,
      })

      vim.cmd.colorscheme("cyberdream")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
}
