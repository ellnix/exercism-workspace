(ns leap)

(defn leap-year? [year] ;; <- argslist goes here
  (and
   (zero? (mod year 4))
   (or
    (not (zero? (mod year 100)))
    (zero? (mod year 400)))))
