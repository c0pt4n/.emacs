;;; pdf-setup.el --- Open PDF in Emacs -*- lexical-binding:t; -*-

(use-package pdf-tools
  :ensure t
  :defer t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query)
  (setq pdf-view-display-size 'fit-page
        pdf-view-continuous t
        pdf-view-midnight-colors '("#d4c9a8" . "#1c1c1c")
	pdf-view-midnight-colors '("#d8dee9" . "#2e3440")
        pdf-annot-activate-created-annotations t)
  (add-hook 'pdf-view-mode-hook
            (lambda ()
              (pdf-view-midnight-minor-mode 1)
	      (display-line-numbers-mode -1)
              (setq-local mode-line-format nil)))
  (with-eval-after-load 'evil
    (evil-define-key 'normal pdf-view-mode-map
      (kbd "j")   #'pdf-view-next-line-or-next-page
      (kbd "k")   #'pdf-view-previous-line-or-previous-page
      (kbd "J")   #'pdf-view-next-page
      (kbd "K")   #'pdf-view-previous-page
      (kbd "gg")  #'pdf-view-first-page
      (kbd "G")   #'pdf-view-last-page
      (kbd "C-d") #'pdf-view-scroll-up-or-next-page
      (kbd "C-u") #'pdf-view-scroll-down-or-previous-page
      (kbd "+")   #'pdf-view-enlarge
      (kbd "-")   #'pdf-view-shrink
      (kbd "=")   #'pdf-view-fit-page-to-window
      (kbd "a")   #'pdf-view-fit-page-to-window
      (kbd "s")   #'pdf-view-fit-width-to-window
      (kbd "m")   #'pdf-view-set-slice-from-bounding-box
      (kbd "M")   #'pdf-view-reset-slice
      (kbd "i")   #'pdf-view-midnight-minor-mode  ;; toggle midnight
      (kbd "y")   #'pdf-view-kill-ring-save
      (kbd "/")   #'isearch-forward
      (kbd "n")   #'isearch-repeat-forward
      (kbd "N")   #'isearch-repeat-backward
      (kbd "q")   #'quit-window)))

(provide 'pdf-setup)
