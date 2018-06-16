;;; Code:

(ensure-package-installed
 'rtags
 'helm-rtags
 'company-rtags
 'flycheck-rtags
 )

(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

(eval-after-load 'company '(add-to-list 'company-backends 'company-rtags))

(defun setup-rtags ()
  (local-set-key (kbd "M-.") 'rtags-find-symbol-at-point)
  (local-set-key (kbd "M-,") 'rtags-find-references-at-point)
  (local-set-key (kbd "M-?") 'rtags-display-summary)
  (rtags-enable-standard-keybindings)

  (setq rtags-use-helm t)

  ;; Shutdown rdm when leaving emacs.
  (add-hook 'kill-emacs-hook 'rtags-quit-rdm)

  ;; TODO: Has no coloring! How can I get coloring?
  (setq rtags-display-result-backend 'helm)

  ;; Use rtags for auto-completion.
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)

  )

(add-hook 'c-mode-hook #'setup-rtags)
(add-hook 'c++-mode-hook #'setup-rtags)

;; Live code checking.
;; ensure that we use only rtags checking
;; https://github.com/Andersbakken/rtags#optional-1
(defun setup-flycheck-rtags ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil)
  (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
  )

(add-hook 'c-mode-hook #'setup-flycheck-rtags)
(add-hook 'c++-mode-hook #'setup-flycheck-rtags)

(provide 'language-rtags)
;;; language-rtags.el ends here
