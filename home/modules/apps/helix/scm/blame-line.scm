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
