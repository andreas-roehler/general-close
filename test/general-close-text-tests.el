(ert-deftest general-close--multibrace-test ()
  (general-close-test
      "{{{{asdf"
    'text-mode
    general-close-debug-p 
    (general-close)
    (should (looking-back "asdf}" (line-beginning-position)))))  

