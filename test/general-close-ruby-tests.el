;;; general-close-ruby-tests.el --- Ruby tests -*- lexical-binding: t; -*-

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
(ert-deftest general-close-close-ruby-string-test ()
  (general-close-test
      "def deliver(from: \"A\", to: nil, via: \"mail"
    'ruby-mode
    general-close-debug-p
    (goto-char (point-max)) 
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-close-ruby-paren-test ()
  (general-close-test
      "def deliver(from: \"A\", to: nil, via: \"mail\""
    'ruby-mode
    general-close-debug-p
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close-close-ruby-string-interpolation-test-2 ()
  (general-close-test
      "def deliver(from: \"A\", to: nil, via: \"mail\")
  \"Sending from #{from} to #{to} via #{via}"
    'ruby-mode
    general-close-debug-p
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-ruby-block-close-GZBbFA ()
  (general-close-test
      "values.each do |value|
  break if value.even?"
    'ruby-mode
    general-close-debug-p
    (general-close)
    (should (looking-back "end" (line-beginning-position)))))

(ert-deftest general-close-ruby-block-close-oP7aaw ()
  (general-close-test
      "more_nested_array.each do |element|
  element.each do |inner_element|
    inner_element << \"test\"
"
    'ruby-mode
    general-close-debug-p
    (goto-char (point-max)) 
    (general-close)
    (should (looking-back "end" (line-beginning-position)))
    (should (eq (current-indentation) 2))))

(ert-deftest general-close-ruby-block-close-XhSYAJ ()
  (general-close-test
      "more_nested_array.each do |element|
  element.each do |inner_element|
    inner_element << \"test\"
  end"
    'ruby-mode
    general-close-debug-p
    (goto-char (point-max)) 
    (general-close)
    (should (looking-back "end" (line-beginning-position)))
    (should (eq (current-indentation) 0))))

(ert-deftest general-close-ruby-test-gszMLh ()
  (general-close-test
      ;; "puts \"Hello #{name}!\""
      "puts \"Hello #{name"
    'ruby-mode
    general-close-debug-p
    (general-close)
    (should (char-equal (char-before) ?}))))

(ert-deftest general-close-ruby-test-yKdmju ()
  (general-close-test
      ;; "puts \"Hello #{name}!\""
      "puts \"Hello #{name}!"
    'ruby-mode
    general-close-debug-p
    (general-close)
    (should (char-equal (char-before) ?\"))))

(ert-deftest general-close-mode-ruby-test-VvXkWj ()
  (general-close-test
      ;; "hi(\"Matz\")"
      "hi(\"Matz"
    'ruby-mode
    general-close-debug-p
    (general-close)
    (should (char-equal (char-before) ?\"))))

(ert-deftest general-close-mode-ruby-mode-test-3Sumx6 ()
  (general-close-test
      ;; "hi(\"Matz\")"
      "hi(\"Matz\""
    'ruby-mode
    general-close-debug-p
    (goto-char (point-max))
    (general-close)
    (should (char-equal (char-before) ?\)))))

(provide 'general-close-ruby-tests)
;;; general-close-ruby-tests.el ends here
