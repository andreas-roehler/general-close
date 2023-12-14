;;; general-close-fundamental-tests.el --- tests in fundamental   -*- lexical-binding: t; -*-

;; Authored and maintained by
;; Emacs User Group Berlin <emacs-berlin@emacs-berlin.org>

;; Keywords: languages, lisp

;; Copyright (C) 2018  Andreas Röhler

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(ert-deftest general-close--multibrace-fundamental-test-pgwBPJ ()
  (general-close-test
      "{{{{asdf"
    'fundamental-mode
    general-close-debug-p
    (general-close)
    (should (looking-back "asdf}}}}" (line-beginning-position)))))

(ert-deftest general-close--multibrace-unary-fundamental-test-JM8aED ()
  (general-close-test
      "{{{[[[[+asdf"
    'fundamental-mode
    general-close-debug-p
    (let ((general-close-unary-delimiter-chars (push 43 general-close-unary-delimiter-chars)))
      (general-close)
      (should (eq (char-before) ?\+)))))

(ert-deftest general-close--multibrace-unary-fundamental-test-WlZ71s ()
  (general-close-test
      "{{{[[[[+++asdf"
    'fundamental-mode
    general-close-debug-p
    (let ((general-close-unary-delimiter-chars (push 43 general-close-unary-delimiter-chars)))
      (general-close)
      (should (eq (char-before) ?+)))))

(ert-deftest general-close--triple-grave-accent-test-WlZ71s ()
  (general-close-test
      "```
foo
"   'fundamental-mode
    general-close-debug-p
    (general-close)
    (should (looking-back "```" (line-beginning-position)))))

(provide 'general-close-fundamental-tests)
;;; general-close-fundamental-tests.el ends here
