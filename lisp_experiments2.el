(show-paren-mode 1)

;; https://emacs-doctor.com/learn-emacs-lisp-in-15-minutes.html
(+ 2 1)

;; M-/ for completion cycle
;; lisp-complete-symbol

(setq bub (/ 3 2.0))

(defun siku()
   '(1 2 3)
   )

(princ (siku))

(setq k 234)
(princ k)
(insert "%D" k)



;; https://github.com/chrisdone/elisp-guide#navigating-the-buffer
;; https://www.emacswiki.org/emacs/ElispCookbook

(defun dupa()
  "rstr"
  (interactive)
  ;;(let ((beg (point))) (forward-line 1) (delete-region beg (point)))
  ;;(push-mark (point) t nil)
  ;;(buffer-size)
  (beginning-of-buffer)
  (setq mylist ())
  (while (search-forward "<soapenv:Envelope")
    (insert "<--- found -- ")
    (princ (point))
    ;;(add-to-list 'mylist "ser")
    ;;(cons 'mylist "ueno")
  )

  )

;;(with-temp-buffer
;;  (insert "pupu"))

(setq fp "/home/adrian/Documents/org/B2GInfo.log")

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(get-string-from-file fp)


;; print a line many times
(defun kaka()
  (interactive)

  (beginning-of-buffer)
  (setq mylist ())
  (while (search-forward "<soapenv:Envelope")
    (with-temp-buffer
      (insert "<--- found -- ")
      (point)
      )
    ;;(add-to-list 'mylist "ser")
    ;;(cons 'mylist "ueno")
  )
  
  )

(defun match-strings-all (&optional string)
  (interactive)
  (let ((n-matches (1- (/ (length (match-data)) 2))))
    (mapcar (lambda (i) (match-string i string))
	    (number-sequence 0 n-matches))))

(let ((str "time help"))
  (string-match "time \\([A-Za-z]+\\)$" str)
  (match-strings-all str))



(defun myfun()
  "bubu ga"
  (interactive)
  (push-mark)
  (goto-char (point-min))

  )



(defun map-regex (buffer regex fn)
  "Map the REGEX over the BUFFER executing FN.
   FN is called with the match-data of the regex.
   Returns the results of the FN as a list."
  (with-current-buffer buffer
    (save-excursion
      (goto-char (point-min))
      (let (res)
	(save-match-data
	  (while (re-search-forward regex nil t)
	    (let ((f (match-data)))
	      (setq res
		    (append res
			    (list
			     (save-match-data
			       (funcall fn f))))))))
	res))))


(with-temp-buffer
  (insert "\n\nbu<pi>brestaresntr raesn</pi>tarseit" )
  (insert "\n\<pi>erstre89r  rstrntr raesn</pi>tarseit" )
  (insert "\n\ocuments and XML<mytag> processors are permitted to but need n<pi>erstr" )
  (goto-char (point-min))
  (re-search-forward "myt")
  (setq sruk (list (point) "siku" "kupa"))
  ;;(setq lili (list sruk (thing-at-point 'word)))
  (length sruk)
  (buffer-name)
  (buffer-string)

  )

(defun write-content-to-file(content-to-write fname)
  (if (file-exists-p fname)        ;;checking if file exists
      (delete-file fname))
  (find-file fname)                ;;switch (create) buffer and edit file in buffer
  (insert content-to-write)
  (save-buffer)                    ;; write to associated file
  (kill-buffer fname)
  (message "saved file %S" fname)
  )

(setq filename "delme2.xml")
(write-content-to-file "sipanka i kupanka" filename)


(defun read-file-to-buffer-and-process (filenamer)
  (with-temp-buffer                     ;; create virtual buffer
    (message filenamer)
    (insert-file-contents filenamer)    ;; read file to buffer
    (insert "\n---- added sumfin ----\n")
    (goto-char (point-min))
    (setq cnt 0)
    (setq ismregxp "\\(<soapenv:Envelope[[:alpha:]\|[:space:]\|[:cntrl:]\|[:digit:]\|[:ascii:]]+?</soapenv:Envelope>\\)")
    (setq opidregxp "\\(<OpId>[[:alpha:]\|[:digit:]]+?</OpId>\\)")

    (while (re-search-forward ismregxp nil t)
      (setq before-search-p (point)) 
      (setq match0 (match-string 0))
      (setq sep "\n====match======\n")
      (insert sep match0 sep)
      (setq cnt (+ 1 cnt))

      ;; let's try to find opcode inside matched string
      ;; (save-restriction
      ;; 	(goto-char before-search-p)  
      ;; 	(if (re-search-forward opidregxp nil t)
      ;; 	    (setq match-int0 (match-string 0))
      ;; 	  (message "foun opcode!")
      ;; 	  )
      ;; 	)
      
      )

    (print "matches:")
    (print cnt)
    (beginning-of-buffer)
    ;;(write-content-to-file (buffer-string) "delme-modified.xml")
    (message (buffer-name))
    (write-file "delme-modified5.xml")   ;; write current buffer under a name
    )
  )


;; "\\(sraka[[:alpha:]\|[:space:]\|[:cntrl:]]+?nieboraka\\)"
;; "\\(<soapenv:Envelope[[:alpha:]\|[:space:]\|[:cntrl:]\|[:digit:]\|[:ascii:]]+?</soapenv:Envelope>\\)"

;;"\\(<OpId>[[:alpha:]\|[:digit:]]+?</OpId>\\)"

;;(setq filenamer "delme2.xml")
(setq filenamer "B2GInfo.log")
;;(setq filenamer "dupatest")
(read-file-to-buffer-and-process filenamer)

;;(setq pupu (point))

;;http://ergoemacs.org/emacs/elisp_buffer_file_functions.html

(defun dupa2()
  (interactive)
  (set-buffer "pupu.xml")
  (goto-char (point-min))
  (setq p1 (re-search-forward "<mytag>" nil t))
  (setq p2 (re-search-forward "</mytag>" nil t))
  (goto-char p1)
  (push-mark p2)
  (setq mark-active t)
  ;;(list p1 p2)
)

;; lisp-complete-symbol





