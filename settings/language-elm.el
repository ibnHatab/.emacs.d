;;; Code:

(ensure-package-installed
 'elm-mode
 'flycheck-elm
 )

(require 'flycheck)
(require 'company)

(with-eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-elm))
(add-hook 'elm-mode-hook #'elm-oracle-setup-completion)

(provide 'language-elm)
;;;
