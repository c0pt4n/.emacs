;;; editing.el --- Description -*- lexical-binding: t; -*-

;; fix <> closing automatically in org-mode
(with-eval-after-load 'org
  (add-hook 'org-mode-hook
            (lambda ()
              (setq-local electric-pair-inhibit-predicate
                          (lambda (c)
                            (if (char-equal c ?<)
                                t
                              (electric-pair-conservative-inhibit c)))))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'editing)
;;; editing.el ends here
