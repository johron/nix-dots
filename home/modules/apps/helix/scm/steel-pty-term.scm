(require "steel-pty-fish/term.scm")
(require "helix/keymaps.scm")

(keymap (global)
  (normal
    (space
      (t
        (t ":open-term")
        (n ":new-term")
        (s ":switch-term")
        (h ":hide-terminal")
        (q ":kill-active-terminal")))))
