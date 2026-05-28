;;; theme.el --- Nord theme -*- lexical-binding: t; -*-

(use-package catppuccin-theme
  :ensure (catppuccin-theme :host github :repo "catppuccin/emacs" :files ("*.el"))
  :init
  (load-theme 'catppuccin :no-confirm)
  :config
  (setq catppuccin-flavor 'frappe) ;; or 'latte, 'macchiato, or 'mocha
  (catppuccin-reload))

(provide 'theme)
;;; theme.el ends here
