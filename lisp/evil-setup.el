;;; evil-setup.el -*- lexical-binding: t; -*-

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
;; Using RETURN to follow links in Org/Evil
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
(setq org-return-follows-link  t)
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

(provide 'evil-setup)
