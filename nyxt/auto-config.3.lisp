(defmethod customize-instance ((input-buffer input-buffer) &key)
  (disable-modes* 'nyxt/mode/emacs:emacs-mode input-buffer)
  (enable-modes* 'nyxt/mode/vi:vi-normal-mode input-buffer))
(define-configuration prompt-buffer
  ((default-modes (append '(vi-insert-mode) %slot-default%))))
(defmethod customize-instance ((browser browser) &key)
  (setf (slot-value browser 'theme) theme:+light-theme+))

(define-configuration :hint-mode
  ((hinting-type :vi)))

;; Does this require:
;; 1. Quick lisp to be manualy installed
;; 2. Running Nyxt from a live lisp installation rather than a compiled binary?
;;;; Load quicklisp
#-quicklisp
(let ((quicklisp-init
       (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(ql:quickload '("lquery"))

;;;; Regex parsing HTML source for implicit buttons?
; Like ISBN (more widely applicable than Amazon-specific solution), Amazon URL, etc :-?


;; Get a list of all links from a webpage?

;;;; The right substrate to support items+labels for effective filtering

;;;; Fetch archive, from one of the sources
;; Make the source choosable in the prompt-buffer
(define-command-global fetch-url-from-archive ()
  "Fetch the latest snapshot of the URL available in a chosen archive."
  (let ((buf-url (quri:render-uri (url (current-buffer))))
        (chosen-archive (first (prompt :prompt "Choose your desired archive"
                                       :sources (make-instance
                                          'prompter:source
                                          :name "Archive sites"
                                          :constructor '("https://web.archive.org/web/"
                                                         "https://archive.ph/timegate/"))))))
    (buffer-load (str:concat chosen-archive buf-url))))

;;;; Reddit to Teddit
(defun reddit-url-to-teddit-url (url)
  (cl-ppcre:regex-replace-all "reddit.com" url "teddit.net"))
(define-command-global reddit-to-teddit ()
  "Reopen the current Reddit URL via Teddit"
  (let ((buf-url (quri:render-uri (url (current-buffer)))))
    (buffer-load (reddit-url-to-teddit-url buf-url))))


(defparameter *REDIRECT-RULES* (list   (cons "reddit.com" "teddit.net")
                                       (cons "twitter.com" "nitter.net")
                                       (cons "medium.com" "scribe.rip")))

(defun get-cleaner-website-url (url)
  (let* ((domain (quri:uri-domain (quri:uri url)))
         (redirect-from-to (assoc (intern domain) *REDIRECT-RULES* :test #'string=))
         (redirect-from (car redirect-from-to))
         (redirect-to (cdr redirect-from-to)))
    (cl-ppcre:regex-replace-all redirect-from url redirect-to)))

(define-command-global redirect-clean ()
  "Redirect to a cleaner version of the website based on lookup table"
  (let ((buf-url (quri:render-uri (url (current-buffer)))))
    (buffer-load (get-cleaner-website-url buf-url))))


