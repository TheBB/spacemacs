;;; core-compile.el --- Spacemacs Core File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Eivind Fonn <evfonn@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar spacemacs--compile-ignore-core
  '("spacefmt" "aprilfool" "documentation")
  "Core files to ignore when compiling.")

(defvar spacemacs--layer-files-regexp
  (rx (or "layers.el"
          "config.el"
          "packages.el"
          "funcs.el"
          "keybindings.el")
      string-end)
  "Regexp for matching layer files.")

(defvar spacemacs--layer-compiled-files-regexp
  (rx (or "layers.elc"
          "config.elc"
          "packages.elc"
          "funcs.elc"
          "keybindings.elc")
      string-end)
  "Regexp for matching compiled layer files.")

(defun spacemacs//matches (test regexps)
  (let ((ret nil))
    (dolist (regexp regexps)
      (when (string-match-p regexp test)
        (setq ret t)))
    ret))

(defun spacemacs/compile ()
  (interactive)
  (catch 'error
    (dolist (file (directory-files-recursively spacemacs-core-directory "\\.el\\'"))
      (unless (spacemacs//matches file spacemacs--compile-ignore-core)))
    (dolist (path (configuration-layer//search-paths))
      (dolist (file (directory-files-recursively path spacemacs--layer-files-regexp))
        (unless (byte-compile-file file)
          (message "Error compiling: %s" file)
          (throw 'error nil))))
    t))

(defun spacemacs/clean ()
  (interactive)
  (dolist (file (directory-files-recursively spacemacs-core-directory "\\.elc\\'"))
    (delete-file file))
  (dolist (path (configuration-layer//search-paths))
    (dolist (file (directory-files-recursively path spacemacs--layer-compiled-files-regexp))
      (delete-file file))))
