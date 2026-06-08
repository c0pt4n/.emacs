;;; theme.el --- Nord theme -*- lexical-binding: t; -*-

(use-package catppuccin-theme
  :ensure (catppuccin-theme :host github :repo "catppuccin/emacs" :files ("*.el"))
  :init
  (setq catppuccin-flavor 'macchiato)) ;; or 'latte, 'macchiato, or 'mocha

(use-package tron-legacy-theme
  :init
  (load-theme 'tron-legacy t))

(provide 'theme)
;;; theme.el ends here
