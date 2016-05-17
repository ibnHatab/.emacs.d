(ensure-package-installed
 'helm
 'helm-ag
 ;; 'projectile
 ;; 'helm-projectile
 'psvn
 'github-browse-file
 'magit
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

;;; Enable projectile in all buffers
;; (add-hook 'after-init-hook 'projectile-global-mode)
;; (setq projectile-completion-system 'helm)
;; (helm-projectile-on)

;; (setq-default
;;  projectile-completion-system 'helm
;;  vc-follow-symlinks 't)

;; Helmify everything
(helm-mode 1)
(setq-default
 helm-recentf-fuzzy-match 't
 helm-buffers-fuzzy-match 't
 helm-locate-fuzzy-match 't
 helm-M-x-fuzzy-match 't
 helm-imenu-fuzzy-match 't
 helm-apropos-fuzzy-match 't
 helm-lisp-completion-at-point 't)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

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
