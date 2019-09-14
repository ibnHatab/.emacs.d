;;; Code:

(ensure-package-installed
 ;; 'cmake-project
 'rust-mode
;; 'rust-playground
 'racer
 ;;'flymake-rust
 'flycheck-rust
 'cargo
 )
(setenv "RUST_BACKTRACE" "1")

(add-hook 'rust-mode-hook 'cargo-minor-mode)
(setq rust-format-on-save t)

(add-hook 'rust-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)
            (local-set-key (kbd "C-c C-d") #'racer-describe)
            (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
            ))

(setq company-tooltip-align-annotations t)

(setq racer-cmd "~/.cargo/bin/racer")
;;(setq racer-rust-src-path "/home/axadmin/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

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
