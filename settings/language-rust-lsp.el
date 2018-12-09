;;; Code:

(ensure-package-installed
 'rust-mode
 'eglot
 'racer
 'cargo
 )


(add-hook 'rust-mode-hook 'eglot-ensure)
(setq rust-format-on-save t)

(add-hook 'rust-mode-hook #'racer-mode)
;;(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)


(add-hook 'rust-mode-hook
          (lambda ()
            (flycheck-mode -1)
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)
            (local-set-key (kbd "C-x `") #'flymake-goto-next-error)
            (local-set-key (kbd "C-c C-d") #'eglot-help-at-point)
            (local-set-key (kbd "C-c C-r") #'eglot-rename)
            ))


(add-hook 'rust-mode-hook 'cargo-minor-mode)

;; (defun my-eldoc-display-message (format-string &rest args)
;;   "Display eldoc message near point."
;;   (when format-string
;;     (pos-tip-show (apply 'format format-string args))))
;; (setq eldoc-message-function #'my-eldoc-display-message)

(provide 'language-rust-lsp)
;;; language-rust.el ends here
