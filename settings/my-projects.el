(ensure-package-installed
 'helm
 'helm-ag
 'helm-projectile
 'github-browse-file
 'magit
 'projectile
 'goto-chg
 'popup-imenu
 'undo-tree
 'highlight-symbol
 'git-gutter)

(add-hook
 'company-mode-hook
 '(lambda ()
   ;; Slightly better autocomplete on tab
   (define-key company-active-map [tab] 'company-complete-common-or-cycle)
   (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)))

(setq-default
 company-idle-delay 0.1
 company-minimum-prefix-length 1)



;; Helmify everything
(helm-mode 1)
(setq-default
 helm-recentf-fuzzy-match 't
 helm-buffers-fuzzy-match 't
 helm-locate-fuzzy-match 't
 helm-M-x-fuzzy-match 't
 helm-imenu-fuzzy-match 't
 helm-apropos-fuzzy-match 't
 helm-lisp-completion-at-point 't
 helm-semantic-fuzzy-match t
 helm-imenu-fuzzy-match t
 )


;; open helm buffer inside current window, not occupy whole other window
(setq helm-split-window-in-side-p t)
(setq helm-autoresize-max-height 50)
(setq helm-autoresize-min-height 30)
(helm-autoresize-mode 1)


(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "C-x b")   'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key [M-right]       'goto-last-change-reverse)
(global-set-key [M-left]        'goto-last-change-reverse)
(global-set-key (kbd "s-f")     'projectile-find-file)
(global-set-key (kbd "s-F")     'projectile-ag)
(global-set-key (kbd "s-/")     'undo-tree-visualize)
(global-set-key (kbd "s-S")     'highlight-symbol)
(global-set-key (kbd "M-i")     'popup-imenu)

(helm-mode 1)

;;; Enable projectile in all buffers
;;(add-hook 'after-init-hook 'projectile-global-mode)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)



(defcustom git-grep-switches "-E -I -nH -i --no-color"
  "Switches to pass to `git grep'."
  :type 'string)
(defcustom git-grep-default-work-tree (expand-file-name "~/code/mything")
  "Top of your favorite git working tree. \\[git-grep] will search from here if it cannot figure out where else to look."
  :type 'directory)
(when (require 'vc-git nil t)
  (defun git-grep (regexp)
    (interactive
     (list (read-from-minibuffer
            "Search git repo: "
            (let ((thing (and buffer-file-name
                              (thing-at-point 'symbol))))
              (or (and thing
                       (progn
                         (set-text-properties 0 (length thing) nil thing)
                         (shell-quote-argument (regexp-quote thing))))
                  ""))
            nil nil 'git-grep-history)))
    (let ((grep-use-null-device nil)
          (root (or (vc-git-root default-directory)
                    (prog1 git-grep-default-work-tree
                      (message "git-grep: %s doesn't look like a git working tree; searching from %s instead" default-directory root)))))
      (grep (format "GIT_PAGER='' git grep %s -e %s -- %s" git-grep-switches regexp root)))))

(global-git-gutter-mode t)

(global-set-key (kbd "C-x ?")   'git-grep)
(global-set-key (kbd "C-x g")   'magit-status)
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)
(global-set-key (kbd "C-x p")   'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n")   'git-gutter:next-hunk)
(global-set-key (kbd "C-x r")   'git-gutter:revert-hunk)


(provide 'my-projects)
;;; my-projects.el ends here
