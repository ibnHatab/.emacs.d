;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list
 'load-path
 (expand-file-name "settings" user-emacs-directory))

(add-to-list
 'load-path
 (expand-file-name "local" user-emacs-directory))

(defun my-turn-modes (param &rest modes)
  ;;; Applies the parameter to the specified modes
  (mapcar #'(lambda (mode)
              (funcall mode param)) modes))

(require 'my-package)
(require 'my-navigation)
(require 'my-code)
(require 'my-engine)
(require 'my-projects)
(require 'my-directory)
(require 'my-org)
;;(require 'language-javascript)
(require 'language-lisp)
(require 'language-c)
(require 'language-cscope)
;(require 'language-rtags)
(require 'language-go)
;;(require 'language-erlang)
;;(require 'language-ruby)
(require 'language-python)
;;(require 'language-haskell)
;;(require 'language-intero)
(require 'language-psc)
;;(require 'language-elixir)
;;(require 'language-elm)
;;(require 'language-ocaml)
;;(require 'language-scala)
;; (require 'language-ttcn)
(require 'language-rust)
;;(require 'language-rust-lsp)
;; (require 'language-tla)
;;
(require 'my-keys)

(fset 'yes-or-no-p 'y-or-n-p)

(setq company-global-modes '(not org-mode go-mode js2-mode cmake-mode shell-mode))
(setq company-dabbrev-other-buffers nil)

(ensure-package-installed
 'whole-line-or-region
 'which-key
 'company
 'exec-path-from-shell
 'yasnippet
 'restclient
 ;;'smartparens
 ;; Themes
 'color-theme-sanityinc-solarized
 )

;; I may have some variables set in my shell
(exec-path-from-shell-initialize)

;; Enable global-modes
(my-turn-modes 1
               'global-auto-revert-mode
;;               'global-company-mode
               'global-hl-line-mode
               'which-key-mode
               'winner-mode
               'whole-line-or-region-mode)

(setq-default which-key-idle-delay 0.9)

;; Transparent emacs yay!
(set-frame-parameter (selected-frame) 'alpha '(100))

;; Turn off GUI bloat
(my-turn-modes 0
 'scroll-bar-mode
 'tool-bar-mode
 'menu-bar-mode)

(setq-default
 inhibit-startup-screen t
 indent-tabs-mode nil
; auto-save-default nil
 make-backup-files nil)

;; Load theme
(setq my-themes
      '(sanityinc-solarized-dark sanityinc-solarized-light))

(setq my-cur-theme nil)
(defun cycle-my-theme ()
  "Cycle through a list of themes, my-themes"
  (interactive)
  (when my-cur-theme
    (disable-theme my-cur-theme)
    (setq my-themes (append my-themes (list my-cur-theme))))
  (setq my-cur-theme (pop my-themes))
  (load-theme my-cur-theme t))
(cycle-my-theme)

(server-start)
(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alchemist-goto-elixir-source-dir "/local/vlad/repos/erlang/elixir.git")
 '(alchemist-goto-erlang-source-dir "/local/vlad/repos/erlang/otp_src_18.3")
 '(apropos-do-all t)
 '(auto-highlight-symbol-mode-map nil t)
 '(blink-matching-paren-on-screen t)
 '(bm-cycle-all-buffers t)
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(browse-url-chromium-program "google-chrome-stable")
 '(column-number-mode t)
 '(company-global-modes (quote (not js2-mode cmake-mode)))
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 1)
 '(company-require-match nil)
 '(company-tooltip-align-annotations t)
 '(compilation-ask-about-save nil)
 '(compilation-window-height 12)
 '(confirm-nonexistent-file-or-buffer nil)
 '(cscope-do-not-update-database t)
 '(cscope-truncate-lines t)
 '(cursor-type (quote (bar . 4)))
 '(cycbuf-attributes-list
   (quote
    (("M" 1 left cycbuf-get-modified-string)
     ("R" 2 left cycbuf-get-readonly-string)
     ("" 2 left ">> ")
     ("Buffer" cycbuf-get-name-length left cycbuf-get-name)
     ("" 1 left " ")
     ("Directory" cycbuf-get-file-length right cycbuf-get-file-name)
     ("" 2 left "  ")
     ("Mode" 12 left cycbuf-get-mode-name))))
 '(cycbuf-clear-delay 2)
 '(cycbuf-file-name-replacements (quote (("/local/vlad/repos/" "r:/"))))
 '(delete-selection-mode t)
 '(dired-dwim-target t)
 '(display-time-mode t)
 '(ediff-split-window-function (quote split-window-vertically))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(edts-api-async-node-init t)
 '(edts-api-num-project-node-start-retries 15)
 '(edts-api-num-server-start-retries 20)
 '(edts-api-project-node-start-retry-interval 1.5)
 '(edts-api-server-start-retry-interval 0.5)
 '(edts-erl-command "/usr/bin/erl")
 '(edts-inhibit-package-check nil)
 '(edts-log-level (quote debug))
 '(eldoc-idle-delay 1)
 '(eldoc-minor-mode-string nil)
 '(electric-pair-mode -1)
 '(enable-local-variables :all)
 '(engine-mode t)
 '(ensime-startup-notification nil)
 '(ensime-startup-snapshot-notification nil)
 '(erl-company-popup-help 1)
 '(flycheck-c/c++-googlelint-executable "/home/axadmin/repo/cpplint/cpplint.py")
 '(flycheck-clang-args (quote ("-std=c++14")))
 '(flycheck-clang-include-path
   (quote
    ("/home/axadmin/repo/tas/sdk/sysroots/core2-64-nokia-linux/usr/include" "/home/axadmin/repo/tas//sdk/sysroots/core2-64-nokia-linux/usr/include/vtc/vtc_intf")))
 '(flycheck-clang-language-standard "c++14")
 '(flycheck-googlelint-filter "-whitespace,+whitespace/braces")
 '(flycheck-googlelint-linelength "120")
 '(flycheck-googlelint-root "project/src")
 '(flycheck-googlelint-verbose "3")
 '(flymake-proc-allowed-file-name-masks
   (quote
    (("\\.l?hs\\'" haskell-flymake-init nil nil)
     ("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'" flymake-simple-make-init nil nil)
     ("\\.xml\\'" flymake-xml-init nil nil)
     ("\\.html?\\'" flymake-xml-init nil nil)
     ("\\.cs\\'" flymake-simple-make-init nil nil)
     ("\\.p[ml]\\'" flymake-perl-init nil nil)
     ("\\.php[345]?\\'" flymake-php-init nil nil)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup nil)
     ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup nil)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup nil)
     ("\\.tex\\'" flymake-simple-tex-init nil nil)
     ("\\.idl\\'" flymake-simple-make-init nil nil)
     ("\\\\.ino\\\\'" flymake-simple-make-init nil nil))))
 '(follow-auto t)
 '(global-auto-highlight-symbol-mode t)
 '(global-company-mode nil)
 '(haskell-tags-on-save t)
 '(helm-ff-file-name-history-use-recentf t)
 '(irony-additional-clang-options (quote ("-std=c++14")))
 '(irony-cdb-search-directory-list (quote ("." "workspace" "build")))
 '(kill-whole-line t)
 '(load-prefer-newer t)
 '(menu-bar-mode nil)
 '(minimap-always-recenter nil)
 '(minimap-hide-fringes t)
 '(minimap-highlight-line nil)
 '(minimap-mode t)
 '(minimap-recenter-type (quote middle))
 '(minimap-update-delay 0.3)
 '(minimap-width-fraction 0.13)
 '(minimap-window-location (quote right))
 '(mode-compile-always-save-buffer-p t)
 '(nil nil t)
 '(org-agenda-files nil)
 '(org-babel-load-languages (quote ((awk . t) (python . t) (sh . t))))
 '(org-confirm-babel-evaluate nil)
 '(org-support-shift-select (quote always))
 '(package-selected-packages
   (quote
    (protobuf-mode smalltalk-mode minimap sublimity ag lsp-flycheck flycheck-rust color-theme-sanityinc-solarized restclient exec-path-from-shell which-key whole-line-or-region psci psc-ide purescript-mode flycheck-elm elm-mode alchemist elixir-mode ac-haskell-process haskell-mode ein company-jedi helm-cscope clang-format xcscope cmake-ide cmake-mode undo-tree tern smartparens rainbow-delimiters projectile popup-imenu paredit neotree magit json-mode js2-refactor highlight-symbol helm-ag goto-chg github-browse-file git-gutter flycheck expand-region engine-mode company bm ack ace-jump-mode ac-js2)))
 '(projectile-mode t nil (projectile))
 '(projectile-mode-line
   (quote
    (:eval
     (if
         (file-remote-p default-directory)
         " Projectile"
       (format " Proj[%s]"
               (projectile-project-name))))))
 '(recentf-max-menu-items 40)
 '(recentf-max-saved-items 150)
 '(recentf-mode t)
 '(require-final-newline t)
 '(rng-nxml-auto-validate-flag nil)
 '(rng-validate-mode 0)
 '(save-interprogram-paste-before-kill t)
 '(save-place-file (concat user-emacs-directory "places"))
 '(select-enable-clipboard t)
 '(select-enable-primary nil)
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(tab-always-indent t)
 '(tool-bar-mode nil)
 '(use-file-dialog nil)
 '(yas-global-mode 1 nil (yasnippet)))

(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "open")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 130 :width normal))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :foreground "yellow"))))
 '(minimap-active-region-background ((t (:background "dark slate gray")))))

(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
        kill-buffer-query-functions))


(add-hook 'nxml-mode-hook 'rng-set-vacuous-schema)


(defalias 'xml-mode 'sgml-mode
    "Use `sgml-mode' instead of nXML's `xml-mode'.")
(put 'scroll-left 'disabled nil)
