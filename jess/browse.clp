;; ----------------------------------------------------------------------
;; BROWSE.CLP
;; Simple demo for the (socket) function in Jess 4.0
;; ----------------------------------------------------------------------

(deffunction get-web-page (?url)
  "Return the contents of a web page as a string"

  (if (<> 1 (str-index "http://" ?url)) then
    (return "ERROR: Only HTTP URLS supported"))

  (bind ?url (sub-string 8 (str-length ?url) ?url))
  (bind ?host (sub-string 1 (- (str-index "/" ?url) 1) ?url))
  (bind ?doc (sub-string (str-index "/" ?url) (str-length ?url) ?url))

  (socket ?host 80 gwp)
  (printout gwp "GET " ?doc crlf crlf)
  (bind ?retval "")
  (bind ?line (readline gwp))
  (while (neq ?line EOF) do
    (bind ?retval (str-cat ?retval ?line))
    (bind ?line (readline gwp)))
  (return ?retval)
)

(open "MyWebPage.html" mwp "w")
(printout mwp (get-web-page "http://herzberg.ca.sandia.gov/index.html") crlf)
(close mwp)