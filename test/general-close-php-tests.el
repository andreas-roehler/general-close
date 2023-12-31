;;; general-close-php-tests.el --- -*- lexical-binding: t; -*-

;; Authored and maintained by
;; Emacs User Group Berlin <emacs-berlin@emacs-berlin.org>

;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(when (file-readable-p "../.cask/24.4/elpa/php-mode-20160910.1801/php-mode.el")
    (load "../.cask/24.4/elpa/php-mode-20160910.1801/php-mode.el"))

(defvar general-close-php-test-string-1 "<?php
\$l = mysql_connect(\"localhost\", \"user\", \"passw\");
if (!\$l) die(\"Keine Verbindung zu DB\\n\");
if (mysql_select_db(\"abkuerz\", \$l))
  echo(\"DB abkuerz aktiv\\n\");
else
  die(\"Konnte keine DB finden!\\n\");
\$frage =\"describe gii\";
\$resID = mysql_query(\$frage, \$l);
\$resID = mysql_query(\$frage, \$l);

<td><?php echo \$person->getName(); ?></td>

if (!\$resID) die(\"Kein Ergebnis von DB\");
while (\$zeile = mysql_fetch_array(\$resID)) {
  echo(\$zeile[0] . \" \" . \$zeile[1] . \"\\n\");}
// echo($resID);

?>
")

(setq general-close-php-test-string-2 "<?php
\$l = mysql_connect(\"localhost\", \"user\", \"passw
?>
")

(setq general-close-php-test-string-3 "<?php
\$l = mysql_connect(\"localhost\", \"user\", \"passw\");
if (!\$l) die(\"Keine Verbindung zu DB\\n\");
if (mysql_select_db(\"abkuerz\", \$l))
  echo(\"DB abkuerz aktiv\\n\");
else
  die(\"Konnte keine DB finden!\\n\");
\$frage =\"describe gii\";
\$resID = mysql_query(\$frage, \$l);
\$resID = mysql_query(\$frage, \$l);

<td><?php echo \$person->getName(); ?></td>

if (!\$resID) die(\"Kein Ergebnis von DB\");
while (\$zeile = mysql_fetch_array(\$resID)) {
  echo(\$zeile[0] . \" \" . \$zeile[1] . \"\\n\");}
// echo($resID);

?>
")

(setq general-close-php-test-string-4
      "<?php
function €()
{
   echo 'foo';
}
?>
")

(setq general-close-php-test-string-5
      "<td><?php echo \$person->getName(); ?></td"
      )

(setq general-close-php-test-string-6 "<?php
\$l = mysql_connect(\"localhost\", \"user\", \"passw
?>
")

(ert-deftest general-close-close-php-paren-semicolon-test-1 ()
  (general-close-test-with-php-buffer-point-min
      "<?php
$l = mysql_connect(\"localhost\", \"user\", \"passw
?>"
    (search-forward "passw")
    (general-close)
    (should (eq (char-before) ?\"))))


(ert-deftest general-close-close-php-paren-semicolon-test-2 ()
  (general-close-test-with-php-buffer-point-min
      "<?php
\$l = mysql_connect(\"localhost\", \"user\", \"passw\"
?>
"    (search-forward "passw\"")
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-close-php-paren-semicolon-test-3 ()
  (general-close-test-with-php-buffer-point-min
      "<?php
\$l = mysql_connect(\"localhost\", \"user\", \"passw\")
?>"
    (search-forward "passw\")")
    (general-close)
    (should (eq (char-before) ?\;))))

(ert-deftest general-close-close-php-public-function-test ()
  (general-close-test-with-php-buffer
      "public function Foobar(){
  echo \"Foobar"
    (goto-char (point-max)) 
    (general-close)
    (should (eq (char-before) ?\"))
    (general-close)
    (should (eq (char-before) ?\;))
    (general-close)
    (should (eq (char-before) ?}))))


(ert-deftest general-close-close-php-indented-line-test ()
  (general-close-test-with-php-buffer
      "if ($foobar){
    foreach ($foobar as $key =>  $val) {
         echo $key;
	 "
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-close-php-check-indent-test-8EXbHY ()
  (let ((general-close-electric-indent-p t))
    (general-close-test-with-php-buffer
	"if ($foobar){
    foreach ($foobar as $key =>  $val) {
        echo $key\;"
      (goto-char (point-max))
      (general-close) 
      (should (eq (current-indentation) 8)))))

;; (ert-deftest general-close-close-php-check-indent-test-qwB2rb ()
;;   (let ((general-close-electric-indent-p t))
;;     (general-close-test-with-php-buffer
;; 	"if ($foobar){
;;     foreach ($foobar as $key =>  $val) {
;;         echo $key\;"
;;       (goto-char (point-max))
;;       (general-close) 
;;       (newline-and-indent)
;;       (general-close)
;;       (should (eq (current-indentation) 0)))))

(provide 'general-close-php-tests)
;;; general-close-php-tests.el ends here
