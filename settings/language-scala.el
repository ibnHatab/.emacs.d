;;; Code:

(ensure-package-installed
 'scala-mode
 'sbt-mode
 ;; 'sbt-hydra
 'etags-select
 'ensime
 )

(add-hook 'scala-mode-hook
          (lambda ()
            (show-paren-mode)
            (smartparens-mode)
            (yas-minor-mode)
            (git-gutter-mode)
            (company-mode)
            (ensime-mode)
            (setq ensime-startup-notification nil)
            (scala-mode:goto-start-of-code)))
