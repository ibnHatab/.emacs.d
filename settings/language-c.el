(ensure-package-installed
 'company-c-headers
 'helm-gtags
 'xcscope
 'helm-cscope)

(defun my-c-mode ()
  (helm-gtags-mode 1)
  (add-hook-)

  (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

  (set (make-local-variable 'company-backends) '('company-c-headers 'company-gtags))

  ;; (add-to-list 'company-backends 'company-c-headers)
  ;; (add-to-list 'company-backends 'company-gtags)
  )


(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t)

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

(defun cscope-keys ()
  (local-set-key "\M-." 'cscope-find-global-definition-no-prompting)
  (local-set-key "\M-," 'cscope-pop-mark)
  (local-set-key "\M-?" 'cscope-find-this-symbol)
  (local-set-key "\M-\\" 'cscope-find-functions-calling-this-function) ;; f4 References
  (local-set-key [(control f6)] 'cscope-display-buffer)                       ;; f6 display buffer
  (local-set-key [(control f7)] 'cscope-prev-symbol)                          ;; f7 prev sym
  (local-set-key [(control f8)] 'cscope-next-symbol)                          ;; f8 next sym
  (local-set-key [(control f9)] 'cscope-set-initial-directory)                ;; f9 set initial dir
  (local-set-key [(M-tab)]	'complete-tag )
  (local-set-key "\C-cm" #'expand-member-functions))



;; Alternative
;; (add-hook 'c++-mode-hook 'my-c-mode)
;; (add-hook 'c-mode-hook 'my-c-mode)

;; (add-hook 'c++-mode-hook 'cscope-keys)
;; (add-hook 'c-mode-hook 'cscope-keys)

(add-hook 'c-mode-common-hook 'helm-cscope-mode)
(add-hook 'helm-cscope-mode-hook
          (lambda ()
            (local-set-key (kbd "M-.") 'helm-cscope-find-global-definition)
            (local-set-key (kbd "M-@") 'helm-cscope-find-calling-this-funtcion)
            (local-set-key (kbd "M-s") 'helm-cscope-find-this-symbol)
            (local-set-key (kbd "M-,") 'helm-cscope-pop-mark)))

(provide 'language-c)
;;; language-c.el ends here
