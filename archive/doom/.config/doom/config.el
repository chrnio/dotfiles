;; user
(setq user-full-name "Charan Vadapalli"
      user-mail-address "sree.saicharan.vadapalli@gmail.com")

;; font
(setq doom-font
      (font-spec :family "JetBrainsMono NF" :size 14 :weight 'medium))

(setq doom-variable-pitch-font
      (font-spec :family "Adwaita Sans" :size 16))

;; theme
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha)

;; opacity
(set-frame-parameter nil 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; line numbers
(setq display-line-numbers-type 'relative)

;; org dir
(setq org-directory "~/org/")

(use-package! markdown-mode
  :hook ((markdown-mode . visual-line-mode)
         (markdown-mode . mixed-pitch-mode)
         (markdown-mode . visual-fill-column-mode))
  :config
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t))

(use-package! kdl-ts-mode
  :mode ("\\.kdl\\'" . kdl-ts-mode))

(after! treesit
  (add-to-list 'treesit-language-source-alist
               '(kdl "https://github.com/tree-sitter-grammars/tree-sitter-kdl")))

(setq +format-on-save-enabled-modes t)

(after! format
  ;; KDL
  (set-formatter! 'kdlfmt
    '("kdlfmt" "format" filepath)
    :modes '(kdl-ts-mode))

  ;; Rust
  (set-formatter! 'rustfmt
    '("rustfmt")
    :modes '(rust-mode))

  ;; Go
  (set-formatter! 'goimports
    '("goimports")
    :modes '(go-mode))

  ;; JS / TS
  (set-formatter! 'prettier
    '("prettier" "--stdin-filepath" filepath)
    :modes '(js-mode
             js-ts-mode
             typescript-mode
             typescript-ts-mode
             tsx-ts-mode
             json-mode
             json-ts-mode
             css-mode
             css-ts-mode
             html-mode
             html-ts-mode
             yaml-mode
             markdown-mode))

  ;; C/C++
  (set-formatter! 'clang-format
    '("clang-format")
    :modes '(c-mode
             c++-mode
             c-ts-mode
             c++-ts-mode))

  ;; Shell
  (set-formatter! 'shfmt
    '("shfmt")
    :modes '(sh-mode))

  ;; Lua
  (set-formatter! 'stylua
    '("stylua" "-")
    :modes '(lua-mode))

  ;; TOML
  (set-formatter! 'taplo
    '("taplo" "fmt" "-")
    :modes '(toml-mode toml-ts-mode))

  ;; Nix
  (set-formatter! 'nixfmt
    '("nixfmt")
    :modes '(nix-mode))

  ;; Python
  (set-formatter! 'ruff
    '("ruff" "format" "-")
    :modes '(python-mode))

  ;; Ruby
  (set-formatter! 'rubocop
    '("rubocop" "-A" "--stdin" filepath)
    :modes '(ruby-mode)))
