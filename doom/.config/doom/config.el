;; user
(setq user-full-name "Charan Vadapalli"
      user-mail-address "sree.saicharan.vadapalli@gmail.com")

;; font
(setq doom-font
      (font-spec :family "Maple Mono Normal" :size 14 :weight 'medium))

(setq doom-variable-pitch-font
      (font-spec :family "Adwaita Sans" :size 16))

;; theme
(setq doom-theme 'doom-one)
;;(setq catppuccin-flavor 'mocha)

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
