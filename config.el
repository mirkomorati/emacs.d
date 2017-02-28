
;; Maybe it will improve startup time
(setq gc-cons-threshold 100000000)

;; Sets up the load path
(package-initialize)

;; Turn off mouse interface
(when window-system
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; Turn off splash screen
(setq inhibit-splash-screen t)

;; Set the right option-key to not work as meta-key
(setq mac-right-option-modifier nil)

(setq user-full-name "Mirko Morati")

;; Sets the melpa archive
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;  (package-refresh-contents)
  )

;; Using use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(use-package dash)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(fset 'yes-or-no-p 'y-or-n-p)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))

(use-package guide-key
  :defer t
  :diminish guide-key-mode
  :config
  (progn
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c"))
  (guide-key-mode 1)))

(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(blink-cursor-mode -1)

(setq-default indicate-empty-lines t)

(setq sentence-end-double-space nil)

(use-package windmove
  :bind
  (("<s-right>" . windmove-right)
   ("<s-left>" . windmove-left)
   ("<s-up>" . windmove-up)
   ("<s-down>" . windmove-down)
   ))

(defvar my/refile-map (make-sparse-keymap))

(defmacro my/defshortcut (key file)
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let ((org-refile-targets '(((,file) :maxlevel . 6)))
               (current-prefix-arg (or current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))

(my/defshortcut ?c "~/.emacs.d/config.org")
(my/defshortcut ?u "~/Documents/Org-mode/university.org")

(setq org-src-window-setup 'current-window)

(use-package "eldoc"
  :diminish eldoc-mode
  :commands turn-on-eldoc-mode
  :defer t
  :init
  (progn
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))

(column-number-mode 1)

(use-package multiple-cursors
  :bind
   (("C-c m t" . mc/mark-all-like-this)
    ("C-c m m" . mc/mark-all-like-this-dwim)
    ("C-c m l" . mc/edit-lines)
    ("C-c m e" . mc/edit-ends-of-lines)
    ("C-c m a" . mc/edit-beginnings-of-lines)
    ("C-c m n" . mc/mark-next-like-this)
    ("C-c m p" . mc/mark-previous-like-this)
    ("C-c m s" . mc/mark-sgml-tag-pair)
    ("C-c m d" . mc/mark-all-like-this-in-defun)))
(use-package phi-search)
(use-package phi-search-mc :config (phi-search-mc/setup-keys))
(use-package mc-extras :config (define-key mc/keymap (kbd "C-. =") 'mc/compare-chars))

(use-package solarized-theme
  :defer 10
  :init
  ;:ensure t
  (setq solarized-use-variable-pitch nil)
)

(use-package monokai-theme
  :if window-system
  :ensure t
  :init
  ;(setq monokai-use-variable-pitch nil)
  (load-theme 'monokai t)
)

(use-package waher-theme
  :if window-system
  ;:ensure t
  :init
  (setq waher-use-variable-pitch nil)
  ;(load-theme 'waher t)
)

(defun switch-theme (theme)
  "Disables any currently active themes and loads THEME."
  ;; This interactive call is taken from `load-theme'
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapc 'symbol-name
                                   (custom-available-themes))))))
  (let ((enabled-themes custom-enabled-themes))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme t)))

(defun disable-active-themes ()
  "Disables any currently active themes listed in `custom-enabled-themes'."
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(bind-key "s-<f12>" 'switch-theme)
(bind-key "s-<f11>" 'disable-active-themes)

(let ((font (if (= emacs-major-version 25)
                "Symbola"
              (cond ((string-equal system-type "darwin")    "Apple Color Emoji")
                    ((string-equal system-type "gnu/linux") "Symbola")))))
  (set-fontset-font t 'unicode font nil 'prepend))

(defun my/describe-random-interactive-function ()
  (interactive)
  "Show the documentation for a random interactive function.
Consider only documented, non-obsolete functions."
  (let (result)
    (mapatoms
     (lambda (s)
       (when (and (commandp s) 
                  (documentation s t)
                  (null (get s 'byte-obsolete-info)))
         (setq result (cons s result)))))
    (describe-function (elt result (random (length result))))))

(setq mouse-wheel-scroll-amount (quote (0.01)))
