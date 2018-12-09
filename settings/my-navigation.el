;;; Code:

(ensure-package-installed
 ;; Navigation
 'ace-jump-mode
 'multiple-cursors
 'expand-region
 'neotree
 'ack
;; 'cycbuf
 'company
 'bm)

(setq scroll-step 1)                    ; scrolling page

(require 'windcycle)

(global-set-key (kbd "C-\\")    'ace-jump-mode)

;; Fast movements
(global-set-key [C-right]       'forward-word)
(global-set-key [C-left]        'backward-word)
(global-set-key [?\C-\.]        'goto-line)
(global-set-key [C-delete]      'kill-word)
(global-set-key [ESC-backspace] 'backward-kill-word)
(global-set-key [C-backspace]   'backward-kill-word)

(global-set-key [C-escape]      'helm-buffers-list)

(defun search-all-buffers (regexp)
  (interactive "sRegexp: ")
  (multi-occur-in-matching-buffers "." regexp t))

(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))
(global-set-key (kbd "C-a")           'smart-line-beginning)

(global-set-key (kbd "s-s")           'neotree-toggle)
(global-set-key (kbd "s-a")           'neotree-find)

(global-set-key [s-S-up]              'delete-other-windows-vertically)
(global-set-key [s-S-down]            'delete-other-windows-vertically)

(global-set-key [M-s-up]              'buffer-up-swap)
(global-set-key [M-s-down]            'buffer-down-swap)
(global-set-key [M-s-left]            'buffer-left-swap)
(global-set-key [M-s-right]           'buffer-right-swap)

(global-set-key (kbd "S-M-s-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-s-<down>")  'shrink-window)
(global-set-key (kbd "S-M-s-<up>")    'enlarge-window)

(global-set-key [s-left]  'windmove-left-cycle)
(global-set-key [s-right] 'windmove-right-cycle)
(global-set-key [s-up]    'windmove-up-cycle)
(global-set-key [s-down]  'windmove-down-cycle)

;; (global-set-key  [(meta right)] 'cycbuf-switch-to-next-buffer)
;; (global-set-key  [(meta left)] 'cycbuf-switch-to-previous-buffer)
;; (global-set-key  [M-right] 'cycbuf-switch-to-next-buffer-no-timeout)
;; (global-set-key  [M-left] 'cycbuf-switch-to-previous-buffer-no-timeout)


;; Bookmark
(global-set-key (kbd "<C-f2>")   'bm-toggle)
(global-set-key (kbd "<M-f2>")   'bm-next)
(global-set-key (kbd "<S-f2>")   'bm-previous)
(global-set-key (kbd "<S-M-f2>") 'bm-show-all)

(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

;;
(setq helm-mini-default-sources
      '(helm-source-buffers-list
        helm-source-bookmarks
        helm-source-recentf
        helm-source-buffer-not-found))

;; IDO
(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)

(provide 'my-navigation)
