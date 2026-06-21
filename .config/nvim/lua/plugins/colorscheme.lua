return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",

      transparent = true,

      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },

      on_highlights = function(hl, c)
        -- remove italics everywhere
        for _, group in pairs(hl) do
          if type(group) == "table" then
            group.italic = false
          end
        end
      end,
    },
  },
}
