;;; Code:

(ensure-package-installed
 'company-c-headers
 'xcscope
 'helm-cscope)

(cscope-setup)
(setq cscope-database-regexps
      '(
        ( "^/udir/vlad/repos/femto-henb"
          ( t )
          ( "/udir/vlad/repos/femto-cpe")
          t
          ( "/udir/vlad/repos/net/buildroot-2011.11/output/build/linux-3.1/"
            ("-d" "-I/usr/include"))
          )
        ( "^/users/jdoe/sources/gnome/"
          ( "/master/gnome/database" ("-d") ))
        )
      )


(custom-set-variables
 '(cscope-truncate-lines t)
 '(cscope-do-not-update-database t)
 )

(add-hook 'c-mode-common-hook 'helm-cscope-mode)
(add-hook 'helm-cscope-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'helm-cscope-find-global-definition)
            (local-set-key (kbd "M-@") 'helm-cscope-find-calling-this-funtcion)
            (local-set-key (kbd "M-s") 'helm-cscope-find-this-symbol)
            (local-set-key (kbd "M-,") 'helm-cscope-pop-mark)
            (local-set-key [(control f6)] 'cscope-display-buffer)
            (local-set-key [(control f7)] 'cscope-prev-symbol)
            (local-set-key [(control f8)] 'cscope-next-symbol)
;;            (local-set-key [(control f9)] 'cscope-set-initial-directory)
            (local-set-key [(M-tab)]	'complete-tag )
            (local-set-key "\C-cm" #'expand-member-functions
          )))

(provide 'language-c)
;;; language-c.el ends here
