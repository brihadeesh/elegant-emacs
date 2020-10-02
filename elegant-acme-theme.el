;;; elegant-acme-theme.el --- A very minimal but elegant and consistent theme
;;; Copyright (C) 2020 Nicolas P. Rougier
;;; Copyright (C) 2020 Brihadeesh S
;;; -------------------------------------------------------------------
;;; Author: Nicolas P. Rougier
;;; Author: Brihadeesh S
;;; URL: https://github.com/brihadeesh/elegant-emacs
;;; -------------------------------------------------------------------
;;; Version: 0.1
;;; Package-Requires: ((emacs "25.1"))
;;; -------------------------------------------------------------------
;;; This theme was packaged by Brihadeesh S <github.com/brihadeesh>
;;; -------------------------------------------------------------------
;;; This file is not part of GNU Emacs.
;;;
;;; This program is free software: you can redistribute it and/or
;;; modify it under the terms of the GNU General Public License as
;;; published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program. If not, see <http://www.gnu.org/licenses/>
;;; -------------------------------------------------------------------
;;; Commentary:
;;; This theme offers an almost vanilla yet elegant Emacs experience
;;; -------------------------------------------------------------------
;;; Code:


;;; Theme definition
;;; -------------------------------------------------------------------
(deftheme elegant-acme
  "A simple yet elegant theme for emacs.")
;;; -------------------------------------------------------------------


;;; Require elegant
;;; -------------------------------------------------------------------
;; (load "~/.emacs.d/elegant-emacs/elegant.el")
(require 'elegant)
;;; -------------------------------------------------------------------


;;; General colors
;;; -------------------------------------------------------------------
(set-background-color "#ffffd7")
(set-foreground-color "#101412")
(set-face-attribute 'default nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))
(set-face-attribute 'face-visual-mark nil :background "#d7ffff")
(set-face-attribute 'face-critical nil :foreground "#00ffff" :background "#ff6347")
(set-face-attribute 'face-popout nil :foreground "#424242")
(set-face-attribute 'face-strong nil :foreground "#000000")
(set-face-attribute 'face-salient nil :foreground "#cd00cd")
(set-face-attribute 'face-faded nil :foreground "#a9a9a1")
(set-face-attribute 'face-negativenum nil :foreground "#00978a")
(set-face-attribute 'face-subtle nil :background "#ffff87")

(set-modeline-faces)

'(cus-edit (set-button-faces))
;;; -------------------------------------------------------------------


;;; Provide the elegant-acme theme
;;; -------------------------------------------------------------------
(provide-theme 'elegant-acme)
;;; -------------------------------------------------------------------


;;; elegant-acme-theme.el ends here
