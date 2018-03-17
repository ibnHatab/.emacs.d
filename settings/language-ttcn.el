
(add-to-list
 'load-path
 (expand-file-name "local/ttcn" user-emacs-directory))

(require 'cc-mode)
(require 'easymenu)
(require 'ttcn3)

(autoload 'ttcn-3-mode "ttcn-3-mode" "TTCN3 editing mode." t)
(setq auto-mode-alist (cons '("\\.ttcn3?" . ttcn-3-mode) auto-mode-alist))

(add-hook 'ttcn3-mode-hook '(lambda ()
                                 (turn-on-font-lock)
                            ))

(provide 'language-ttcn)
