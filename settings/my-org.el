;;; Code:

(ensure-package-installed
 'ox-reveal
 )

(require 'org-install)
(require 'org)
(require 'ox-reveal)

(add-hook 'org-mode-hook 'flyspell-mode)


(define-obsolete-function-alias 'org-define-error 'define-error)

(setq org-reveal-root "https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.6.0/")
(setq org-reveal-title-slide nil)

(org-babel-do-load-languages 'org-babel-load-languages
    '(
      (shell . t)
      (python . t)
      (plantuml . t)
      ))

(setq org-plantuml-jar-path
      (expand-file-name "/usr/share/plantuml/plantuml.jar"))

(custom-set-variables
 '(org-confirm-babel-evaluate nil)
 '(org-support-shift-select t))

(defun vki:open-default-notes-file ()
 "Open a file containing refil collection"
 (interactive)
 (find-file org-default-notes-file))

(global-set-key (kbd "C-c l") 'org-store-link)


;;(global-set-key (kbd "<f10> <f10>")  'org-cycle-agenda-files)
;;(global-set-key (kbd "<f10> c")     'cfw:open-org-calendar)
;;(global-set-key (kbd "<f10> w")     'widen)
;;(global-set-key (kbd "<f10> v")     'visible-mode)
;;(global-set-key (kbd "<f10> r")     'org-refile)
;;(global-set-key (kbd "<f10> m")     'org-manage)
;;(global-set-key (kbd "<f10> j")     'vki:open-default-notes-file)
;;(global-set-key (kbd "<f10> S")     'org-todo)
;;(global-set-key (kbd "<f10> d")     'org-deadline)
;;(global-set-key (kbd "<f10> s")     'org-schedule)
;;(global-set-key (kbd "<f10> t")     'org-time-stamp-inactive)
;;(global-set-key (kbd "<f10> T")     'org-toggle-timestamp-type)
;;(global-set-key (kbd "<f10> SPC")   'org-clock-in)
;;(global-set-key (kbd "<f10> s-SPC") 'org-clock-goto)
;;(global-set-key (kbd "<f10> p")     'org-taskjuggler-export-and-process)
;;(global-set-key (kbd "M-<f10>") 'org-toggle-inline-images)

(provide 'my-org)
;;; language-c.el ends here
