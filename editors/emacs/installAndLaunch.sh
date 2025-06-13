#!/bin/bash

set -e
NAME="$1"
VERSION="$2"
BIN="$3"

echo "🔧 Mise à jour du système..."
sudo apt update && sudo apt install -y git curl

echo "📦 Installation d'Emacs..."
sudo apt install -y emacs

echo "📁 Préparation du dossier de configuration Emacs..."
mkdir -p ~/.emacs.d

echo "📝 Écriture du fichier init.el avec straight.el et Eglot 1.17..."
cat <<'EOF' > ~/.emacs.d/init.el
;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Utiliser straight.el par défaut avec use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package math-symbol-lists)
(use-package highlight)
;; Installer Eglot version 1.17
(use-package eglot
  :straight (:host github :repo "joaotavora/eglot" :tag "1.17"))
EOF

echo "🚀 Premier lancement d’Emacs pour déclencher l’installation..."
echo
PATH="$BIN:$PATH" emacs --batch -l ~/.emacs.d/init.el --eval="(package-install-file \"${NAME}-${VERSION}.tar\") "

echo "🎉 Terminé ! Lance Emacs normalement pour commencer à coder avec Eglot 1.17."
