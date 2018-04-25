(setq-default
 dired-recursive-copies 'always
 dired-recursive-deletes 'always
 dired-dwim-target t
 dired-hide-details-hide-symlink-targets nil)

(setq-default frame-title-format
              '(:eval
                (format "%s@%s: %s %s"
                        (or (file-remote-p default-directory 'user)
                            user-real-login-name)
                        (or (file-remote-p default-directory 'host)
                            system-name)
                        (buffer-name)
                        (cond
                         (buffer-file-truename
                          (concat "(" buffer-file-truename ")"))
                         (dired-directory
                          (concat "{" dired-directory "}"))
                         (t
                          "[no file]")))))

(setq tramp-default-method "ssh")
(setq tramp-chunksize 500)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(provide 'my-directory)
