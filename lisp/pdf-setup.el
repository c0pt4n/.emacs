;;; pdf-setup.el --- Open PDF in Emacs -*- lexical-binding:t; -*-

(use-package pdf-tools
  :ensure t
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
              (setq-local mode-line-format nil)))
  (with-eval-after-load 'pdf-tools
      (define-key pdf-view-mode-map (kbd "j") #'pdf-view-next-line-or-next-page)
      (define-key pdf-view-mode-map (kbd "k") #'pdf-view-previous-line-or-previous-page)
      (define-key pdf-view-mode-map (kbd "J") #'pdf-view-next-page)
      (define-key pdf-view-mode-map (kbd "K") #'pdf-view-previous-page)
      (define-key pdf-view-mode-map (kbd "gg") #'pdf-view-first-page)
      (define-key pdf-view-mode-map (kbd "G") #'pdf-view-last-page)
      (define-key pdf-view-mode-map (kbd "C-d") #'pdf-view-scroll-up-or-next-page)
      (define-key pdf-view-mode-map (kbd "C-u") #'pdf-view-scroll-down-or-previous-page)
      (define-key pdf-view-mode-map (kbd "+") #'pdf-view-enlarge)
      (define-key pdf-view-mode-map (kbd "-") #'pdf-view-shrink)
      (define-key pdf-view-mode-map (kbd "=") #'pdf-view-fit-page-to-window)
      (define-key pdf-view-mode-map (kbd "a") #'pdf-view-fit-page-to-window)
      (define-key pdf-view-mode-map (kbd "s") #'pdf-view-fit-width-to-window)
      (define-key pdf-view-mode-map (kbd "m") #'pdf-view-set-slice-from-bounding-box)
      (define-key pdf-view-mode-map (kbd "M") #'pdf-view-reset-slice)
      (define-key pdf-view-mode-map (kbd "i") #'pdf-view-midnight-minor-mode)  ;; toggle midnight
      (define-key pdf-view-mode-map (kbd "y") #'pdf-view-kill-ring-save)
      (define-key pdf-view-mode-map (kbd "/") #'isearch-forward)
      (define-key pdf-view-mode-map (kbd "n") #'isearch-repeat-forward)
      (define-key pdf-view-mode-map (kbd "N") #'isearch-repeat-backward)
      (define-key pdf-view-mode-map (kbd "q") #'quit-window)))

(provide 'pdf-setup)
;;; pdf-setup.el ends here
