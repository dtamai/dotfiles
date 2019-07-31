;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(set-frame-font "Source Code Variable")
(set-face-attribute 'default nil :height 140)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (tide-setup)
              (flycheck-mode +1)
              (eldoc-mode +1) )))

(setq rust-format-on-save t)
(setq persp-auto-save-opt 0)
(setq-default line-spacing 8
              js-indent-level 2)

(setq web-mode-markup-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2
      css-indent-offset 2)

(setq-default display-line-numbers-type 'relative)
