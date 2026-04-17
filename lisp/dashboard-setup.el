;;; dashboard-setup.el -*- lexical-binding: t; -*-

(use-package dashboard
  :init
   (setq initial-buffer-choice 'dashboard-open)
   (setq doom-fallback-buffer-name "*dashboard*")
   (add-hook 'doom-enter-frame-hook #'dashboard-open)
   (setq dashboard-startup-banner 'logo)
   (setq dashboard-banner-logo-title "Greetings, hack!")
   (setq dashboard-set-heading-icons t)
   (setq dashboard-footer-icon "☠")
   (setq dashboard-footer-messages '("Eat, Sleep, Hack, Repeat..."))
   (setq initial-scratch-message nil)
  :config
   (dashboard-setup-startup-hook))

(provide 'dashboard-setup)
