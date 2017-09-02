;;; Code:

(ensure-package-installed
 'haskell-mode
 'intero)


(add-hook 'haskell-mode-hook 'intero-mode)

(provide 'language-intero)
;;; my-projects.el ends here
