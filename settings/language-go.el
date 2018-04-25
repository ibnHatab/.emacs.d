;;; Code:

(ensure-package-installed
 'go-mode
 'go-playground
 'flycheck-gometalinter
 'go-guru
 'godoctor
 'go-autocomplete
 'go-errcheck
 'go-eldoc
 'gorepl-mode
)
(require 'go-guru)
(require 'go-autocomplete)
(require 'auto-complete-config)
(require 'go-dlv)

(ac-config-default)


(add-hook 'go-mode-hook
          (lambda ()
            (setq tab-width 4)
            (local-set-key (kbd "M-.")       'godef-jump)
            (local-set-key (kbd "C-c C-r")   'go-remove-unused-imports)
            (local-set-key (kbd "C-c C-r")   'go-remove-unused-imports)
            (local-set-key (kbd "C-c i")     'go-goto-imports)
            (local-set-key (kbd "C-c <tab>") 'gofmt-before-save)))

(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
(add-hook 'go-mode-hook #'gorepl-mode)

(provide 'language-go)
;;; language-go.el ends here
