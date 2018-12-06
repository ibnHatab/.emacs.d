;;; Code:

(ensure-package-installed
 ;; 'cmake-project
 'rust-mode
 ;; 'rust-playground
 ;; 'racer
 ;; 'flymake-rust
 'lsp-mode
 'lsp-rust
 'lsp-ui
;; 'cargo
 )

(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'rust-mode-hook #'lsp-rust-enable)
(add-hook 'rust-mode-hook #'flycheck-mode)

(defun my-set-projectile-root ()
  (when lsp--cur-workspace
    (setq projectile-project-root (lsp--workspace-root lsp--cur-workspace))))
(add-hook 'lsp-before-open-hook #'my-set-projectile-root)

;;(add-hook 'rust-mode-hook 'cargo-minor-mode)



;;(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))

;; (setq racer-cmd "~/.cargo/bin/racer")
;; ;;(setq racer-rust-src-path "/home/axadmin/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook #'company-mode)


(defun toggle-mut ()
  "Toggles the mutability of the variable defined on the current line"
  (interactive)
  (save-excursion
    (back-to-indentation)
    (forward-word)
    (if (string= " mut" (buffer-substring (point) (+ (point) 4)))
        (delete-region (point) (+ (point) 4))
      (insert " mut"))))


(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-m") #'toggle-mut)))

(provide 'language-rust)
;;; language-rust.el ends here
