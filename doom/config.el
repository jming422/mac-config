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
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function.
(setq doom-theme 'doom-tomorrow-day)

;; This fixes some issues with Emacs trying to connect to HTTPS endpoints
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; macOS customizations
(when (eq system-type 'darwin)
  ;; Mac modifier key rebindings
  ;; (setq mac-command-modifier 'meta)
  ;; (setq mac-option-modifier 'super)
  ;; (setq mac-right-control-modifier 'hyper)
  (add-hook 'ns-system-appearance-change-functions
            (lambda (appearance)
              (pcase appearance
                ('light (load-theme 'doom-tomorrow-day t))
                ('dark (load-theme 'doom-tomorrow-night t))))))

(custom-set-faces!
  `(vterm-color-black :foreground ,(doom-color 'fg) :background ,(doom-darken 'fg 0.2))
  `(vterm-color-white :foreground ,(doom-color 'bg-alt) :background ,(doom-color 'bg)))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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
  (setq lsp-ui-doc-enable nil)
  (setq lsp-rust-analyzer-proc-macro-enable t)
  (add-to-list 'lsp-language-id-configuration '(crystal-mode . "crystal"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("crystalline"))
                    :activation-fn (lsp-activate-on "crystal")
                    :priority '1
                    :server-id 'crystalline)))

(add-hook! crystal-mode
  (lsp))

(after! dap-mode
  (dap-register-debug-template
   "Node::Attach"
   '(:type "node" :request "attach" :name "Node::Attach")))

(after! projectile
  (setq projectile-files-cache-expire 10))

(after! forge
  (transient-append-suffix 'forge-dispatch '(0 0 7)
    '("c x" "pull-request review request" forge-edit-topic-review-requests)))

(after! emacs-everywhere
  (setq emacs-everywhere-markdown-apps '("Discord" "Slack"))
  (setq emacs-everywhere-frame-name-format "Emacs Everywhere")

  ;; This is the same as the default, except it does not force org mode when
  ;; pandoc is available; it uses markdown mode for markdown flavored windows
  ;; and org mode for everything else. This is because pandoc doesn't do a 1:1
  ;; conversion from org to markdown and the output doesn't get formatted with
  ;; Prettier like it would if I was just writing in markdown-mode.
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

(add-hook! prettier-js-mode
  (setq-local +format-with-lsp nil))

(add-hook! clojure-mode
  (add-hook 'before-save-hook #'cider-format-buffer t t))

(after! clojure-mode
  (define-clojure-indent
    (when-let* 1)))

(after! cider
  (setq cider-format-code-options
        '(("indents" (("when-let*" (("block" 1)))
                      ("backoff-and-retry" (("block" 1)))
                      ("with-temp-file" (("block" 1)))
                      ("com.climate.claypoole/with-shutdown!" (("block" 1))))))))

(add-hook! (clojure-mode emacs-lisp-mode cider-repl-mode)
  (evil-cleverparens-mode))

(after! vterm
  (add-to-list 'vterm-eval-cmds '("update-pwd" (lambda (path) (setq default-directory path)))))

(add-hook! vterm-mode
  ;; So by default #xe256 gets rendered using all-the-icons' Material Icons as a
  ;; spacebar icon. But since I've never seen the spacebar icon used
  ;; (intentionally) and since my starship prompt tries to use that codepoint to
  ;; hit the Java icon in the Nerd Font, I want to lock that codepoint to the Nerd
  ;; Font instead of Material Icons.
  (set-fontset-font t #Xe256 (font-spec :family "JetBrainsMono Nerd Font")))

(add-hook! rainbow-mode
  (hl-line-mode (if rainbow-mode -1 +1)))

(use-package! ron-mode
  :mode "\\.ron\\'")

(after! (pipenv lsp-mode)
  (define-advice pipenv-activate (:after ())
    (when lsp-mode (call-interactively #'lsp-workspace-restart)))
  (define-advice pipenv-deactivate (:after ())
    (when lsp-mode (call-interactively #'lsp-workspace-restart))))

(add-to-list 'auto-mode-alist '("\\.env\\'" . fundamental-mode))

;; Custom functions & bindings
(global-set-key (kbd "M-/") #'hippie-expand)
 ;; because with my current keyboard it is uncomfortable to push M-SPC, I want
 ;; H-SPC as an additional option
(global-set-key (kbd "H-SPC") #'just-one-space)
(global-set-key (kbd "C-§") #'ignore)
(global-set-key (kbd "<f15>") #'ignore)
(global-set-key (kbd "<f16>") #'ignore)
(global-set-key (kbd "<XF86AudioRaiseVolume>") #'ignore)
(global-set-key (kbd "<XF86AudioLowerVolume>") #'ignore)
(global-set-key (kbd "<XF86AudioMute>") #'ignore)
(global-set-key (kbd "<XF86AudioPlay>") #'ignore)
(after! evil
  (map! :map evil-normal-state-map
        :prefix "["
        "I" #'+vertico/search-symbol-at-point))

(defun js-refactor-const-to-function ()
  "Refactor all `const myFunc = () => {}' forms in the current buffer to
`function myFunc() {}' forms."
  (interactive)
  (let ((starting-point (point)))
    (goto-char (point-min))
    (while (re-search-forward "^\\(export \\)?const \\([a-zA-Z][^ ]*\\) = \\(async \\)?\\(([^)]*)\\) => {" nil t)
      (replace-match "\\1\\3function \\2\\4 {"))
    (goto-char starting-point)))

(defun js-refactor-to-individual-export ()
  "Refactor the declaration of sexp at point to have the `export' keyword at its
beginning, then move point to the next sexp.  If you place your point on the
first sexp in a grouped `export { x, y }' form, you can repeat this function to
refactor all the exported vars in one fell swoop."
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
  "Refactors current buffer from a fresh db-migrate migration to use my custom
migration script instead."
  (interactive)
  (goto-char 462)
  (kill-sexp)
  (delete-region (buffer-end 0) (buffer-end 1))
  (insert-file-contents (concat doom-private-dir "custom-migration-template.js"))
  (goto-char 226)
  (yank)
  (kill-sexp))

;; Hacks
;; Stuff to modify Doom's behavior in weird or custom ways. These are the most
;; likely things in this file to break.

;; https://github.com/hlissner/doom-emacs/issues/3038#issuecomment-624165004
(after! counsel
  (setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s || true"))
