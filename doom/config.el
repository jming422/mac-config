;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jonathan Ming"
      user-mail-address "jming422@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 12))
(setq doom-theme (if (let ((hour (decoded-time-hour (decode-time))))
                       (> 18 hour 7))
                     'doom-one-light
                   'doom-one))

;; macOS customizations
(when (eq system-type 'darwin)
  ;; Mac modifier key rebindings
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (setq mac-right-control-modifier 'hyper)
  (add-hook 'ns-system-appearance-change-functions
            (lambda (appearance)
              (pcase appearance
                ('light (load-theme 'doom-one-light t))
                ('dark (load-theme 'doom-one t))))))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Misc. config & variables
(unless (eq system-type 'darwin)
  (setq auth-sources '("~/.authinfo.gpg")))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Package configuration
(after! lsp-mode
  (setq +format-with-lsp nil))

(after! dap-mode
  (dap-register-debug-template "Node::Attach" '(:type "node" :request "attach" :name "Node::Attach")))

(after! projectile
  (setq projectile-files-cache-expire 10))

(after! forge
  (transient-append-suffix 'forge-dispatch '(0 2 -1)
    '("c x" "pull review request" forge-edit-topic-review-requests)))

(after! emacs-everywhere
  (setq emacs-everywhere-markdown-apps '("Discord" "Slack"))
  (setq emacs-everywhere-frame-name-format "Emacs Everywhere")

  ;; This is the same as the default, except it does not force org mode when pandoc is available; it uses markdown mode
  ;; for markdown flavored windows and org mode for everything else. This is because pandoc doesn't do a 1:1 conversion
  ;; from org to markdown and the output doesn't get formatted with Prettier like it would if I was just writing in
  ;; markdown-mode.
  (setq emacs-everywhere-init-hooks
	`(emacs-everywhere-set-frame-name
	  emacs-everywhere-set-frame-position
	  ,(if (fboundp 'markdown-mode)
	       #'emacs-everywhere-major-mode-org-or-markdown
	     #'text-mode)
	  emacs-everywhere-insert-selection
	  emacs-everywhere-remove-trailing-whitespace
	  emacs-everywhere-init-spell-check)))

(add-hook! (rjsx-mode yaml-mode css-mode json-mode typescript-mode)
  (prettier-js-mode))

(add-hook! markdown-mode
  (prettier-js-mode)
  (setq-local prettier-js-args '("--parser" "markdown")))

(add-hook! clojure-mode
  (add-hook 'before-save-hook #'cider-format-buffer t t))

(add-hook! (clojure-mode emacs-lisp-mode cider-repl-mode)
  (evil-cleverparens-mode))

(after! vterm
  (add-to-list 'vterm-eval-cmds '("update-pwd" (lambda (path) (setq default-directory path)))))

;; Custom functions & bindings
(global-set-key (kbd "M-/") #'hippie-expand)
(global-set-key (kbd "H-SPC") #'just-one-space) ;; because on macOS I use M-SPC for Spotlight
(global-set-key (kbd "C-§") #'ignore)
(global-set-key (kbd "<XF86AudioRaiseVolume>") #'ignore)
(global-set-key (kbd "<XF86AudioLowerVolume>") #'ignore)
(global-set-key (kbd "<XF86AudioMute>") #'ignore)
(global-set-key (kbd "<XF86AudioPlay>") #'ignore)


(defun js-refactor-const-to-function ()
  "Refactor all `const myFunc = () => {}' forms in the current buffer to `function myFunc() {}' forms."
  (interactive)
  (let ((starting-point (point)))
    (goto-char (point-min))
    (while (re-search-forward "^\\(export \\)?const \\([a-zA-Z][^ ]*\\) = \\(async \\)?\\(([^)]*)\\) => {" nil t)
      (replace-match "\\1\\3function \\2\\4 {"))
    (goto-char starting-point)))

(defun js-refactor-to-individual-export ()
  "Refactor the declaration of sexp at point to have the `export' keyword at its beginning, then move point to the next sexp.  If you place your point on the first sexp in a grouped `export { x, y }' form, you can repeat this function to refactor all the exported vars in one fell swoop."
  (interactive)
  (let ((xref-results (xref-find-definitions (xref-backend-identifier-at-point (xref-find-backend)))))
    (when (eq 'buffer (type-of xref-results))
      (quit-window)
      (user-error "Multiple definitions available for identifier at point -- don't know which one to refactor")))
  (move-beginning-of-line nil)
  (insert "export ")
  (xref-pop-marker-stack)
  (sp-forward-sexp)
  (sp-next-sexp))

(defun custom-refactor-migration ()
  "Refactors current buffer from a fresh db-migrate migration to use the default Custom migration script instead."
  (interactive)
  (goto-char 462)
  (kill-sexp)
  (delete-region (buffer-end 0) (buffer-end 1))
  (insert-file-contents (locate-user-emacs-file "custom-migration-template.js"))
  (goto-char 226)
  (yank)
  (kill-sexp))
