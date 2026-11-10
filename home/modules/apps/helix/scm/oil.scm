(require "oil/oil.scm")
; (require "helix/keymaps.scm")

; (define oil-keymaps
;   (hash
;     "normal"
;     (hash
;       "-"  ":oil-up"
;       "I"  ":oil-toggle-git-ignored"
;       "X"  ":oil-cut"
;       "c"  ":oil-clipboard-clear"
;       "h"  ":oil-toggle-hidden"
;       "p"  ":oil-paste"
;       "q"  ":oil-close"
;       "ret" ":oil-enter"
;       "w"  ":oil-save"
;       "y"  ":oil-yank")))

; (define oil-keybindings (deep-copy-global-keybindings))
; (merge-keybindings oil-keybindings oil-keymaps)
; (set-global-buffer-or-extension-keymap
;   (hash OIL-BUFFER-NAME oil-keybindings))


(require "helix/keymaps.scm")

(keymap (global)
  (normal
    (space
      (o
        (o ":oil")
        (e ":oil-enter")
        (b ":oil-up")
        (g ":oil-root")
        (s ":oil-save")
        (r ":oil-refresh")
        (q ":oil-close")
        (h ":oil-toggle-hidden")
        (i ":oil-toggle-git-ignored")
        (t ":oil-toggle-metadata")
        (m
          (y ":oil-yank")
          (x ":oil-cut")
          (p ":oil-paste")
          (c ":oil-clipboard-clear"))))))
