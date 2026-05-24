;;; vterm-config.el --- Description -*- lexical-binding: t; -*-

(use-package vterm
  :init
  (setq vterm-timer-delay 0.05
	vterm-max-scrollback 5000)
  :config
  (setq vterm-buffer-name-string "vterm %s"))

(use-package vterm-toggle)

(provide 'vterm-config)
