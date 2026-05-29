;;; early-init.el --- Description -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

;;; Fonts
(set-face-attribute 'default nil
					:family "IBM Plex Mono"
					:height 120
					:weight 'regular)
(set-face-attribute 'variable-pitch nil
					:family "IBM Plex Sans"
					:height 130
					:weight 'regular)
(set-face-attribute 'fixed-pitch nil
					:family "IBM Plex Mono"
					:height 120
					:weight 'regular)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono-12"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)
(set-face-background 'mouse "#ffffff")

(setq native-comp-async-report-warnings-errors 'silent)
