(require 'evil)
(evil-mode 1)
(global-linum-mode t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; ---------- golang -----------------
(setenv "GOPATH" "/Users/liyichao/code/gocode")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "PATH"))

(require-package 'go-mode)
(require 'go-mode)
(require-package 'go-autocomplete)
(require 'go-autocomplete)
(require 'auto-complete-config)


(require-package 'gotest)
(require 'gotest)

;; get -u github.com/jstemmer/gotags

(require-package 'popwin)
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)


(require-package 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(setq gofmt-command "goimports")

(add-hook 'before-save-hook 'gofmt-before-save)

(require-package 'golint)
(require 'golint)
(defun my-go-mode()
  (define-key go-mode-map (kbd "C-c i") 'go-goto-imports)
  (define-key go-mode-map (kbd "C-c g") 'godef-jump)
  (define-key go-mode-map (kbd "C-c d") 'godef-describe)
  (define-key go-mode-map (kbd "C-c f") 'gofmt)
  (define-key go-mode-map (kbd "C-c r") 'go-run)
  )
(add-hook 'go-mode-hook 'my-go-mode)


;; ------------------ ReactJS ------------------
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(require 'flycheck)
(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))

(provide 'init-local)
