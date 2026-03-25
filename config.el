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

;; Expands to: (elpaca evil (use-package evil :demand t))
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
  (evil-define-key 'insert global-map (kbd "C-v") 'clipboard-yank)
  (evil-mode 1))
(use-package evil-collection
  :straight t
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))
(use-package evil-tutor :straight t)

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
    "b" '(:ignore t :wk "buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-current-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Previous buffer"))
  )

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

(use-package nord-theme
  :straight t
  :init
  (load-theme 'nord t))

(use-package org-bullets
  :straight t
  :hook (org-mode . org-bullets-mode))

(require 'org-tempo)

(use-package toc-org
  :straight t
  :commands toc-org-enable
  :hook (org-mode-hook . toc-org-enable))

(electric-pair-mode 1)
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  )
(menu-bar-mode -1)
(blink-cursor-mode -1)
(global-display-line-numbers-mode)
(setq scroll-margin 8)
(setq display-line-numbers-type 'relative)
(setq make-backup-files nil)
(setq auto-save-default nil)
