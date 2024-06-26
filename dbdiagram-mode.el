;;; dbdiagram-mode.el --- dbdiagram.io erd definition mode -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Jian Wang

;; Author: Jian Wang <jian.wang@cpnet.io>
;; URL: https://github.com/jw-cpnet/dbd-mode
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.3"))
;; Keywords: languages

;;; Commentary:

;; This package provides a major mode for dbdiagram.io erd definition.

;;; Code:

(defconst dbdiagram-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; / is punctuation, but // is a comment starter
    (modify-syntax-entry ?/ ". 12" table)
    ;; \n is a comment ender
    (modify-syntax-entry ?\n ">" table)
    table))

(setq dbdiagram-font-lock-keywords
      (let* ((x-types '("int" "integer" "char" "varchar" "bool" "boolean"
                        "string" "text" "timestamp" "date"))
             (x-fn-names  '("Table" "Ref" "ref" "Enum" "note"))
             (x-keywords '("not" "null" "pk" "primary key" "unique"))

             (x-types-regexp (regexp-opt x-types 'words))
             (x-keywords-regexp (regexp-opt x-keywords 'words))
             (x-fn-regexp (regexp-opt x-fn-names 'words)))

        `((,x-types-regexp . font-lock-type-face)
          (,x-keywords-regexp . font-lock-keyword-face)
          (,x-fn-regexp . font-lock-function-name-face)
          (">" . font-lock-function-name-face))))

;;;###autoload
(define-derived-mode dbdiagram-mode python-mode
  "dbdiagram.io erd definition mode"
  :syntax-table dbdiagram-mode-syntax-table
  (setq font-lock-defaults '((dbdiagram-font-lock-keywords)))
  (setq-local python-indent 2)
  (font-lock-fontify-buffer))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.dbd\\'" . dbdiagram-mode))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.dbml\\'" . dbdiagram-mode))

(provide 'dbdiagram-mode)

;;; dbdiagram-mode.el ends here
