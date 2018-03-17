
(require 'tla-mode)

(require 'flycheck-tla)
(add-hook 'tla-mode-hook 'flycheck-mode)

(provide 'language-tla)
