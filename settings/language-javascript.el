;;; Code:

(ensure-package-installed
 'js2-mode
 'js2-refactor
 'json-mode)

(global-company-mode '(not js2-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook
          (lambda ()
             ;;
             (setq js2-bounce-indent-p t)
             (js2r-add-keybindings-with-prefix "C-c C-m")
             (local-set-key (kbd "C-c C-r") 'send-region-to-nodejs-repl-process)
             (setq js2-basic-offset 2)))

(eval-after-load 'flycheck
  (lambda ()
    (flycheck-add-mode 'javascript-eslint 'js2-mode)
    ;; Disable jshint
    (setq-default
     flycheck-disabled-checkers
     (append flycheck-disabled-checkers
	     '(javascript-jshint)))))

(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

(defun send-region-to-nodejs-repl-process (start end)
  "Send region to `nodejs-repl' process."
  (interactive "r")
  (save-selected-window
    (save-excursion (nodejs-repl)))
  (comint-send-region (get-process nodejs-repl-process-name)
                      start end))

(provide 'language-javascript)
;;; language-javascript.el ends here
