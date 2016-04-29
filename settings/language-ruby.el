;;; Code:

(ensure-package-installed
 'web-mode
 'robe)

(require 'smartparens-config)
(require 'smartparens-ruby)

(add-hook 'enh-ruby-mode-hook
          (lambda () (flyspell-prog-mode)))
(add-hook 'web-mode-hook
          (lambda () (flyspell-prog-mode)))
;; (setq enh-ruby-program "~/.rvm/rubies/ruby-2.2.0/bin/ruby")
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-hook 'enh-ruby-mode-hook 'robe-mode)
;;; (add-hook 'web-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'yard-mode)
(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
;; (add-hook 'after-init-hook 'inf-ruby-switch-setup) ;debug compilation

(add-hook 'enh-ruby-mode-hook 'company-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))


(add-hook 'ruby-mode-hook 'minitest-mode)
(eval-after-load 'minitest
  '(minitest-install-snippets))

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby pathrocess" t)
(autoload 'inf-ruby-keys "inf-ruby" "" t)
(eval-after-load 'enh-ruby-mode
  '(add-hook 'ruby-mode-hook 'inf-ruby-keys))
(eval-after-load 'enh-ruby-mode
  '(add-hook 'ruby-mode-hook 'robe-start))

(sp-with-modes '(web-mode)
               (sp-local-pair "<" ">")
               (sp-local-pair "<%" "%>"))

(add-hook 'enh-ruby-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-c")   'ruby-send-region-and-go)
             (define-key enh-ruby-mode-map (kbd "M-TAB") 'robe-complete-at-point)
             (define-key enh-ruby-mode-map (kbd "C-c C-z") 'inf-ruby)))

(provide 'language-ruby)
