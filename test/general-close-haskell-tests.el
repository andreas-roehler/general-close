
;; zipWith (\x ->y(\y -> (x, y) [1, 2, 3] [1, 2, 3]

(ert-deftest general-close-haskell-string-test-gJVmTt ()
  (general-close-test
      "indent s = \"asdf"
    'haskell-mode
    'general-close-debug-p
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?\"))))

(ert-deftest general-close-haskell-test-T1mOKj ()
  (general-close-test
      "wertweise n x =
  [ k | k<-[0..n-1], k == x "
    'haskell-mode
    'general-close-debug-p
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) 93))))

(ert-deftest general-close-haskell-test-YUumkX ()
  (general-close-test
      "{-# LANGUAGE OverloadedStrings"
    'haskell-mode
    'general-close-debug-p
    (skip-chars-backward " \t\r\n\f")
    (general-close)
    (should (eq (char-before) ?}))
    (should (eq (char-before (1- (point))) ?-))
    (should (eq (char-before (- (point) 2)) ?#))
    (should (eq (char-before (- (point) 3)) 32))
    )
  )



(provide 'general-close-haskell-tests)
;;; general-close-haskell-tests.el ends here
