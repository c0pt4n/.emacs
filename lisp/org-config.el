;;; org-config.el -- Description -*- lexical-binding: t; -*-

(setq org-directory "~/docs/notes/org")

(with-eval-after-load 'org
  (setq 
        org-edit-src-content-indentation 0
        org-hide-leading-stars           t)
  (require 'org-tempo))

(use-package toc-org
  :after org
  :commands toc-org-enable
  :hook
  (org-mode . toc-org-enable))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package hl-todo
  :hook
  ((org-mode . hl-todo-mode)
   (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        '(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package org-download
  :after org
  :init
  (add-hook 'org-mode-hook 'org-download-enable)
  (add-hook 'dired-mode-hook 'org-download-enable)
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
	org-roam-v2-ack t)
  :config
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t))) 

 (provide 'org-config)
