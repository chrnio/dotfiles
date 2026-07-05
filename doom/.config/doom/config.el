;; user
(setq user-full-name "Charan Vadapalli"
      user-mail-address "sree.saicharan.vadapalli@gmail.com")

;; font
(setq doom-font
      (font-spec :family "Maple Mono Normal" :size 15 :weight 'medium))

(setq doom-variable-pitch-font
      (font-spec :family "Adwaita Sans" :size 16))

;; theme
(setq doom-theme 'doom-one)
;;(setq catppuccin-flavor 'mocha)

;; line numbers
(setq display-line-numbers-type 'relative)

;; org dir
(setq org-directory "~/org/")

(after! markdown-mode
  (add-hook 'markdown-mode-hook #'visual-line-mode)
  (add-hook 'markdown-mode-hook #'mixed-pitch-mode)
  (add-hook 'markdown-mode-hook #'visual-fill-column-mode))
