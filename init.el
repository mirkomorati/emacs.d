;; Load the config.org file

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)

(org-babel-load-file (concat user-emacs-directory "config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" "7b4d9b8a6ada8e24ac9eecd057093b0572d7008dbd912328231d0cada776065a" default)))
 '(doc-view-continuous t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (C . t) (awk . t) (ditaa . t))))
 '(package-selected-packages
   (quote
    (org-bullets smartparens waher-theme use-package undo-tree solarized-theme phi-search-mc monokai-theme mc-extras haskell-mode guide-key auto-compile))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
