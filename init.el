;;; Code:

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
(require 'language-javascript)
(require 'language-lisp)
(require 'language-c)
(require 'language-erlang)
(require 'language-ruby)
(require 'language-python)
(require 'language-haskell)
(require 'language-elixir)
(require 'language-elm)
;;(require 'language-ocaml)
;;
(require 'my-keys)

(fset 'yes-or-no-p 'y-or-n-p)

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
               'global-company-mode
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
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(browse-url-chromium-program "google-chrome-stable")
 '(column-number-mode t)
 '(company-auto-complete nil)
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
 '(electric-pair-mode -1)
 '(enable-local-variables :all)
 '(erl-company-popup-help 1)
 '(flycheck-clang-args (quote ("-std=c++14")))
 '(flycheck-clang-language-standard "c++14")
 '(follow-auto t)
 '(global-auto-highlight-symbol-mode t)
 '(global-company-mode t)
 '(haskell-tags-on-save t)
 '(kill-whole-line t)
 '(load-prefer-newer t)
 '(mode-compile-always-save-buffer-p t)
 '(nil nil t)
 '(org-support-shift-select (quote always))
 '(pop-up-windows nil)
 '(require-final-newline t)
 '(save-interprogram-paste-before-kill t)
 '(save-place-file (concat user-emacs-directory "places"))
 '(tab-always-indent t)
 '(transient-mark-mode t)
 '(url-proxy-services
   (quote
    (("no_proxy" . "^\\(localhost\\|0\\)")
     ("http" . "135.245.192.6:8000")
     ("https" . "135.245.192.6:8000"))))
 '(use-file-dialog nil)
 '(x-select-enable-clipboard t)
 '(x-select-enable-primary nil)
 '(yas-global-mode 1 nil (yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :foreground "yellow")))))

(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
        kill-buffer-query-functions))
