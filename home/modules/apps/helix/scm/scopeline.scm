(require "scopeline/scopeline.scm")
(require "helix/editor.scm")
(require "helix/misc.scm")

(register-hook 'document-opened
  (lambda (_)
    (enqueue-thread-local-callback-with-delay
     150
     (lambda ()
       (with-handler (lambda (_) void)
         (scopeline-disable)
         (scopeline-enable))))))
