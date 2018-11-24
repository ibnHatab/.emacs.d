
(ensure-package-installed
 'python
 'elpy
 'company-jedi
 'ein)


(elpy-enable)

;;(elpy-use-ipython)

(setq elpy-rpc-backend "jedi")

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook
 (lambda ()
  (local-set-key(kbd "M-.") 'jedi:goto-definition)
  (local-set-key(kbd "M-,") 'jedi:goto-definition-pop-marker)
  (local-set-key(kbd "M-\\") 'helm-jedi-related-names)
  (local-set-key(kbd "C-c C-d") 'jedi:show-doc)))

(require 'company)

(defun my/python-mode-hook()
 (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

(add-hook 'ein:notebook-mode-hook
 '(lambda ()
   (local-set-key[C-return] 'ein:worksheet-execute-cell-and-goto-next)
   (local-set-key[M-tab] 'ein:completer-complete)
   ))


(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

(setq py-autopep8-options '("--max-line-length=100"))

(provide 'language-python)
