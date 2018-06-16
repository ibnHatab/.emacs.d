;;; Code:

(ensure-package-installed
 'rtags
 )

;;(cscope-setup)
(add-hook 'c++-mode-hook 'cscope-setup)

(setq cscope-database-regexps
      '(
        ("^/home/axadmin/repos/oam"
         ( t )
         ( "/local/axadmin/repos/megazone/fereco/lim" ("-d"))
         ( "/local/axadmin/repos/megazone/fereco/liboam" ("-d"))
         )

        ( "^/home/axadmin/repos/tas"
          ( t )
          ( "/home/axadmin/repos/tas/src")
          ( "/home/axadmin/repos/sdk/sysroots/core2-64-nokia-linux/usr"
            ("-d" "-I/usr/include"))
          )
        ))

(custom-set-variables
 '(cscope-truncate-lines t)
 '(cscope-do-not-update-database t)
 )

(add-hook 'c-mode-common-hook 'helm-cscope-mode)
(add-hook 'c++-mode-hook 'helm-cscope-mode)

(add-hook 'helm-cscope-mode-hook
          (lambda ()
            (setq c-default-style "bsd"
                  c-basic-offset 4)

            (c-set-offset 'substatement-open 0)
            (c-set-offset 'innamespace 0)

            (local-set-key "\C-cc" 'compile)
            (local-set-key (kbd "C-c o") 'ff-find-other-file)
            (local-set-key (kbd "M-{") (sp-restrict-to-pairs-interactive "{" 'sp-down-sexp))

            (local-set-key (kbd "M-.") 'helm-cscope-find-this-symbol)
            (local-set-key (kbd "M-r") 'helm-cscope-find-global-definition)
            (local-set-key (kbd "M-\\") 'helm-cscope-find-calling-this-funtcion)
            (local-set-key (kbd "M-=") 'helm-cscope-find-assignments-to-this-symbol)
            (local-set-key (kbd "M-,") 'helm-cscope-pop-mark)
            (local-set-key "\C-cm" #'expand-member-functions)))


(provide 'language-cscope)
;;; language-rtags.el ends here
