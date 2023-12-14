;;; general-close-org-mode-tests.el --- org-mode tests  -*- lexical-binding: t -*-


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

(ert-deftest general-close--elisp-org-quote-OkuWXL ()
  (general-close-test-with-elisp-buffer
      "#+BEGIN_QUOTE
asdf"
      'org-mode
    general-close-verbose-p
      (general-close)
    (should (looking-back "#\\+END_QUOTE" (line-beginning-position)))))

(ert-deftest general-close--elisp-org-src-WseYLy ()
  (general-close-test
      "#+BEGIN_SRC
asdf"
    'org-mode
    general-close-verbose-p
    (general-close)
    (should (looking-back "#\\+END_SRC" (line-beginning-position)))))

(provide 'general-close-org-mode-tests)
;;; general-close-org-mode-tests.el ends here