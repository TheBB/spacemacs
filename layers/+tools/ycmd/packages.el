;;; packages.el --- Ycmd Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Brian Hicks <brian@brianthicks.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq ycmd-packages
  '(
    (company-ycmd :depends company)
    (flycheck-ycmd :depends flycheck)
    eldoc
    ycmd
    ))

(unless (boundp 'ycmd-server-command)
  (message (concat "YCMD won't work unless you set the ycmd-server-command "
                   "variable to the path to a ycmd install.")))

(defun ycmd/init-company-ycmd ()
  (use-package company-ycmd
    :defer t
    :commands company-ycmd))

(defun ycmd/init-flycheck-ycmd ()
  (use-package flycheck-ycmd
    :defer t
    :init (add-hook 'ycmd-mode-hook 'flycheck-ycmd-setup)))

(defun ycmd/post-init-eldoc ()
  (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup))

(defun ycmd/init-ycmd ()
  (use-package ycmd
    :defer t
    :init
    (progn
      (unless (boundp 'ycmd-global-config)
        (setq-default ycmd-global-config
                      (concat (configuration-layer/get-layer-path 'ycmd)
                              "global_conf.py")))
      (setq-default ycmd-parse-conditions '(save mode-enabled)))))
