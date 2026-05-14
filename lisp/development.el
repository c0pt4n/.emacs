;;; development.el -- Coding stack -*- lexical-binding: t; -*-

(use-package treesit
  :ensure nil
  :init
  (setq major-mode-remap-alist
	'((c-mode          . c-ts-mode)
	  (go-mode         . go-ts-mode)
	  (bash-mode       . bash-ts-mode)
	  (html-mode       . html-ts-mode)
	  (python-mode     . python-ts-mode)
	  (json-mode       . json-ts-mode)
	  (yaml-mode       . yaml-ts-mode)
	  (conf-toml-mode  . toml-ts-mode)
	  (javascript-mode . js-ts-mode)))
  (setq treesit-language-source-alist
   '((c           "https://github.com/tree-sitter/tree-sitter-c")
     (go          "https://github.com/tree-sitter/tree-sitter-go")
     (gomod       "https://github.com/camdencheek/tree-sitter-go-mod")
     (bash        "https://github.com/tree-sitter/tree-sitter-bash")
     (html        "https://github.com/tree-sitter/tree-sitter-html")
     (json        "https://github.com/tree-sitter/tree-sitter-json")
     (toml        "https://github.com/tree-sitter/tree-sitter-toml")
     (yaml        "https://github.com/ikatyang/tree-sitter-yaml")
     (python      "https://github.com/tree-sitter/tree-sitter-python")
     (markdown    "https://github.com/ikatyang/tree-sitter-markdown")
     (javascript  "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")))
  :config
  (dolist (lang treesit-language-source-alist)
    (let ((lang-name (car lang)))
      (unless (treesit-language-available-p lang-name)
        (message "Installing tree-sitter grammar for %s..." lang-name)
        (treesit-install-language-grammar lang-name)))))

(dolist (entry '(("\\.go\\'"     . go-ts-mode)
                 ("go\\.mod\\'"  . go-mod-ts-mode)
                 ("go\\.sum\\'"  . go-mod-ts-mode)
                 ("\\.c\\'"      . c-ts-mode)
                 ("\\.h\\'"      . c-ts-mode)))
  (add-to-list 'auto-mode-alist entry))

;; YASNIPPET
;; No :defer — yas-global-mode must be live before the first eglot buffer
;; opens or yasnippet-capf serves nothing on first completion attempt.
(use-package yasnippet
  :ensure t
  :demand t
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/snippets")
        yas-verbosity    0)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :demand t
  :after yasnippet)

(use-package yasnippet-capf
  :ensure t
  :demand t
  :custom
  (yasnippet-capf-lookup-by 'key))

(elpaca-wait)

(add-hook 'org-mode-hook
          (lambda ()
            (setq-local completion-at-point-functions
                        (list #'yasnippet-capf
                              #'cape-dabbrev
                              #'cape-file
                              #'pcomplete-completions-at-point
                              #'ispell-completion-at-point))))

;; See go-mode snippets
(add-hook 'go-ts-mode-hook #'(lambda () (yas-activate-extra-mode 'go-mode)))

(provide 'development)
