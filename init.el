(add-to-list
 'load-path
 (expand-file-name "settings" user-emacs-directory))

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
(require 'language-javascript)
(require 'language-lisp)
(require 'language-c)

(add-to-list
 'load-path
 (expand-file-name "local" user-emacs-directory))

(require 'windcycle)

(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-step 1)                    ; scrolling page

(ensure-package-installed
 'whole-line-or-region
 'which-key
 'company
 'better-defaults
 'exec-path-from-shell
 'web-mode
 'yasnippet
 ;; 'super-save
 'restclient

;; Themes
 'color-theme-sanityinc-solarized
 )

;; I may have some variables set in my shell
(exec-path-from-shell-initialize)

;; (require 'super-save)
;; (super-save-initialize)

;; Enable global-modes
(my-turn-modes 1
               'global-auto-revert-mode
               'global-company-mode
               'global-hl-line-mode
               'which-key-mode
               'winner-mode
               'whole-line-or-region-mode)

(setq-default
 which-key-idle-delay 0.2)

(add-hook
 'company-mode-hook
 '(lambda ()
   ;; Slightly better autocomplete on tab
   (define-key company-active-map [tab] 'company-complete-common-or-cycle)
   (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)))
(setq-default
 company-idle-delay 0.1
 company-minimum-prefix-length 1)

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

;; (set-face-attribute 'default nil
;;                     :family "Fira Mono"
;;                     :height '110)

;; Load theme
(setq my-themes '(sanityinc-solarized-dark sanityinc-solarized-light))

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
