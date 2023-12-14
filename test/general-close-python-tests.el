;;; general-close-python-tests.el --- Python tests -*- lexical-binding: t; -*-

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

;; (setq  general-close-debug-p t)

(ert-deftest general-close-python-no-colon-test-blHQQc1 ()
  (general-close-test-with-python-buffer
      "print(1)"
    (let ((orig (point)))
      (general-close)
      (should (eq (char-before) ?\)))
      (should (eq (point) orig)))))

(ert-deftest general-close-python-tqs-sq-test-tmeKth ()
  (general-close-test-with-python-buffer
      "'''asdf"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (sit-for 0.1)
    (should (char-equal (char-before) ?'))))

(ert-deftest general-close-python-tqs-dq-test-10mjq3 ()
  (general-close-test-with-python-buffer
      "\"\"\"asdf"
    (goto-char (point-max))
    (general-close)
    (should (char-equal (char-before) ?\"))))

(ert-deftest general-close-python-sq-test-UM9ZGb ()
  (general-close-test-with-python-buffer
      "'asdf"
    (goto-char (point-max))
    (general-close)
    (should (looking-back "'asdf'" (line-beginning-position)))))

(ert-deftest general-close-python-dq-test-Zu6qkI ()
  (general-close-test-with-python-buffer
      "\"asdf"
    (goto-char (point-max))
    (general-close)
    (should (looking-back "\"asdf\"" (line-beginning-position)))))

(ert-deftest general-close-python-f-string-test-Zu6qkI ()
  (general-close-test-with-python-buffer
      "print(f\"Elementweise Addition: {m1 + m2"
    (goto-char (point-max))
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-test-JaSpMC ()
  (general-close-test-with-python-buffer
      "print(f'{val:.5f}"
    (goto-char (point-max))
    (general-close)
    (should (eq (char-before) ?'))))

(ert-deftest general-close-python-f-string-test-UAau25 ()
  (general-close-test-with-python-buffer
      ;; print(f'{name} is {age} years old')
      "print(f'{name} is {age} years old"
    (goto-char (point-max))
    (general-close)
    (should (eq (char-before) ?'))))

(ert-deftest general-close-python-f-string-test-2EO5o1 ()
  (general-close-test-with-python-buffer
      ;; "f'Useless use of lambdas: { (lambda x: x*2) }'"
      "f'Useless use of lambdas: { (lambda x: x*2"
        (goto-char (point-max))
    (general-close)
    (should (eq (char-before) 41))))

(ert-deftest general-close-python-f-string-test-6Uxxl9 ()
  (general-close-test-with-python-buffer
      ;; "f'Useless use of lambdas: { (lambda x: x*2) }'"
      "f'Useless use of lambdas: { (lambda x: x*2)"
        (goto-char (point-max))
    (general-close)
    (should (eq (char-before) ?}))
    (should (looking-back " }" (line-beginning-position)))
    ))

(ert-deftest general-close-python-f-string-test-CTDV8M ()
  (general-close-test-with-python-buffer
      ;; f"{f"{f"{f"{f"{f"{1+1}"}"}"}"}"}"
      "f\"{f\"{f\"{f\"{f\"{f\"{1+1"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-test-ebhiJC ()
  (general-close-test-with-python-buffer
      ;; f"{f"{f"{f"{f"{f"{1+1}"}"}"}"}"}"
      "f\"{f\"{f\"{f\"{f\"{f\"{1+1}"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-nT3Fk4 ()
  (general-close-test-with-python-buffer
      ;; f"{f"{f"{f"{f"{f"{1+1}"}"}"}"}"}"
      "f\"{f\"{f\"{f\"{f\"{f\"{1+1}\""
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (sit-for 0.1)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-oSy3hU ()
  (general-close-test-with-python-buffer
      ;; "f"{f"{f"{f"{f"{f"{1+1}"}""
      "f\"{f\"{f\"{f\"{f\"{f\"{1+1}\"}\""
      (goto-char (point-max))
      (skip-chars-backward " \t\r\n\f")
      (general-close)
      (sit-for 0.1)
      (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-test-5HXb1B ()
  (general-close-test-with-python-buffer
      ;; f"These are the things: {", ".join(things)}"
      "f\"These are the things: {\", "
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-K09GhX ()
  (general-close-test-with-python-buffer
      ;; f"These are the things: {", ".join(things)}"
      "f\"These are the things: {\", \".join(things"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-python-f-string-test-N5TNUY ()
  (general-close-test-with-python-buffer
      ;; f"These are the things: {", ".join(things)}"
      "f\"These are the things: {\", \".join(things)"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-test-78lsBi ()
  (general-close-test-with-python-buffer
      ;; "f\" something { my_dict[\"key\"] } something else \""
      "f\" something { my_dict[\"key"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-xIRjat ()
  (general-close-test-with-python-buffer
      ;; "f\" something { my_dict[\"key\"] } something else \""
      "f\" something { my_dict[\"key\""
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close-python-f-string-test-vXRG8O ()
  (general-close-test-with-python-buffer
      ;; "f\" something { my_dict[\"key\"] } something else \""
      "f\" something { my_dict[\"key\"] } something else "
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-giE7MU ()
  (general-close-test-with-python-buffer
      ;; "f\" something { my_dict[\"key\"] } something else \""
      "f\" something { my_dict[\"key\"]"
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))
    (should (looking-back " }" (line-beginning-position)))
    ))

(ert-deftest general-close-python-f-string-test-QHPoRn ()
  (general-close-test-with-python-buffer
      "f\"{source.removesuffix(\".py\")}.c: $(srcdir)/{source"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-test-PqfjRK ()
  (general-close-test-with-python-buffer
      "f\"{source.removesuffix(\".py\")}.c: $(srcdir"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-python-f-string-test-SBZwoX ()
  (general-close-test-with-python-buffer
      ;; f"{f"{f"infinite"}"}" + " " + f"{f"nesting!!!"}"
      "f\"{f\"{f\"infinite\"}\"}\" + \" "
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-H8FZks ()
  (general-close-test-with-python-buffer
      ;; f"{f"{f"infinite"}"}" + " " + f"{f"nesting!!!"}"
      "f\"{f\"{f\"infinite\"}\"}\" + \" \" + f\"{f\"nesting!!!"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-JNY67j ()
  (general-close-test-with-python-buffer
      ;; f"{f"{f"infinite"}"}" + " " + f"{f"nesting!!!"}"
      "f\"{f\"{f\"infinite\"}\"}\" + \" \" + f\"{f\"nesting!!!\""
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-f-string-test-EwR1ZJ ()
  (general-close-test-with-python-buffer
      ;; a = ["hello", "world"]
      "a = [\"hello"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-9JDsO7 ()
  (general-close-test-with-python-buffer
      ;; a = ["hello", "world"]
      "a = [\"hello\", \"world"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-f-string-test-4YTcMN ()
  (general-close-test-with-python-buffer
      ;; a = ["hello", "world"]
      "a = [\"hello\", \"world\""
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close-python-f-string-test-r87iWJ ()
  (general-close-test-with-python-buffer
      ;; f"{'\n'.join(a)}"
      "f\"{'\n"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?'))))

(ert-deftest general-close-python-f-string-test-ipr5cl ()
  (general-close-test-with-python-buffer
      ;; f"{'\n'.join(a)}"
      "f\"{'\\n'.join(a"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\)))))


;; f" something { my_dict["key"] } something else "

;; The expression component can include any string literal that a normal Python expression can include. This opens up the possibility of nesting string literals (formatted or not) inside the expression component of an f-string with the same quote type (and length):

;; >>> f"These are the things: {", ".join(things)}"

;; >>> f"{source.removesuffix(".py")}.c: $(srcdir)/{source}"

;; >>> f"{f"{f"infinite"}"}" + " " + f"{f"nesting!!!"}"

;; >>> a = ["hello", "world"]
;; >>> f"{'\n'.join(a)}"
;; 'hello\nworld'

;; As this PEP allows placing any valid Python expression inside the expression component of the f-strings, it is now possible to reuse quotes and therefore is possible to nest f-strings arbitrarily:

;; >>> f"{f"{f"{f"{f"{f"{1+1}"}"}"}"}"}"
;; '2'

(ert-deftest general-close-python-f-string-test-g4ijGQ ()
  (general-close-test-with-python-buffer
      ;; f"{'\n'.join(a)}"
      "f\"{'\\n'.join(a)"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-python-test-OUdEGA ()
  (general-close-test-with-python-buffer
      "    if n < 1"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?:))))

(ert-deftest general-close-python-test-ItdHM2 ()
  (general-close-test-with-python-buffer
      "    else"
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?:))))


(provide 'general-close-python-tests)

;;; general-close-python-tests.el ends here
