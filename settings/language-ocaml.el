;;; Code:

(ensure-package-installed
;; 'cmake-project
 'tuareg
 'merlin
 'utop
 'ocp-indent)

;; Add opam emacs directory to the load-path
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
;; Start merlin on ocaml files
(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)
(setq merlin-use-auto-complete-mode 'easy)
(setq merlin-command 'opam)
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq utop-command "opam config exec -- utop -emacs")
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
(add-hook 'tuareg-mode-hook 'utop-minor-mode)

(add-hook
 'tuareg-mode-hook
 (lambda ()
   (company-mode)
   ;; separate calls, not like setq
   (setq-local merlin-completion-with-doc t)
   (setq-local indent-tabs-mode nil)
   (setq-local show-trailing-whitespace t)
   (setq-local indent-line-function 'ocp-indent-line)
   (setq-local indent-region-function 'ocp-indent-region)
   ))

;; Automatically load utop.el
(provide 'language-ocaml)
;;; language-c.el ends here
