;;; org-config.el -- Description -*- lexical-binding: t; -*-

(setq org-directory "~/docs/notes/org")

(with-eval-after-load 'org
  (setq org-edit-src-content-indentation 0
        org-hide-leading-stars           t
		org-return-follows-link  t)) ;; Setting RETURN key in org-mode to follow links

(use-package org-modern
  :hook (org-mode . org-modern-mode)
  :init
  (setq org-modern-star '("●" "○" "◆" "◇" "▸")))

(use-package toc-org
  :after org
  :commands toc-org-enable
  :hook
  (org-mode . toc-org-enable))

(use-package hl-todo
  :hook
  ((org-mode . hl-todo-mode)
   (prog-mode . hl-todo-mode)))

(use-package org-download
  :after org
  :hook ((org-mode . org-download-enable)
		 (dired    . org-download-enable))
  :config
  (setq-default org-download-image-dir "~/docs/notes/org/attachments")
  (setq org-download-heading-lvl nil)
  (setq org-download-timestamp "%Y%m%d-%H%M%S_"))

(use-package org-roam
  :hook (org-mode . org-roam-db-autosync-mode)
  :commands (org-roam-node-find
			 org-roam-node-insert
			 org-roam-dailies-goto-today
			 org-roam-buffer-toggle
			 org-roam-db-sync
			 org-roam-capture)
  :init
  (setq org-roam-directory "~/docs/notes/org/roam"
		org-roam-database-connector 'sqlite-builtin
		org-roam-completion-everywhere t
		org-roam-db-location (expand-file-name "org-roam.db" "~/docs/notes/org/roam")
		org-roam-v2-ack t)
  :config
  (unless (file-exists-p org-roam-directory)
	(make-directory org-roam-directory t)))

(use-package org-roam-ui
  :commands (org-roam-ui-mode org-roam-ui-open)
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
		org-roam-ui-follow t
		org-roam-ui-update-on-save t
		org-roam-ui-open-on-start nil))

(use-package ox-typst
  :after org)

(provide 'org-config)
;;; org-config.el ends here
