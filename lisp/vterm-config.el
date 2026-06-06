;;; vterm-config.el --- Description -*- lexical-binding: t; -*-

(use-package vterm
  :hook
  (vterm-mode . (lambda ()
                  (setq-local confirm-kill-processes nil
                              mode-line-format nil)))
  :init
  (setq vterm-timer-delay 0.05
		vterm-max-scrollback 5000)
  :config
  (setq vterm-buffer-name-string "vterm %s"))

(use-package vterm-toggle)

(provide 'vterm-config)
;;; vterm-config.el ends here
