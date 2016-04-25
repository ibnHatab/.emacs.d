(ensure-package-installed
 ;; Navigation
 'ace-jump-mode
 'multiple-cursors
 'expand-region
 'neotree
 'buffer-move
 'ack
 'bm)


(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; Fast movements
(global-set-key [C-right]       'forward-word)
(global-set-key [C-left]        'backward-word)
(global-set-key [?\C-\.]        'goto-line)
(global-set-key [C-delete]      'kill-word)
(global-set-key [ESC-backspace] 'backward-kill-word)
(global-set-key [C-backspace]   'backward-kill-word)

(global-set-key [C-escape]          'helm-buffers-list)

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
(global-set-key (kbd "C-a") 'smart-line-beginning)

(global-set-key (kbd "s-s")         'neotree-toggle)
(global-set-key (kbd "s-a")         'neotree-find)

(global-set-key [s-S-up]   'delete-other-windows-vertically)
(global-set-key [s-S-down] 'delete-other-windows-vertically)

(global-set-key [M-s-up]     'buf-move-up)
(global-set-key [M-s-down]   'buf-move-down)
(global-set-key [M-s-left]   'buf-move-left)
(global-set-key [M-s-right]  'buf-move-right)

(global-set-key [s-left]  'windmove-left-cycle)         ; move to left windnow
(global-set-key [s-right] 'windmove-right-cycle)        ; move to right window
(global-set-key [s-up]    'windmove-up-cycle)           ; move to upper window
(global-set-key [s-down]  'windmove-down-cycle)         ; move to downer window

;; Bookmark
(global-set-key (kbd "<C-f2>")   'bm-toggle)
(global-set-key (kbd "<M-f2>")   'bm-next)
(global-set-key (kbd "<S-f2>")   'bm-previous)
(global-set-key (kbd "<S-M-f2>") 'bm-show-all)

(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)

(provide 'my-navigation)
