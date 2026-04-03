(defvar elpaca-installer-version 0.12)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-sources-directory (expand-file-name "sources/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca-activate)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-sources-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
        (elpaca-use-package-mode))
(elpaca-wait)

(setq use-package-always-defer t
      use-package-always-ensure t
      ;; Testing for package timing
      ;; use-package-compute-statistics t
      use-package-expand-minimally t)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(blink-cursor-mode -1)
(global-display-line-numbers-mode)
(electric-pair-mode 1)
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(setq scroll-margin 8
      display-line-numbers-type 'relative
      make-backup-files nil
      auto-save-default nil
      org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.

(use-package evil
  :demand t
  :init
  (setq evil-want-integration t ;; This is optional since it's already set to t by default.
        evil-want-keybinding nil
        evil-default-cursor 'box
        evil-normal-state-cursor 'box
        evil-insert-state-cursor 'box
        evil-visual-state-cursor 'box
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-want-C-u-scroll t
        evil-want-C-d-scroll t
        select-enable-clipboard nil
        select-enable-primary nil
        evil-undo-system 'undo-redo)
  :config
  (evil-define-key 'visual global-map (kbd "SPC y") 'clipboard-kill-ring-save)
  (evil-define-key 'visual global-map (kbd "SPC d") 'cliboard-kill-region)
  (evil-define-key 'insert global-map (kbd "C-v") 'clipboard-yank)
  (evil-mode 1))
(use-package evil-collection
  :demand t
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))
(use-package evil-commentary
  :demand t
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package general
  :demand t
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer me/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (me/leader-keys
    "." '(find-file :wk "Find file"))

  (me/leader-keys
    "b" '(:ignore t :wk "Buffers")
    "b i" '(ibuffer :wk "Ibuffer")
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
	    :wk "Open user-emacs-directory in dired"))

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

(use-package nord-theme
  :demand t
  :init
  (load-theme 'nord t))

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

(setq org-directory "~/docs/notes/org")

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(require 'org-tempo)

(use-package toc-org
  :commands toc-org-enable
  :hook (org-mode-hook . toc-org-enable))

(use-package hl-todo
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
