;;; magit-config.el --- Git integration -*- lexical-binding: t; -*-

(use-package magit-section :demand t)
(elpaca-wait)

(use-package magit
  :hook (git-commit-mode . meow-insert)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
        magit-bury-buffer-function #'magit-restore-window-configuration)
  (define-key magit-status-mode-map (kbd "p") #'magit-push)
  (define-key magit-status-mode-map (kbd "SPC") nil)
  (define-key magit-log-mode-map (kbd "SPC") nil)
  (define-key magit-diff-mode-map (kbd "SPC") nil))

(use-package git-gutter
  :init
  (global-git-gutter-mode +1))

(provide 'magit-config)
;;; magit-config.el ends here
