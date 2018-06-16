(ensure-package-installed
 'paredit
 ;;'pretty-lambdada
 )

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
;   (paredit-mode 1)
   ;(pretty-lambda-mode 1)
   ))

(provide 'language-lisp)
