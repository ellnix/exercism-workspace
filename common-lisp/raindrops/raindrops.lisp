(defpackage :raindrops
  (:use :cl)
  (:export :convert))

(in-package :raindrops)

(defun drops(n) 
  (concatenate 'string
          (if (= (mod n 3) 0) "Pling")
          (if (= (mod n 5) 0) "Plang")
          (if (= (mod n 7) 0) "Plong")
          )
  )

(defun convert (n)
  (let((sound (drops n)))
    (if (equal sound "") (write-to-string n) sound)
    )
  )
