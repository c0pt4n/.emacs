(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package evil
  :straight t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-default-cursor 'box)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'box)
  (setq evil-visual-state-cursor 'box)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-d-scroll t)
  (setq select-enable-clipboard nil)
  (setq select-enable-primary nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-define-key 'visual global-map (kbd "SPC y") 'clipboard-kill-ring-save)
  (evil-define-key 'visual global-map (kbd "SPC d") 'cliboard-kill-region)
  (evil-define-key 'insert global-map (kbd "C-v") 'clipboard-yank)
  (evil-mode 1))
(use-package evil-collection
  :straight t
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))
(use-package evil-tutor :straight t)

;; Using RETURN to follow links in Org/Evil
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
(setq org-return-follows-link  t)

(use-package general
  :straight t
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer me/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (me/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find file"))

  (me/leader-keys
    "b" '(:ignore t :wk "Buffers")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-current-buffer :wk "Kill this buffer")
    "b K" '(kill-some-buffer :wk "Kill multiple buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

  (me/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired"))

  (me/leader-keys
    "f" '(:ignore t :wk "Files")
    "f c" '((lambda() (interactive)
	      (find-file (expand-file-name "config.org" user-emacs-directory)))
	    :wk "Open emacs config.org")
    "f e" '((lambda() (interactive)
	      (dired user-emacs-directory))
	    :wk "Open user-emacs-directory in dired")
    "f r" '(counsel-recentf :wk "Find recent files"))

  (me/leader-keys
    "w" '(:ignore t :wk "Window")
    "w s" '(evil-window-split :wk "Horizontal split")
    "w v" '(evil-window-vsplit :wk "Vertical split")
    "w h" '(evil-window-left :wk "Window left")
    "w l" '(evil-window-right :wk "Window right")
    "w k" '(evil-window-up :wk "Window up")
    "w j" '(evil-window-down :wk "Window down")
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window"))
  )

(use-package nerd-icons
  :straight t
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :straight t
  :hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))

(set-face-attribute 'default nil
  :font "IBM Plex Mono"
  :height 120
  :weight 'regular)
(set-face-attribute 'variable-pitch nil
  :font "IBM Plex Sans"
  :height 130
  :weight 'regular)
(set-face-attribute 'fixed-pitch nil
  :font "IBM Plex Mono"
  :height 120
  :weight 'regular)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono-12"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)
(set-face-background 'mouse "#ffffff")

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package dashboard
  :straight t
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

(use-package nord-theme :straight t)

(use-package tron-legacy-theme
  :straight t
  :init
  (load-theme 'tron-legacy t))

(setq org-directory "~/docs/notes/org")

(use-package org-bullets
  :straight t
  :hook (org-mode . org-bullets-mode))

(require 'org-tempo)

(use-package toc-org
  :straight t
  :commands toc-org-enable
  :hook (org-mode-hook . toc-org-enable))

(use-package hl-todo
  :straight t
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package ivy
  :straight t
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package nerd-icons-ivy-rich
  :straight t
  :init (nerd-icons-ivy-rich-mode 1))

(use-package counsel
  :straight t
  :after ivy
  :config
    (counsel-mode)
    (setq ivy-initial-inputs-alist nil)) ;; removes starting ^ regex in M-x

(use-package ivy-rich
  :after ivy
  :straight t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package pdf-tools
  :straight t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)
                                                         (blink-cursor-mode -1)))

(electric-pair-mode 1)
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(global-display-line-numbers-mode)
(setq scroll-margin 8)
(setq display-line-numbers-type 'relative)
(setq make-backup-files nil)
(setq auto-save-default nil)

(use-package which-key
  :init
  (which-key-mode 1)
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))
