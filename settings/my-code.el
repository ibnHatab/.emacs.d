(ensure-package-installed
 'flycheck
 'rainbow-delimiters
 'smartparens)

(smartparens-global-mode 1)
(show-smartparens-global-mode t)

;;; Apply web mode for html
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq-default
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2)

(setq compilation-finish-function
      (lambda (buf str)
 	(unless (string-match "exited abnormally" str)
 	  ;;no errors, make the compilation window go away in a few seconds
 	  (run-at-time
 	   "4 sec" nil 'delete-windows-on
 	   (get-buffer-create "*compilation*"))
 	  (message "No Compilation Errors!"))))

;;; Compile buffer colorization fix
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

(defun my-code-mode-init ()
  (my-turn-modes 1
                 ;; 'linum-mode
                 'rainbow-delimiters-mode
                 'flycheck-mode
                 ;; 'show-paren-mode
                 'electric-indent-mode
                 'electric-pair-mode)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook
 'prog-mode-hook
 'my-code-mode-init)

(add-hook 'write-file-functions 'delete-trailing-whitespace)
(autoload 'nuke-trailing-whitespace "whitespace" nil t) ;remove trailing

;; Camel / Uncamel cases
(defun mo-toggle-identifier-naming-style ()
  "Toggles the symbol at point between C-style naming,
e.g. `hello_world_string', and camel case,
e.g. `HelloWorldString'."
  (interactive)
  (let* ((symbol-pos (bounds-of-thing-at-point 'symbol))
         case-fold-search symbol-at-point cstyle regexp func)
    (unless symbol-pos
      (error "No symbol at point"))
    (save-excursion
      (narrow-to-region (car symbol-pos) (cdr symbol-pos))
      (setq cstyle (string-match-p "_" (buffer-string))
            regexp (if cstyle "\\(?:\\_<\\|_\\)\\(\\w\\)" "\\([A-Z]\\)")
            func (if cstyle
                     'capitalize
                   (lambda (s)
                     (concat (if (= (match-beginning 1)
                                    (car symbol-pos))
                                 ""
                               "_")
                             (downcase s)))))
      (goto-char (point-min))
      (while (re-search-forward regexp nil t)
        (replace-match (funcall func (match-string 1))
                       t nil))
      (widen))))

(provide 'my-code)
;;; my-code.el ends here
