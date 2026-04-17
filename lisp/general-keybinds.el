;;; general-keybinds.el --- General Keybindings -*- lexical-binding: t; -*-

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
	      (find-file (expand-file-name "init.el" user-emacs-directory)))
	    :wk "Open emacs init.el")
    "f e" '((lambda() (interactive)
	      (dired user-emacs-directory))
	    :wk "Open user-emacs-directory in dired"))

  (me/leader-keys
    "n r" '(:ignore t :wk "Org roam")
    "n r f" '(org-roam-node-find :wk "Find node")
    "n r i" '(org-roam-node-insert :wk "Insert node"))

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

(provide 'general-keybinds)
