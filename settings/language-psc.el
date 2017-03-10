
;;; Code:

(ensure-package-installed
 'purescript-mode
 'psc-ide
 'projectile
 'psci
 )


(add-hook 'purescript-mode-hook
          (lambda ()
            (psc-ide-mode)
            (company-mode)
            (flycheck-mode)
            (turn-on-purescript-indentation)
            (customize-set-variable 'psc-ide-rebuild-on-save t)
            ;;
            (inferior-psci-mode)
            (local-set-key (kbd "C-c C-z") 'psci)
            ))

(provide 'language-psc)
;;; language-psc.el ends here
