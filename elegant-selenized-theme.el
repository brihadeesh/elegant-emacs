;;; elegant-selenizedless-theme.el --- A very minimal but elegant and consistent theme
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
(deftheme elegant-selenizedless
  "A simple yet elegant theme for emacs.")
;;; -------------------------------------------------------------------


;;; Require elegant-common
;;; -------------------------------------------------------------------
;; (load "~/.emacs.d/elegant-emacs/elegant.el")
(require 'elegant)
;;; -------------------------------------------------------------------


;;; General colors
;;; -------------------------------------------------------------------
(set-background-color "#fbf3db")
(set-foreground-color "#53676d")
(set-face-attribute 'default nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))
(set-face-attribute 'face-visual-mark nil :background "#ffffd7")
(set-face-attribute 'face-critical nil :foreground "#ffffff"
                    :background "#d2212d")
(set-face-attribute 'face-popout nil :foreground "#cc1729")
(set-face-attribute 'face-strong nil :foreground "#3a4d53")
(set-face-attribute 'face-salient nil :foreground "#006dce")
(set-face-attribute 'face-faded nil :foreground "#909995")
(set-face-attribute 'face-negativenum nil :foreground "#00978a")
(set-face-attribute 'face-subtle nil :background "#ece3cc")

(set-modeline-faces)

'(cus-edit (set-button-faces))
;;; -------------------------------------------------------------------


;;; Provide the elegant-selenizedless theme
;;; -------------------------------------------------------------------
(provide-theme 'elegant-selenizedless)
;;; -------------------------------------------------------------------


;;; elegant-selenizedless-theme.el ends here
