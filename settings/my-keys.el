;;; Code:

(defun switch-to-buffer-other-buffer ()
  ""
  (interactive)
  (switch-to-buffer (other-buffer)))

(global-set-key [(f1)]              'switch-to-buffer-other-buffer)
(global-set-key [(s-f1)]            'ido-switch-buffer)
(global-set-key [(C-f1)]            'helm-buffers-list)
(global-set-key [(M-f1)]            'helm-mini)
(global-set-key [(f2)]              'save-buffer)
(global-set-key [(f3)]              'find-file)
(global-set-key [(f9)]              'ack)
(global-set-key [(C-f9)]            'grep)
(global-set-key [(M-f9)]            'search-all-buffers)

(global-set-key [(f11)]             'nuke-trailing-whitespace)
(global-set-key [(C-f11)]           'cycle-my-theme)
(global-set-key [(f12)]             'kill-this-buffer)
(global-set-key [(C-f12)]           'server-edit)

(global-set-key (kbd "C-=")         'er/expand-region)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)

;; Move line/code region with M-S-Up/Down
(global-set-key [M-S-up]            'move-text-up)
(global-set-key [M-S-down]          'move-text-down)

(global-set-key "\M-,"              'pop-tag-mark)
(global-set-key (kbd "C-x \\")      'align-regexp)

(global-set-key "\M-_"              'mo-toggle-identifier-naming-style)

(global-set-key (kbd "C-h")         'delete-backward-char)
(global-set-key (kbd "M-h")         'backward-kill-word)

(setq-default save-place t)
  (autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR." t)
(global-set-key (kbd "M-z")     'zap-up-to-char)

;; (global-set-key (kbd "M-/")     'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z")     'zap-up-to-char)

(global-set-key (kbd "C-s")     'isearch-forward-regexp)
(global-set-key (kbd "C-r")     'isearch-backward-regexp)
(global-set-key (kbd "C-M-s")   'isearch-forward)
(global-set-key (kbd "C-M-r")   'isearch-backward)
(global-set-key (kbd "M-s o")   'helm-occur)

;; Undo/Redo
(global-set-key [M-backspace]    'undo)
(global-set-key [M-return]
                '(lambda () (interactive)
                   (setq last-command 'undo-toggle) ; a hack.
                   (advertised-undo)
                   (message "Undo Toggle")
                   ))

(global-set-key "\C-z"            'undo)

;; duplicate line
(global-set-key "\C-cd" "\C-a\C- \C-n\M-w\C-y\C-p\C-a")

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(define-key minibuffer-local-map [C-backspace] 'backward-delete-word)

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(defun contextual-backspace ()
  "Hungry whitespace or delete word depending on context."
  (interactive)
  (if (looking-back "[[:space:]\n]\\{2,\\}" (- (point) 2))
      (while (looking-back "[[:space:]\n]" (- (point) 1))
        (delete-char -1))
    (cond
     ((and (boundp 'smartparens-strict-mode)
           smartparens-strict-mode)
      (sp-backward-kill-word 1))
     ((and (boundp 'subword-mode)
           subword-mode)
      (subword-backward-kill 1))
     (t
      (backward-kill-word 1)))))

(global-set-key (kbd "C-<backspace>") 'contextual-backspace)

(provide 'my-keys)
