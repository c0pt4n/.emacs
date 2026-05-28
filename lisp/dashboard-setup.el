;;; dashboard-setup.el --- Startup dashboard -*- lexical-binding: t; -*-

(use-package dashboard
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-banner-logo-title "Greetings, hack!")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-footer-icon "☠")
  (setq dashboard-footer-messages '("Eat, Sleep, Hack, Repeat..."))
  (setq initial-scratch-message nil)
  :config
  (add-hook 'elpaca-after-init-hook #'dashboard-insert-startupify-lists)
  (add-hook 'elpaca-after-init-hook #'dashboard-initialize)
  (dashboard-setup-startup-hook))

(provide 'dashboard-setup)
;;; dashboard-setup.el ends here
