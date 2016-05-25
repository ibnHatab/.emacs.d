;;; Code:

(ensure-package-installed
;; 'cmake-project
 'cmake-mode
 'cmake-ide
 ;;
 'xcscope
 'helm-cscope)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(cmake-ide-setup)

(add-hook 'c++-mode-hook 'irony-mode)
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(add-to-list 'company-backends 'company-irony)
(add-to-list 'company-backends 'company-irony-c-headers)

(cscope-setup)

(setq cscope-database-regexps
      '(
        ("^/local/vlad/repos/megazone/sbts_intro_path/PromisesCPP/"
         ( t )
         ( "/home/vlad/.cscope/boost/cscope.out" ("-d"))
         ( "/home/vlad/.cscope/stdcpp/cscope.out" ("-d"))
         )
        ("^/local/vlad/repos/megazone/fereco/fareco"
         ( t )
         ( "/local/vlad/repos/megazone/fereco/lim" ("-d"))
         ( "/local/vlad/repos/megazone/fereco/liboam" ("-d"))

         )
        ;; ( "^/udir/vlad/repos/femto-henb"
        ;;   ( t )
        ;;   ( "/udir/vlad/repos/femto-cpe")
        ;;   t
        ;;   ( "/udir/vlad/repos/net/buildroot-2011.11/output/build/linux-3.1/"
        ;;     ("-d" "-I/usr/include"))
        ;;   )
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

            (local-set-key "\C-cc" 'cmake-ide-compile)
            (local-set-key (kbd "C-c o") 'ff-find-other-file)
            (local-set-key (kbd "M-{") (sp-restrict-to-pairs-interactive "{" 'sp-down-sexp))

            (local-set-key (kbd "M-.") 'helm-cscope-find-this-symbol)
            (local-set-key (kbd "M-r") 'helm-cscope-find-global-definition)
            (local-set-key (kbd "M-\\") 'helm-cscope-find-calling-this-funtcion)
            (local-set-key (kbd "M-=") 'helm-cscope-find-assignments-to-this-symbol)
            (local-set-key (kbd "M-,") 'helm-cscope-pop-mark)
            (local-set-key [(M-tab)]	'company-complete )
            (local-set-key "\C-cm" #'expand-member-functions)))


(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

(provide 'language-c)
;;; language-c.el ends here
