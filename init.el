;; -*- lexical-binding: t; -*-

(add-to-list 'load-path "~/.config/emacs/files/")
(require 'buffer-move)

;; Custom functions
(defun c0/org-present-start ()
  (visual-fill-column-mode 1)
  (visual-line-mode 1)
  (load-theme 'doom-palenight t))

(defun c0/org-present-end ()
  (visual-fill-column-mode 0)
  (visual-line-mode 0)
  (load-theme 'gotham t))

(set-face-attribute 'default nil :height 135)
(setq inhibit-startup-message t)

;; Basic UI settings
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Disable line numbers for some modes
(dolist (hook '(org-mode-hook pdf-view-mode term-mode-hook vterm-mode-hook shell-mode-hook eshell-mode-hook))
  (add-hook hook (lambda () (display-line-numbers-mode -1))))

;; Let the desktop background show through
(set-frame-parameter (selected-frame) 'alpha '(85 . 100))
(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Make ESC quit prompts
(global-set-key [escape] 'keyboard-escape-quit)

(setq make-backup-files nil
      auto-save-default nil
      toggle-truncate-lines t
      use-short-answers t)

;; Zoom in / out
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; Packages ;;

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")
                        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package org
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)
  (setq org-agenda-files
	'("~/docs/notes/todo.org")))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org-present
  :hook
  (org-present-mode . c0/org-present-start)
  (org-present-mode-quit . c0/org-present-end))

(use-package visual-fill-column
  :init
  (setq visual-fill-column-width 110
	visual-fill-column-center-text t))

(use-package gotham-theme)

(use-package tron-legacy-theme
  :config
  (load-theme 'tron-legacy t))

(use-package doom-themes)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons
  :ensure t
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "nsxiv")
                                ("jpg" . "nsxiv")
                                ("png" . "nsxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv")
                                ("webm" . "mpv")
                                ("mp3" . "mpv --no-video"))))

(use-package evil
  :init
  (setq evil-want-keybinding nil
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-undo-system 'undo-redo
        evil-want-C-u-scroll t)
  (evil-mode))

(use-package evil-collection
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help)
  (evil-collection-init))

(use-package general
  :config
  (general-evil-setup)
  (general-create-definer c0/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (c0/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find file")
    "TAB TAB" '(comment-line :wk "Comment lines"))

  (c0/leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    "b b" '(switch-to-buffer :wk "Switch to buffer")
    "b c" '(kill-current-buffer :wk "Kill current buffer")
    "b C" '(kill-some-buffers :wk "Kill multiple buffers")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b k" '(next-buffer :wk "Next buffer")
    "b j" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

  (c0/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired"))

  (c0/leader-keys
    "f" '(:ignore t :wk "Files")
    "f c" '((lambda () (interactive)
              (find-file "~/.config/emacs/init.el"))
            :wk "Open emacs init.el")
    "f e" '((lambda () (interactive)
              (dired "~/.config/emacs/"))
            :wk "Open user-emacs-directory in dired")
    "f g" '(find-grep-dired :wk "Search for string in files in DIR")
    "f d" '(counsel-grep-or-swiper :wk "Search for string current file")
    "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
    "f f" '(fzf :wk "Fuzzy find")
    "f r" '(counsel-recentf :wk "Find recent files")
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f U" '(sudo-edit :wk "Sudo edit file"))

  (c0/leader-keys
    "g" '(:ignore :wk "Git")
    "g g" '(magit-status :wk "Magit status"))

  (c0/leader-keys
    "o" '(:ignore t :wk "Open")
    "o d" '(dashboard-open :wk "Dashboard"))

  (c0/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t v" '(vterm-toggle :wk "Toggle vterm")
    "t e" '(eshell :wk "Toggle eshell"))

  (c0/leader-keys
    "w" '(:ignore t :wk "Windows/Words")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w o" '(delete-other-windows :wk "Close all other windows")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")
    ;; Words
    "w d" '(downcase-word :wk "Downcase word")
    "w u" '(upcase-word :wk "Upcase word")
    "w =" '(count-words :wk "Count words/lines for buffer")))

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
	hl-todo-keyword-faces
	`(("HOLD" . "#cfdf30") ("TODO" . "#feacd0") ("NEXT" . "#b6a0ff")
	  ("THEM" . "#f78fe7") ("PROG" . "#00d3d0") ("OKAY" . "#4ae8fc")
	  ("DONT" . "#80d200") ("FAIL" . "#ff8059") ("BUG" . "#ff8059")
	  ("DONE" . "#44bc44") ("NOTE" . "#f0ce43") ("KLUDGE" . "#eecc00")
	  ("HACK" . "#eecc00") ("TEMP" . "#ffcccc") ("FIXME" . "#ff9977")
	  ("XXX+" . "#f4923b") ("REVIEW" . "#6ae4b9")
	  ("DEPRECATED" . "#bfd9ff"))))

(use-package page-break-lines)

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-startup-banner "~/.config/emacs/images/tron.png")
  (setq dashboard-set-heading-icons t)
  (setq dashboard-banner-logo-title "Greetings, program!")
  ;; (setq dashboard-footer-messages '("Don't trust anyone..."))
  (setq dashboard-footer-messages '("Out there is a new world! Out there is our victory! Out there...is our destiny."))
  (setq dashboard-page-separator  "\n\f\n")
  (setq dashboard-footer-icon "")
  :config
  (dashboard-setup-startup-hook))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package counsel
  :diminish
  :config
    (counsel-mode)
    (setq ivy-initial-inputs-alist nil))

(use-package diminish)

(use-package fzf)

(use-package company
  :diminish
  :custom
  (setq company-backends '(company-capf))
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (company-global-modes '(not eshell-mode))
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  (csharp-mode . lsp-deferred)
  (c-mode . lsp-deferred)
  (cpp-mode . lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-position 'bottom))

(use-package python-mode
  :mode "\\.py\\'"
  :hook (python-mode . lsp-deferred))

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :hook (lsp-deferred . flycheck-mode))

(use-package magit)

(use-package vterm
:config
(setq shell-file-name "/bin/sh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  ;; When running programs in Vterm and in 'normal' mode, make sure that ESC
  ;; kills the program as it would in most standard terminal programs.
  (evil-define-key 'normal vterm-mode-map (kbd "<escape>") 'vterm--self-insert)
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
	       '((lambda (buffer-or-name _)
		   (let ((buffer (get-buffer buffer-or-name)))
		     (with-current-buffer buffer
		       (or (equal major-mode 'vterm-mode)
			   (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
		 (display-buffer-reuse-window display-buffer-at-bottom)
		 (reusable-frames . visible)
		 (window-height . 0.4))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b33955472cb61a721c59c705afda11fea906756d38b3c2eba61698f4e3f82897"
     "3061706fa92759264751c64950df09b285e3a2d3a9db771e99bcbb2f9b470037"
     "7dc1dd6fae32c5840715cecebed8c5a58e43fc855d729d289a770f58f4cbf2c8"
     "77f281064ea1c8b14938866e21c4e51e4168e05db98863bd7430f1352cab294a"
     default))
 '(package-selected-packages
   '(company-box counsel dashboard diminish dired-open doom-modeline
		 doom-themes evil-collection flycheck fzf general
		 gotham-theme hl-todo lsp-ui magit nerd-icons-dired
		 org-bullets org-present pdf-tools python-mode
		 rainbow-delimiters rainbow-mode tron-legacy-theme
		 visual-fill-column vterm-toggle)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))
