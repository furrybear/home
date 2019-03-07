;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(setq evil-default-state 'emacs)

