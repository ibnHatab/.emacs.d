;;; Code:

(ensure-package-installed
 ;; 'cmake-project
 'cmake-mode
 'cmake-ide
 ;;
 'irony
 'irony-eldoc
 'flycheck-irony
 'company-irony
 'company-irony-c-headers
 ;;
 'xcscope
 'clang-format
 'helm-cscope)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; (cmake-ide-setup)
(require 'irony)

(add-hook 'c++-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (show-paren-mode)
  (smartparens-mode)
  (yas-minor-mode)

  (define-key irony-mode-map
    [remap completion-at-point] 'counsel-irony)
  (define-key irony-mode-map
    [remap complete-symbol] 'counsel-irony)
  (define-key irony-mode-map
    (kbd "C-c t") 'irony-get-type)
  (local-set-key [(M-tab)]  'company-complete )
  )

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))
(eval-after-load 'company '(add-to-list 'company-backends 'company-irony-c-headers))

;; I use irony with flycheck to get real-time syntax checking.
(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
(add-hook 'irony-mode-hook #'irony-eldoc)

(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
    (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
      (clang-format-buffer)))


(add-hook 'c++-mode-hook 'my-cpp-mode-hook)

(defun my-cpp-mode-hook ()
  (local-set-key (kbd "s-\'")   'remove-vowel)
  (local-set-key (kbd "s-\"")   'add-vowel)
  (local-set-key (kbd "C-c i") 'clang-format-region)
  (local-set-key (kbd "C-c u") 'clang-format-buffer)
  ;; (add-hook 'before-save-hook 'clang-format-buffer-smart nil 'local)

  )


;; (defvar clang-format-style
;;   (concat "{ " (combine-and-quote-strings (list
;;                                            "BasedOnStyle: Google"
;;                                            "BreakBeforeBraces: Stroustrup"
;;                                            "Standard: Cpp11"
;;                                            ;; "AllowShortBlocksOnASingleLine: false"
;;                                            "ConstructorInitializerAllOnOneLineOrOnePerLine: true"
;;                                            "BreakConstructorInitializersBeforeComma: false"
;;                                            "PointerBindsToType: false"
;;                                            "NamespaceIndentation: None"
;;                                            "AllowAllParametersOfDeclarationOnNextLine: false"
;;                                            "AllowShortFunctionsOnASingleLine: false"
;;                                            "ExperimentalAutoDetectBinPacking: true"
;;                                            ;; "ConstructorInitializerAllOnOneLineOrOnePerLine: true"
;;                                            "ColumnLimit: 160"
;;                                            "IndentWidth: %d") ", ")
;;           " }"))



(defun remove-vowel ($string &optional $from $to)
  (interactive
   (if (use-region-p)
       (list nil (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) )
       (list nil (car bds) (cdr bds)) ) ) )

  (let (workOnStringP inputStr outputStr)
    (setq workOnStringP (if $string t nil))
    (setq inputStr (if workOnStringP $string (buffer-substring-no-properties $from $to)))
    (setq outputStr
          (let ((case-fold-search t))
            (replace-regexp-in-string "#include \"\\(.*\\)\"" "#include <\\1>" inputStr) )  )
    (if workOnStringP
        outputStr
      (save-excursion
        (delete-region $from $to)
        (goto-char $from)
        (insert outputStr) )) ) )


(defun add-vowel ($string &optional $from $to)
  (interactive
   (if (use-region-p)
       (list nil (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) )
       (list nil (car bds) (cdr bds)) ) ) )

  (let (workOnStringP inputStr outputStr)
    (setq workOnStringP (if $string t nil))
    (setq inputStr (if workOnStringP $string (buffer-substring-no-properties $from $to)))
    (setq outputStr
          (let ((case-fold-search t))
            (replace-regexp-in-string "#include <\\(.*\\)>" "#include \"\\1\"" inputStr) )  )
    (if workOnStringP
        outputStr
      (save-excursion
        (delete-region $from $to)
        (goto-char $from)
        (insert outputStr) )) ) )


(provide 'language-c)
;;; language-c.el ends here
