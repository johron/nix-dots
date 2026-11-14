;; scopeline.hx
;; steel-pty-fish.hx
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


;; case.hx
(require "case.hx/case.scm")

;; oil.hx
(require "oil/oil.scm")
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

(define oil-keymaps
  (hash
    "normal"
    (hash
      "-"  ":oil-up"
      "I"  ":oil-toggle-git-ignored"
      "X"  ":oil-cut"
      "c"  ":oil-clipboard-clear"
      "h"  ":oil-toggle-hidden"
      "p"  ":oil-paste"
      "ret" ":oil-enter"
      "y"  ":oil-yank")))

(define oil-keybindings (deep-copy-global-keybindings))
(merge-keybindings oil-keybindings oil-keymaps)
(set-global-buffer-or-extension-keymap
  (hash OIL-BUFFER-NAME oil-keybindings))


;; scooter.hx
(require "scooter/scooter.scm")

;; blame-line
(require "helix/editor.scm")
(require "helix/misc.scm")
(require "helix/static.scm")
(require "helix/ext.scm")
(require (prefix-in helix. "helix/commands.scm"))
(require-builtin helix/core/text as text.)

(provide blame-line)

(define (blame-run args)
  (let ([proc (~> (command "git" args)
                  with-stdout-piped
                  with-stderr-piped
                  spawn-process)])
    (if (Ok? proc)
        (trim (read-port-to-string (child-stdout (Ok->value proc))))
        #f)))

;;@doc
;; Show git blame for the current line
(define (blame-line)
  (define path (cx->current-file))
  (define dir (get-helix-cwd))
  (define line (int->string (+ (get-current-line-number) 1)))
  (if (not path)
      (set-status! "blame: no file")
      (let* ([out (blame-run (list "-C" dir "blame" "--porcelain"
                                   "-L" (string-append line "," line)
                                   "--" path))]
             [sha (and out (> (string-length out) 0)
                       (car (split-many out " ")))])
        (cond
          [(not sha) (set-status! "blame: not in a git repo")]
          [(equal? sha "0000000000000000000000000000000000000000")
           (set-status! "blame: uncommitted")]
          [else
           (set-status! (or (blame-run (list "-C" dir "show" "-s"
                                             "--format=%h %an, %ar: %s" sha))
                            "blame: git show failed"))]))))


;; grove.hx
(require "grove/grove.scm")
(require "helix/keymaps.scm")

(define (grove-workspace-launch?)
  (let loop ([args (cdr (command-line))])
    (cond
      [(null? args) #f]
      [(equal? (car args) "--") #f]
      [(or (equal? (car args) "-w")
           (equal? (car args) "--working-dir"))
       #t]
      [else (loop (cdr args))])))

(grove-start!
  #:visibility
  (if (grove-workspace-launch?) 'always 'focused))

(keymap (global)
  (normal
    (space
      (e ":grove-focus!")
      (E ":grove-visibility-toggle!"))))
