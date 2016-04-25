;;; Code:

(ensure-package-installed
 'python
 ;; 'elpy
 'company-jedi
 'ein)

;; (elpy-enable)
;; (elpy-use-ipython)
;; (setq elpy-rpc-backend "jedi")

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

(add-hook 'ein:notebook-mode-hook
          '(lambda ()
             (local-set-key [C-return] 'ein:worksheet-execute-cell-and-goto-next)
             (local-set-key [M-tab] 'ein:completer-complete)
             ))


(provide 'language-python)
;;;
