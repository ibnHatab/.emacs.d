;;; Code:

(ensure-package-installed
 'js2-mode
 'js2-refactor
 'ac-js2
 'tern
 'json-mode)

(require 'js2-mode)
(require 'flycheck)
(require 'ac-js2)

(add-hook 'js-mode-hook 'js2-minor-mode)

(global-company-mode '(not js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook
          (lambda ()
             ;;
            (tern-mode t)

             (js2r-add-keybindings-with-prefix "C-c C-m")
             (local-set-key (kbd "C-c C-r") 'send-region-to-nodejs-repl-process)
             (setq js2-bounce-indent-p t)
             (setq js2-highlight-level 3)
             (setq js2-basic-offset 2)))

(eval-after-load 'flycheck
  (lambda ()
    (flycheck-add-mode 'javascript-eslint 'js2-mode)
    ;; Disable jshint
    (setq-default
     flycheck-disabled-checkers
     (append flycheck-disabled-checkers
	     '(javascript-jshint)))))

(defun send-region-to-nodejs-repl-process (start end)
  "Send region to `nodejs-repl' process."
  (interactive "r")
  (save-selected-window
    (save-excursion (nodejs-repl)))
  (comint-send-region (get-process nodejs-repl-process-name)
                      start end))

(provide 'language-javascript)
;;; language-javascript.el ends here
