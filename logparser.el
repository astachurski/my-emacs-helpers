+ 2 1)

 

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

(setq num 3)

 

(concat filename (number-to-string num))

(defun message-time-stamp-extractor (message) ;; returns list(day,hr,min,sec)
  (save-excursion
    (setq timestampregxp "<MsgCreatTmsp>\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)T\\([0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}\\)")
    (setq dayregxp "[0-9]\\{4\\}-[0-9]\\{2\\}-\\([0-9]\\{2\\}\\)")
    (setq hrsregexp "\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\):\\([0-9]\\{2\\}\\)")
    (when (string-match timestampregxp message)
      (setq gryear (match-string 1 message)) ;;year
      (setq grhours (match-string 2 message))  ;;hours
      (when (string-match hrsregexp grhours)
                (setq grhr (match-string 1 grhours)) ;hr
                (setq grmins (match-string 2 grhours)) ;mins
                (setq grsec (match-string 3 grhours)) ;secs
                )
      )     
    (when (string-match dayregxp gryear)
      (setq grday (match-string 1 gryear))
      )
    )
  (list grday grhr grmins grsec)
  ;;(insert "\nday:" grday "\nhr:" grhr "\nmin:" grmins "\nsec:" grsec)
  )
 
 
(setq res (message-time-stamp-extractor (buffer-substring-no-properties 4479 6815)))
res



 

 

(defun read-file-to-buffer-and-process (filenamer)
  (with-temp-buffer                     ;; create virtual buffer
    (message filenamer)
    (insert-file-contents filenamer)    ;; read file to buffer
    (insert "\n---- added sumfin ----\n")
    (goto-char (point-min))
    (setq cnt 0)
    (setq ismregxp "\\(<soapenv:Envelope[[:alpha:]\|[:space:]\|[:cntrl:]\|[:digit:]\|[:ascii:]]+?</soapenv:Envelope>\\)")
    (setq opidregxp "\\(<OpId>[[:alpha:]\|[:digit:]]+?</OpId>\\)")
    (setq keyfieldsregxp "<OpId>\\([[:alpha:]\|[:digit:]]+?\\)</OpId>[[:alpha:]\|[:space:]\|[:cntrl:]\|[:digit:]\|[:ascii:]]+?<MsgInstcId>\\([[:alpha:]\|[:digit:]]+?\\)</MsgInstcId>")
    (setq useridregxp "<UserId>\\([[:alpha:]\|[:digit:]]+?\\)</UserId>")
    (setq timestampregxp "<MsgCreatTmsp>\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)T\\([0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}\\)")
    
    (while (re-search-forward ismregxp nil t)
      (setq match0 (match-string 0))
      (setq sep "\n------------\n")
      (setq cnt (+ 1 cnt))
      (with-temp-buffer
	(insert match0)
	(goto-char (point-min))
	
	(when (string-match keyfieldsregxp match0)
	  (setq id (match-string 1 match0))
	  (setq num (match-string 2 match0))
	  (insert "Transaction Op Id:" sep id sep)
	  (insert "Message Correlation Id:" sep num sep)
	  )
	
	(when (string-match useridregxp match0)
	  (setq userid (match-string 1 match0))
	  (insert "User Id:" sep userid sep)
	  )
	
	
	(setq time-data (message-time-stamp-extractor match0)) ;; returns list(day,hr,min,sec)
	(setq day (nth 0 time-data))
	(setq hour (nth 1 time-data))
	(setq min (nth 2 time-data))
	(setq sec (nth 3 time-data))
	
	(setq dir-to-write (concat "messages/" id "/" userid "/"))
	(when (not (file-exists-p dir-to-write)) ;; dont create unnecessary directories
	  (make-directory dir-to-write t )
	)


	(setq filename-to-write (concat dir-to-write "msg" num "." day "." hour min sec ".xml"))
	(when (not (file-exists-p filename-to-write))
	      (write-file filename-to-write)
	  )
	)
      )
    )
  (print cnt)
  )

 
;;(setq filenamer "c:/Users/43978999/Downloads/bib-logs/B2GInfo.log")
;;(setq filenamer "c:/Users/43978999/Downloads/bib-logs/B2GInfo-small.log")
(setq filenamer "B2GInfo.log")
;;(setq filenamer "b2ginfo-small.log")
 
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
><soapenv:Body><IFSMsgHea><soapenv:Body><IFSMsgHea (setq mark-active t)
  ;;(list p1 p2)
  )
 
 
 
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header><OpHdr><OpHdrVersNum>1.0</OpHdrVersNum><OpDefin><SvceId>UKBIB</SvceId><OpId>SI50OKYC</OpId><SvceVersNum>1.0</SvceVersNum></OpDefin></OpHdr><ISMHdr><ISMHdrVersNum>1.0</ISMHdrVersNum><AppN
2016-11-18 05:16:42,926 SessionId=_B4FoWtzTO0vOSTd2SdiEgU [WebContainer : 10] INFO  [HostName : eu420csmwas01 10.210.44.58][Loc : com.hsbc.es.hostadapter.transporter.messaging.ESMessagingByteTransporter.handle(WorkContext,byte[]):byte[]][Desc : Response:<?xml version="1.0" encodi
 
 
;; this works on literal string
(progn
  (setq str "vceId><OpId>SI50OKYC</OpId><SvceVe")
  (setq opidregxp "\\(<OpId>[[:alpha:]\|[:digit:]]+?</OpId>\\)")
  ;;(goto-char (point-min))
  (string-match opidregxp str)
  (match-string 1 str)
  )
 
;; this works on text extracted from buffer by points + excursion save
(progn
  (save-excursion
    (setq str1 (buffer-substring 5131 6470))
    (setq useridregxp "<UserId>\\([[:alpha:]\|[:digit:]]+?\\)</UserId>")
    (string-match useridregxp str1)
    (setq out (match-string 1 str1))
    (insert out)
   )
  )
 
 
 
 
 
 
 
(print (point))
 
(progn
  (get-buffer-create "sikanka")
  (set-buffer "sikanka")
  (insert "pupu\n")
  )
 
 
 
 
;; lisp-complete-symbol
 
 
 
 
 
 
