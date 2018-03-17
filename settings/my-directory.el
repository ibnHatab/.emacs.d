(setq-default
 dired-recursive-copies 'always
 dired-recursive-deletes 'always
 dired-dwim-target t
 dired-hide-details-hide-symlink-targets nil)

(setq tramp-default-method "ssh")
(setq tramp-chunksize 500)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(provide 'my-directory)
