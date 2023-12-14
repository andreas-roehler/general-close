;;; general-close-java-tests.el --- Ruby tests -*- lexical-binding: t; -*-

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
(ert-deftest general-close-java-string-test-8fM8uW ()
  (general-close-test
      "public class Foo {
    public static void main(String\[] args)
    {
        System\.out\.println(\"Foo Bar: \" + foo)
    }
} "
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (search-backward ")")
    (forward-char 1)
    (general-close)
    (should (eq (char-before) ?\;))))

(ert-deftest general-close-java-import-test-wo4a9t ()
  (general-close-test
      "import java.util.Random"
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\;))))

(ert-deftest general-close-java-test-oc9rmB ()
  (general-close-test
      "System.out.println(\"x\")"
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\;))))

(ert-deftest general-close-java-test-ikuEEF ()
  (general-close-test
      "public class Foo1 {
    public static void foo1() {
        int x = 1;
        double y = 2.0;
        foo2(x, y);
        System.out.println(y + \" \" + x"
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) 41))))

(ert-deftest general-close-java-test-UApYpP ()
  (general-close-test
"public class FooBau {

  public static void main(String[] args) {
    var sb = new Foo();
    for(int i = 0; i < 100; i++) {
        sb.append(\"bla\" + i + \" \");
    }
    String s = sb.toString();
    System.out.println(s);
    }
"
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest general-close-java-test-rP3vyd ()
  (general-close-test
"public static boolean main(int[] data) {
    if(data == null || data.length < 2)
        return false;

    for(i = 0
    "
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?\;))
    ))

(ert-deftest general-close-java-test-smbeId ()
  (general-close-test
"public static boolean main(int[] data) {
    if(data == null || data.length < 2)
        return false;

    for(i = 0; i < x; i++
    "
    'java-mode
    general-close-debug-p
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) 41))))

(provide 'general-close-java-tests)
;;; general-close-java-tests.el ends here
