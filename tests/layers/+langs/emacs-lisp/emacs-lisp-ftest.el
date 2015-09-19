(defmacro with-mode-buffer (mode &rest body)
  (declare (indent 1))
  `(progn
     (get-buffer-create "test")
     (switch-to-buffer "test")
     (,mode)
     ,@body))

(ert-deftest major-mode-leader ()
  (with-mode-buffer emacs-lisp-mode
    (should (keymapp (key-binding ",")))))

(ert-deftest fundamental-mode ()
  (with-mode-buffer fundamental-mode
    (should (eq 'evil-repeat-find-char-reverse (key-binding ",")))))
;; blerfg
