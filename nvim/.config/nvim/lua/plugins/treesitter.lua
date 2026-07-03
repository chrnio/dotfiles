return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Vim
        "vim",
        "vimdoc",
        "query",

        -- Lua
        "lua",
        "luadoc",

        -- Shell
        "bash",
        "fish",

        -- Nix
        "nix",

        -- Web
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "json5",
        "jsonc",

        -- Node/Bun
        "jsdoc",

        -- Rust
        "rust",

        -- Go
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- Java
        "java",

        -- C/C++
        "c",
        "cpp",

        -- Config
        "toml",
        "yaml",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        -- Markdown
        "markdown",
        "markdown_inline",

        -- Regex
        "regex",

        -- SQL
        "sql",

        -- Misc
        "diff",
        "printf",
        "comment",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
      },
    },
  },
}
