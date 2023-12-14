;;; general-close-interactive-tests.el --- Tests known to work when called interactively only -*- lexical-binding: t; -*-

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

;; Some tests fail in batch mode for unknown reasons. Comments welcome

;;; Code:

(ert-deftest general-close-close-ruby-block-test ()
  (general-close-test-with-ruby-buffer "$DBH.SELECT_ALL(\"SELECT \* FROM FOO\") DO |ROW|"
    (general-close)
    (should (eq (char-before) ?d))))

(ert-deftest general-close-c-comment-test ()
  (general-close-test "/* The open system call "
    'c-mode
    (general-close)
    (should (eq (char-before) ?/))))

(ert-deftest general-close-c++-star-comment-test ()
  (general-close-test "/* The open system call "
    'c++-mode
    (general-close)
    (should (eq (char-before) ?/))))

(ert-deftest general-close-haskell-comment-test-1 ()
  (general-close-test-with-haskell-buffer
      "{- To explore this file: "
    (general-close)
    (should (looking-back "-}"))))

;; (ert-deftest general-close-haskell-comment-test-2 ()
;;   (general-close-test-with-haskell-buffer
;;       "{- To explore this file: -}"
;;     (general-close)
;;     (sit-for 0.1)
;;     (should (ar-empty-line-p))))

(ert-deftest general-close-haskell-close-paren-test-1 ()
  (general-close-test-with-haskell-buffer
      "add :: (Int,Int"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-python-colon-test-2 ()
  (general-close-test-with-python-buffer
      "class TutorialApp(App):
    def build(self):
        return Button(text=\"Hello!\",
                      background_color=(0, 0, 1, 1)
                      font_size=150)
if __name__ == \"__main__\""
    (general-close)
    (should (eq (char-before) ?:))))

(ert-deftest general-close-list-single-var-test-1 ()
  (general-close-test-with-haskell-buffer "potenz(x,y"
    (general-close '(4))
    (skip-chars-backward " \t\r\n\f")
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-sml-comment-test ()
  (general-close-test "(* definition of nat"
    'sml-mode
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-sml-assignment-test-1 ()
  (general-close-test "val z"
    'sml-mode
    (general-close)
    (skip-chars-backward " \t\r\n\f")
    (should (eq (char-before) ?=))))

(ert-deftest general-close-sml-no-pad-after-test ()
  (general-close-test "val z = (x + y) (a +)"
    'sml-mode
    (forward-char -1)
    (general-close)
    (should (eq (char-before) ?b))
    (should (eq (char-after) ?\)))))

(ert-deftest general-close-sml-assignment-1 ()
  (general-close-test "val z = (x + y) (a + b)"
    'sml-mode
    (general-close)
    (should (eq (char-before) ?\;))))

(ert-deftest general-close-sml-assignment-2 ()
  (general-close-test "val z"
    'sml-mode
    (general-close)
    (skip-chars-backward " \t\r\n\f")
    (should (eq (char-before) ?=))))

(ert-deftest general-close-sml-assignment-3 ()
  (general-close-test "fun foo (z : int)"
    'sml-mode
    (general-close)
    (skip-chars-backward " \t\r\n\f")
    (should (eq (char-before) ?=))))

(ert-deftest general-close-sml-tuple-separator-1 ()
  (general-close-test "val x = (3"
    'sml-mode
    (general-close)
    (should (eq (char-before) ?,))))

(ert-deftest general-close-sml-function-1 ()
  (general-close-test "fun foo (x : int)"
    'sml-mode
    (general-close)
    (skip-chars-backward " \t\r\n\f")
    (should (eq (char-before) ?=))))

;; (ert-deftest general-close-sml-function-2 ()
;;   (general-close-test "fun foo"
;;     'sml-mode
;; ;;       (general-close)
;;       (skip-chars-backward " \t\r\n\f")
;;       (should (eq (char-before) ?\())))

(ert-deftest general-close-sml-backward-block-1 ()
  (general-close-test "fun silly1 (z : int) =
  let
      val"
    'sml-mode
    (ar-smart-indentation t))
  (sml-backward-top-level)
  (should (eq (char-after) ?f)))

(ert-deftest syntactic-python-space-separator-test-1 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest syntactic-python-space-separator-test-2 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c)"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest syntactic-python-space-separator-test-3 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c)]"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest syntactic-python-space-separator-test-4 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c)])"
    (general-close)
    (should (looking-back " }"))))

