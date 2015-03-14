
;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
:
;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))


;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/better-defaults.el line 47 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Make sure that .json files open with javascript highlighting
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;; activate js2 and its auto-complete
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; activate jedi for python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; set highlight level for js2-mode
(setq js2-highlight-level 3)

;; fill-column mode
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "cyan")
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; autocomplete mod
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; set the trigger key so that it can work with the yasnippet on tab key
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; load up neotree
(require 'neotree)
(global-set-key (kbd "M-p") 'neotree-toggle)


;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")

;; slack plugin
;; (load "slack.el")

;;(package-initialize)
;;(evil-mode 1)

(global-visual-line-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("f3f1a95f22ab424aceea588f432870bc6cc3ed837c6b9f707217b92a5e8b503e" "5664d2ccbb25a1e8546d07eab10bd39e01dc932238b1ccda01bd586611b9d403" "67f76a5edca595c9f340e5438b19b508f0509f437d849d231df4bc14acaf9ad6" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "e4bc8563d7651b2fed20402fe37b7ab7cb72869f92a3e705907aaecc706117b5" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "b0984818158ff2fa3ae511a2f3db7ea239a223d1dc09475c6c2ccdbc8ee03dd3" default)))
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1)))))
 '(send-mail-function nil))


;; add paredit support for braces/brackets
(defun paredit-nonlist ()
  "Turn on paredit mode for non-lisp languages"
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
    '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(add-hook 'js-mode-hook 'paredit-nonlisp)
(add-hook 'js-mode-hook 'esk-paredit-nonlisp)

(autoload 'zap-up-to-char "misc"
    "Kill up to, but not including ARGth occurrence of CHAR. (fn arg char)"
    'interactive)
(defun zap-up-to-char (arg char)
  "Kill up to, but not including ARGth occurrence of CHAR.
  Case is ignored if `case-fold-search' is non-nil in the current buffer.
  Goes backward if ARG is negative; error if CHAR not found.
  Ignores CHAR at point."
    (interactive "p\ncZap up to char: ")
    (let ((direction (if (>= arg 0) 1 -1)))
      (kill-region (point)
                   (progn
                     (forward-char direction)
                     (unwind-protect
                         (search-forward (char-to-string char) nil nil arg)
                       (backward-char direction))
                 (point)))))
 
;; custom key bindings
(global-set-key (kbd "C-M-i") 'ido-goto-symbol)
(global-set-key (kbd "C-c C-r") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key "\C-x=" '(set-frame-width (selected-frame) 82))
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "C-c C-k") 'zap-up-to-char)
;; searching
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
;; undo
(global-set-key (kbd "C-/") 'undo)

;; window-mode
(require 'window-number)
(window-number-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; update key-bindings to include hyper and super
(setq mac-command-modifier 'super) ; make cmd key do Super
(setq mac-option-modifier 'meta) ; make opt key do Meta
(setq mac-control-modifier 'control) ; make Control key do Control
(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper 


;; ensure slime is loaded
;; (add-to-list 'load-path "~/.emacs.d/slime")
;; (setq inferior-lisp-program "/usr/local/bin/sbcl")
;; (require 'slime)
;; (slime-setup)


;; swank-js settings
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (global-set-key (kbd "C-c C-c C-M-x") 'slime-js-reload)
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))
;; (load-flie "~/.emacs.d/setup-slime-js.el")
;; (setq-default indent-tabs-mode nil)
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)
