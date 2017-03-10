;;; Code:

(ensure-package-installed
 ;; 'cmake-project
 'cmake-mode
 'cmake-ide
 ;;
 ;; 'irony
 ;; 'flycheck-irony
 ;; 'company-irony
 ;; 'company-irony-c-headers
 ;;
 'xcscope
 'clang-format
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

(eval-after-load 'flycheck
  '(progn
     (require 'flycheck-google-cpplint)
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.
     (flycheck-add-next-checker 'c/c++-clang
                                '(warning . c/c++-googlelint))
     (local-set-key "\C-cc" 'flycheck-compile)
     ))

(custom-set-variables
 '(flycheck-c/c++-googlelint-executable "/home/axadmin/repo/cpplint/cpplint.py")
 '(flycheck-googlelint-verbose "3")
 '(flycheck-googlelint-filter "-whitespace,+whitespace/braces")
 '(flycheck-googlelint-root "project/src")
 '(flycheck-googlelint-linelength "120"))

;; https://clangformat.com/

(defvar clang-format-style
  (concat "{ " (combine-and-quote-strings (list
                                           "BasedOnStyle: Google"
                                           "BreakBeforeBraces: Stroustrup"
                                           "Standard: Cpp11"
                                           ;; "AllowShortBlocksOnASingleLine: false"
                                           "ConstructorInitializerAllOnOneLineOrOnePerLine: true"
                                           "BreakConstructorInitializersBeforeComma: false"
                                           "PointerBindsToType: false"
                                           "NamespaceIndentation: None"
                                           "AllowAllParametersOfDeclarationOnNextLine: false"
                                           "AllowShortFunctionsOnASingleLine: false"
                                           "ExperimentalAutoDetectBinPacking: true"
                                           ;; "ConstructorInitializerAllOnOneLineOrOnePerLine: true"
                                           "ColumnLimit: 160"
                                           "IndentWidth: %d") ", ")
          " }"))

(defun clang-format-executable ()
  (let ((minor 10) ret)
    (while (and (not ret)
                (>= minor 0))
      (setq ret (executable-find (format "clang-format-3.%d" minor)))
      (decf minor))
    (or ret (executable-find "clang-format"))))

(defun clang-format-region (&optional start end)
  (interactive "P")

  (let* ((orig-windows (get-buffer-window-list (current-buffer)))
         (orig-window-starts (mapcar #'window-start orig-windows))
         (orig-point (point))
         (binary (clang-format-executable))
         (style (format clang-format-style (or (and (numberp c-basic-offset) c-basic-offset) 4))))
    (unless start
      (setq start (if mark-active (min (region-beginning) (region-end)) (point-min))))
    (unless end
      (setq end (if mark-active (max (region-beginning) (region-end)) (point-max))))
    (unless binary
      (error "Can't find clang-format"))
    (call-process-region (point-min) (point-max) binary t (cons t nil) nil
                         "-offset" (number-to-string (1- start))
                         "-length" (number-to-string (- end start))
                         (format "-cursor=%d" orig-point)
                         "-style" style)

    (goto-char (point-min))
    (when (looking-at "{ *\"Cursor\" *: *\\([0-9]+\\)")
      (setq orig-point (string-to-number (match-string 1)))
      (delete-char (1+ (- (point-at-eol) (point-at-bol)))))
    (goto-char orig-point)
    (dotimes (index (length orig-windows))
      (set-window-start (nth index orig-windows)
                        (nth index orig-window-starts)))))

(provide 'language-c)
;;; language-c.el ends here
