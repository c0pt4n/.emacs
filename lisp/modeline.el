;;; modeline.el -*- lexical-binding: t; -*-

(use-package nerd-icons :demand t)

(use-package doom-modeline
  :demand t
  :config
  (setq doom-modeline-icon t)
  :init
  (doom-modeline-mode 1))

(provide 'modeline)