(ert-deftest general-close-python-brace-paren-bracket-test-1 ()
  (general-close-test-with-python-buffer
      "{[(123"
    (general-close)
    (sit-for 0.1)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-python-brace-paren-bracket-test-2 ()
  (general-close-test-with-python-buffer
      "{[(123)"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close-python-brace-paren-bracket-test-3 ()
  (general-close-test-with-python-buffer
      "{[(123)]"
    (general-close)
    (should (eq (char-before) ?}))))

(ert-deftest syntactic-python-space-separator-test-1 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest syntactic-python-space-separator-test-2 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c)"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest syntactic-python-space-separator-test-3 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c)]"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest syntactic-python-space-separator-test-4 ()
  (general-close-test-with-python-buffer
      "{ (a * [(b) - (c)])"
    (general-close)
    (should (looking-back " }"))))

(ert-deftest general-close-python-singlequoted-tqs-test ()
  (general-close-test-with-python-buffer
      "'''Some Doku"
    (font-lock-fontify-buffer)
    (general-close)
    (should (eq (char-before) ?'))
    (should (eq -3 (skip-chars-backward "'")))))

(ert-deftest general-close-python-singlequoted-test ()
  (general-close-test-with-python-buffer
      "'Some Doku"
    (message "%s" "general-close-python-singlequoted-test")
    (general-close)
    (should (eq (char-before) ?'))))

(ert-deftest general-close-python-doublequoted-tqs-test ()
  (general-close-test-with-python-buffer
      "\"\"\"Some Doku"
    (font-lock-fontify-buffer)
    ;; (message "%s" "Starte general-close-python-doublequoted-tqs-test")
    (general-close)
    (should (eq (char-before) ?\"))
    (should (eq -3 (skip-chars-backward "\"")))))

(ert-deftest general-close-python-electric-test-1 ()
  (general-close-test-with-python-buffer
      "['a"
    (let ((general-close-electric-listify-p t))
      (general-close)
      (should (eq (char-before) ?')))))

(ert-deftest general-close-python-electric-test-2 ()
  (general-close-test-with-python-buffer
      "['a','b'"
    (let ((general-close-electric-listify-p t))
      ;; force final closing
      (general-close '(4))
      (should (eq (char-before) ?\])))))

(ert-deftest general-close-python-electric-test-3 ()
  (general-close-test-with-python-buffer
      "[\"a\""
    (let ((general-close-electric-listify-p t))
      (general-close '(4))
      (should (eq (char-before) ?\])))))

(ert-deftest general-close-python-electric-test-4 ()
  (general-close-test-with-python-buffer
      "def potenz(x"
    (let ((general-close-electric-listify-p t))
      (general-close)
      (should (eq (char-before) ?\))))))

(ert-deftest general-close-python-electric-test-5 ()
  (general-close-test-with-python-buffer
      "def potenz(x,y"
    (let ((general-close-electric-listify-p t))
      (general-close '(4))
      (should (eq (char-before) ?\))))))

(ert-deftest general-close-python-doublequoted-test ()
  (general-close-test-with-python-buffer
      "\"Some Doku"
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-python-nested-paren-test-1 ()
  (general-close-test-with-python-buffer
      "(list ([\n# {123\n# {123\n"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close-python-nested-paren-test-2 ()
  (general-close-test-with-python-buffer
      "(list ([\n# {123\n# {123\n]"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-python-nested-paren-test-3 ()
  (general-close-test-with-python-buffer
      "(list ([\n# {123\n# {123\n])"
    (general-close)
    (should (eq (char-before) ?\)))))


(ert-deftest general-close-python-tqs-test-1 ()
  (general-close-test-with-python-buffer
      "\"\"\"asdf"
    (let ((orig (point)))
      (general-close)
      (should (looking-back "\"\"\"" (line-beginning-position))))))

(ert-deftest general-close-python-tqs-test-2 ()
  (general-close-test-with-python-buffer
      "'''asdf"
    (let ((orig (point)))
      (general-close)
      (should (looking-back "'''" (line-beginning-position))))))  

(provide 'general-close-interactive-tests)
;;; general-close-interactive-tests.el ends here
