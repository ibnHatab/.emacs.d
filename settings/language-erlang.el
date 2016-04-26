;;; Code:

(ensure-package-installed
 'edts
 'elixir-mode
 'alchemist
 )

(add-hook 'after-init-hook 'edts-after-init-hook)
(defun edts-after-init-hook ()
  (require 'edts-start)
  (local-set-key "\C-c\C-z" 'edts-shell))

;; Interworking

(setq alchemist-goto-erlang-source-dir "/local/vlad/repos/erlang/otp_src_18.3")
(setq alchemist-goto-elixir-source-dir "/local/vlad/repos/erlang/elixir")

(defun custom-erlang-mode-hook ()
  (define-key erlang-mode-map (kbd "M-,") 'alchemist-goto-jump-back))
(add-hook 'erlang-mode-hook 'custom-erlang-mode-hook)


;; elixir
(require 'elixir-mode)
(require 'alchemist)
(require 'flycheck)

(add-hook 'elixir-mode-hook 'alchemist-mode)

(add-to-list 'elixir-mode-hook
             (defun my-emlixir-mode-hook ()
               (company-mode)
               (define-key elixir-mode-map (kbd "M-TAB")   'company-complete)
               (define-key elixir-mode-map (kbd "C-c C-s") 'alchemist-iex-project-run)
               (define-key elixir-mode-map (kbd "C-c C-z") 'alchemist-iex-start-process)
               (define-key elixir-mode-map (kbd "C-c C-r") 'alchemist-iex-send-region-and-go)
               (define-key elixir-mode-map (kbd "C-c C-c") 'alchemist-iex-send-current-line-and-go)
               (define-key elixir-mode-map (kbd "C-c C-d") 'alchemist-help-search-at-point)

               (define-key elixir-mode-map (kbd "C-c C-l") 'alchemist-iex-compile-this-buffer)
               (define-key elixir-mode-map (kbd "C-c C-t") 'alchemist-mix-test)
               (alchemist-iex-program-name "iex --sname iex")))


(add-to-list 'alchemist-iex-mode-hook
             (defun my-alchemis-mode-hook ()
               (company-mode)
;;               (define-key elixir-mode-map (kbd "M-TAB")   'company-complete)
               (define-key elixir-mode-map (kbd "C-c C-d") 'alchemist-help-search-at-point)
               ))

(flycheck-define-checker elixir
  "An Elixir syntax checker using the Elixir interpreter.
See URL `http://elixir-lang.org/'."
  :command ("elixirc"
            "-o" temporary-directory    ; Move compiler output out of the way
            "--ignore-module-conflict"  ; Prevent tedious module redefinition
                                        ; warning.
            source)
  :error-patterns
  ;; Elixir compiler errors
  ((error line-start "** (" (zero-or-more not-newline) ") "
          (file-name) ":" line ": " (message) line-end)
   ;; Warnings from Elixir >= 0.12.4
   (warning line-start (file-name) ":" line ": warning:" (message) line-end)
   ;; Warnings from older Elixir versions
   (warning line-start (file-name) ":" line ": " (message) line-end))
  :modes elixir-mode)

(add-to-list 'flycheck-checkers 'elixir)

(sp-with-modes '(elixir-mode)
  (sp-local-pair "fn" "end"
         :when '(("SPC" "RET"))
         :actions '(insert navigate))
  (sp-local-pair "do" "end"
         :when '(("SPC" "RET"))
         :post-handlers '(sp-ruby-def-post-handler)
         :actions '(insert navigate)))


(provide 'language-erlang)
