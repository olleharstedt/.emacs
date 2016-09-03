;;; package --- summary
;;; Commentary:
;;; Code:
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;; list the packages you want
(setq package-list
      '(php-mode
	evil
	evil-surround
	evil-leader
	))

; list the repositories containing them
;(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ;("gnu" . "http://elpa.gnu.org/packages/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(global-evil-leader-mode)

(require 'evil)
(evil-mode 1)

;; Some vim-like bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd "C-s") 'evil-write)
(define-key evil-normal-state-map (kbd "C-q") 'kill-buffer-and-window)

;; Function to run <leader>-e
(defun evil-leader-e ()
  "Open tab with file browser."
  (interactive)
  (elscreen-create)
  (dired "~")
  )
(evil-leader/set-key "e" 'evil-leader-e)
; 'evil-leader-e

(require 'erc)

; (global-evil-tabs-mode t)

; Snippets
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

; PHP mode
(eval-after-load 'php-mode
  '(require 'php-ext))

(global-flycheck-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)

; Enable line numbers
(global-linum-mode 1)

; Space after line number
(setq linum-format "%d ")

; Evil surround
(require 'evil-surround)
(global-evil-surround-mode 1)

(ac-config-default)

; Ctags and autocomplete
;(custom-set-variables
; '(ac-etags-requires 1))
;(eval-after-load "etags"
;  '(progn
;     (ac-etags-setup)))
;(add-hook 'c-mode-common-hook 'ac-etags-ac-setup)
;(add-hook 'ruby-mode-common-hook 'ac-etags-ac-setup)

; PHP ac
(add-hook 'php-mode-hook
	  '(lambda ()
	     (auto-complete-mode t)
	     (require 'ac-php)
	     (setq ac-sources  '(ac-source-php ) )
	     (yas-global-mode 1)
	     (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
	     (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
	                    ))

;; Turn off menu
(menu-bar-mode -1)

;; Turn on Vim tabs
(global-evil-tabs-mode 1)

(provide 'emacs)
;;; .emacs ends here
