(ensure-package-installed
 ;; Navigation
 'ace-jump-mode
 'multiple-cursors
 'expand-region
 'neotree
 'buffer-move
 'ack)

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)

(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(global-set-key "\C-z"            'undo)
(global-set-key (kbd "C-x \\")      'align-regexp)
(global-set-key [C-right]       'forward-word)
(global-set-key [C-left]        'backward-word)
(global-set-key [?\C-\.]        'goto-line)
(global-set-key [C-delete]      'kill-word)
(global-set-key [ESC-backspace] 'backward-kill-word)
(global-set-key [C-backspace]   'backward-kill-word)

(global-set-key [C-escape]          'helm-buffers-list)

(global-set-key [(f9)]         'ack)
(global-set-key [(C-f9)]       'grep)
(global-set-key [(M-f9)]       'search-all-buffers)

(global-set-key [(f11)]         'nuke-trailing-whitespace)
(global-set-key [(C-f11)]       'cycle-my-theme)
(global-set-key [(f12)]         'kill-this-buffer)
(global-set-key [(C-f12)]       'server-edit)

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

(provide 'my-navigation)
