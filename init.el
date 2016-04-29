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
(require 'my-keys)
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

(fset 'yes-or-no-p 'y-or-n-p)

(ensure-package-installed
 'whole-line-or-region
 'which-key
 'company
 'exec-path-from-shell
 'yasnippet
 'restclient
 'smartparens
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
 '(browse-url-chromium-program "google-chrome-stable")
 '(cscope-do-not-update-database t)
 '(cscope-truncate-lines t)
 '(blink-matching-paren-on-screen t)
 '(bm-highlight-style (quote bm-highlight-only-fringe))
 '(compilation-ask-about-save nil)
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(display-time-mode t)
 '(enable-local-variables :all)
 '(global-auto-highlight-symbol-mode t)
 '(kill-whole-line t)
 '(use-file-dialog nil)
 '(x-select-enable-clipboard t)
 '(follow-auto t)
 '(org-support-shift-select (quote always))
 '(tab-always-indent t)
 '(transient-mark-mode t)
 '(use-file-dialog nil)
 '(x-select-enable-clipboard t)
 '(x-select-enable-primary t)
 '(save-interprogram-paste-before-kill t)
 '(apropos-do-all t)
 '(require-final-newline t)
 '(load-prefer-newer t)
 '(mode-compile-always-save-buffer-p t)
 '(compilation-window-height 12)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(ediff-split-window-function 'split-window-vertically)

 '(save-place-file (concat user-emacs-directory "places"))
;;        mouse-yank-at-point t
;;         visible-bell t

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ))
