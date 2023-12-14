;;; general-close-emacs-lisp-tests.el ---  Tests -*- lexical-binding: t; -*-

;; Authored and maintained by
;; Andreas Röhler, <andreas.roehler@online.de>
;; Emacs User Group Berlin <emacs-berlin@emacs-berlin.org>

;; Keywords: languages, lisp

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

;;; Commentary: A still naive implementation of a general-close command

;;

;;; Code:

(ert-deftest general-close--elisp-nested-bracket-paren-test-rNRF1C ()
  (general-close-test-with-elisp-buffer
    "(list ([\n;;{123\n;;{123\n"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close--elisp-nested-bracket-paren-test-cNi9NK ()
  (general-close-test-with-elisp-buffer
    "(list ([\n;;{123\n;;{123\n]"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close--elisp-nested-bracket-paren-test-O2UNEs ()
  (general-close-test-with-elisp-buffer
    "(list ([\n;;{123\n;;{123\n])"
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close--elisp-list-4ETJll ()
  (general-close-test-with-elisp-buffer
    "(member (list 'asdf"
    (general-close)
    (should (eq (char-before) ?\)))
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close--elisp-interactive-spec-aBfETo ()
  (general-close-test-with-elisp-buffer
    "(defun foo ()
  (interactive "
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close--elisp-char-class-test-qMPgJc ()
  (general-close-test-with-elisp-buffer
    "(string-match \"[[:alpha:]]"
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close--elisp-char-class-test-RTbDdh ()
  (general-close-test-with-elisp-buffer
    "(string-match \"[[:alpha"
    (general-close)
    (should (eq (char-before) ?:))))

(ert-deftest general-close--elisp-char-class-test-ZKucTB ()
  (general-close-test-with-elisp-buffer
    "(string-match \"[[:alpha:"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close--elisp-char-class-test-QylOuh ()
  (general-close-test-with-elisp-buffer
    "(string-match \"[[:alpha:]"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close--elisp-arglist-l91fpm ()
  (general-close-test-with-elisp-buffer
      "(defun asdf ("
      (general-close)
    (should (looking-back "asdf ()" (line-beginning-position)))))

(ert-deftest general-close-electric-delete-whitespace-test-x7Ax7w ()
  (general-close-test-with-elisp-buffer
      "(defun asdf ( "
      (let ((general-close-electric-delete-whitespace-p t))
	(general-close)
	(should (looking-back "asdf ()")))))

(ert-deftest general-close-electric-delete-whitespace-test-p0vsKD ()
  (general-close-test-with-elisp-buffer
      "(defun asdf ( "
      (let ((general-close-electric-delete-whitespace-p nil))
	(general-close)
	(should (looking-back "asdf (  )")))))

(ert-deftest general-close--elisp-padding-4SCxQH ()
  (general-close-test-with-elisp-buffer
      "(defun foo ( arg"
      (general-close)
    (should (eq (char-before) ?\)))
    (should (eq (char-before (1- (point))) ?\ ))
    ))

;; +BEGIN_QUOTE", "+BEGIN_VERSE", "+BEGIN_EXAMPLE" and "+BEGIN_SRC" to syntactic close? (Akin to C-] in latex-mode, when closing environments) So that would add a corresponding "+END_SRC", "+END_QUOT


(ert-deftest general-close--ogham-feather-mark-close-lVxPDf ()
  (general-close-test-with-elisp-buffer
      "?\᚛"
      (should (char-equal ?\᚜ (general-close--return-complement-char-maybe (char-before))))))

(ert-deftest general-close--multidelim-test-tIMXsr ()
  (general-close-test-with-elisp-buffer
      "{{{{asdf"
      (general-close)
    (should (looking-back "}" (line-beginning-position)))))

(ert-deftest general-close--multidelim-test-lvyjjU ()
  (general-close-test-with-elisp-buffer
      "{{{{asdf}"
      (goto-char (point-max))
      (general-close)
    (should (looking-back "}}" (line-beginning-position)))))

(ert-deftest general-close--escaped-test-nm0AqK ()
  ;; comint-password-prompt-regexp
  (general-close-test-with-elisp-buffer
      "\"\\(^ sadf"
      (let ((general-close-generic-p t))
        (goto-char (point-max))
        (skip-chars-backward " \t\r\n\f")
	(general-close)
	(should (looking-back "\\\\)" (line-beginning-position))))))

(ert-deftest general-close--escaped-test-32G2OA ()
  ;; comint-password-prompt-regexp
  (general-close-test-with-elisp-buffer
      "\"\\\\(^ *\\\\|^Passwort: *\\\\|\\\\( SMB\\\\|'s\\\\|Bad\\\\|CVS\\\\|Enter\\\\(?: \\\\(?:\\\\(?:sam\\\\|th"
      (let ((general-close-generic-p t))
	(general-close)
	(should (looking-back "\\\\)" (line-beginning-position))))))

(ert-deftest general-close--escaped-test-PbxFlK ()
  ;; comint-password-prompt-regexp
  (general-close-test-with-elisp-buffer
      "\"\\(^ *\\|^Passwort: *\\|\\( SMB\\|'s\\|Bad\\|CVS\\|Enter\\(?: \\(?:\\(?:sam\\|th"
      (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
      (let ((general-close-unary-delimiter-chars (list ?` ?\" ?+)))
	(general-close '(4))
	(should (eq (char-before) ?\")))))


(ert-deftest general-close--tqs-test-pBcUxG ()
  ;; comint-password-prompt-regexp
  (general-close-test-with-elisp-buffer
      "(search-forward \"'''"
      (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f") 
      (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-close-elisp-nested-bracket-paren-2e8EOm ()
  (general-close-test
    "(list ([\n;;{123\n;;{123\n"
    'emacs-lisp-mode
    general-close-debug-p
    (general-close)
    (should (eq (char-before) ?\]))
    (general-close)
    (should (eq (char-before) ?\)))
    (general-close)
    (should (eq (char-before) ?\)))))

(ert-deftest general-close--elisp-char-class-test-QylOuh ()
  (general-close-test-with-elisp-buffer
    "(string-match \"[[:alpha:]"
    (general-close)
    (should (eq (char-before) ?\]))))

(ert-deftest general-close--elisp-char-class-test-Ru2ZUr ()
  (general-close-test-with-elisp-buffer
      "(string-match \"[[:alpha:]]\""
    (general-close)
    (should (eq (char-before) ?\)))))


(provide 'general-close-emacs-lisp-tests)
;;; general-close-emacs-lisp-tests.el ends here
