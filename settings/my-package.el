;;; Code:

;(setq url-using-proxy t)
;(setq url-proxy-services
;      '(
;        ("no_proxy" . "^\\(localhost\\|maveric\\|10.*\\|0:4587\\|127.*\\|.*:24969\\)")
;        ("no_proxy" . ".*:4587")
;        ("http"     . "135.245.192.7:8000")
;        ("https"    . "135.245.192.7:8000")))
;
;(setq url-http-proxy-basic-auth-storage
;    (list (list "135.245.192.7:8000"
;                (cons "Input your LDAP UID !"
;                      (base64-encode-string "vkinzers:zaq1!QAZ")))))
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-refresh-contents)
       (package-install package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(provide 'my-package)
