;;; Code:

(ensure-package-installed
 'erlang
 )

(add-to-list 'auto-mode-alist '("rebar.config" . erlang-mode))

(setq load-path (cons "/usr/lib/erlang/lib/tools-2.8.3/emacs" load-path))

(require 'erlang-start)
(setq erlang-root-dir "/usr/lib/erlang/")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(setq erlang-man-root-dir "/usr/lib/erlang/man")


(push "~/.emacs.d/distel/elisp/" load-path)
(require 'distel)
(distel-setup)

;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)
;; default node name to emacs@localhost
(setq inferior-erlang-machine-options '("-sname" "emacs"))
;; tell distel to default to that node
;; (setq erl-nodename-cache
;;       (make-symbol
;;        (concat
;;         "emacs@"
;;         (car (split-string (shell-command-to-string "hostname"))))))


(push "~/.emacs.d/distel-completion/" load-path)

(require 'company-distel)
(add-to-list 'company-backends 'company-distel)
(setq distel-completion-valid-syntax "a-zA-Z:_-")

(add-hook 'erlang-mode-hook
          (lambda ()
            (local-set-key [(M-tab)]   'company-complete)
            (setq inferior-erlang-machine-options
                  '(
                    "-sname" "emacs"
                    "-remsh" "rebar@maveric"
                    ;; "-remsh" "rebar@127.0.0.1"
                    ))
            (auto-highlight-symbol-mode)
            (local-set-key [(meta \()] 'erl-openparen)
            (setq company-backends '(company-distel))))

(add-hook 'erlang-shell-mode-hook
          (lambda ()
            (setq company-backends '(company-distel))))

(require 'flycheck)
;; TODO https://github.com/doppioslash/dotfiles/blob/master/emacs/.emacs

(flycheck-define-checker erlang-otp
  "An Erlang syntax checker using the Erlang interpreter."
  :command ("flycheck-erlang" source-original
             ;;   "erlc" "-o" temporary-directory "-Wall"
             ;; "-I" "../include" "-I" "../../include"
             ;; "-I" "_build/default/lib/*/include"
             ;; "-I" "../../../include" source
             )
  :error-patterns
  ((warning line-start (file-name) ":" line ": Warning:" (message) line-end)
   (error line-start (file-name) ":" line ": " (message) line-end)))

(add-hook 'erlang-mode-hook
          (lambda ()

            (flycheck-select-checker   'erlang-otp)
            (flycheck-mode)))

(sp-with-modes '(erlang-mode)
  ;; (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "(" ")")
;;  (sp-local-pair  "(" ")" :insert "C-b l" :trigger "\\l(")
  ;; (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
  ;;                                           ("* ||\n[i]" "RET")))

  )

(provide 'language-erlang)
