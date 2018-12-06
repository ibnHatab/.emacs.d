(ensure-package-installed
 'engine-mode)

(require 'engine-mode)
(engine-mode 1)

(setq engine/browser-function 'browse-url-firefox)

(defengine duckduckgo
  "https://duckduckgo.com/?q=%s"
  :keybinding "d")

(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")

(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s")

(defengine rust
  "https://doc.rust-lang.org/std/io/type.Result.html?search=%s"
  :keybinding "r")

(defengine crates
  "https://crates.io/search?q=%s"
  :keybinding "c")



(provide 'my-engine)
;;; my-engine.el ends here
