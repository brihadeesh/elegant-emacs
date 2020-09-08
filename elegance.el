;; -------------------------------------------------------------------
;; A very minimal but elegant and consistent theme
;; Copyright 2020 Nicolas P. Rougier
;; Copyright 2020 Brihadeesh S <brihadeesh@protonmail.com>
;; -------------------------------------------------------------------
;; This file is not part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>
;; -------------------------------------------------------------------


;; Only necessary for the splash screen mockup
;; -------------------------------------------------------------------
(with-eval-after-load 'org
  (setq org-display-inline-images t)
  (setq org-redisplay-inline-images t)
  (setq org-startup-with-inline-images "inlineimages")
  (setq org-hide-emphasis-markers t)
  (setq org-confirm-elisp-link-function nil)
  (setq org-link-frame-setup '((file . find-file))))
;; -------------------------------------------------------------------


;; Font and frame size
;; (set-face-font 'default "Operator Mono Light:size=9")
;; (set-face-font 'default "Input Mono Narrow ExLight:size=10")
;; (set-face-font 'default "Victor Mono Light:size=10")
(set-face-font 'default "Unifont Medium 8")
;; (set-face-font 'default "Sudo Thin 9")
(setq default-frame-alist
      (append (list '(width  . 105) '(height . 50)
		    '(vertical-scroll-bars . nil)
		    '(internal-border-width . 5)
		    ;; '(font . "Operator Mono Light:size=9"))))
		    ;; '(font . "Input Mono Narrow ExLight:size=10"))))
		    ;; '(font . "Victor Mono Light:size=10"))))
		    '(font . "Unifont Medium 8"))))
;; '(font . "Sudo Thin 9"))))
(set-frame-parameter (selected-frame) 'internal-border-width 5)

;; Line spacing, can be 0 for code and 1 or 2 for text
(setq-default line-spacing nil)

;; Underline line at descent position, not baseline position
(setq x-underline-at-descent-line t)

;; No ugly button for checkboxes
(setq widget-image-enable nil)

;; Line cursor and no blink
(set-default 'cursor-type  '(bar . 2))
(blink-cursor-mode t)

;; No sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; No Tooltips
(tooltip-mode 0)

;; Paren mode is part of the theme
(show-paren-mode t)

;; No fringe but nice glyphs for truncated and wrapped lines
(fringe-mode '(0 . 0))
(defface fallback '((t :family "Fira Code Light 7"
                       :inherit 'face-faded)) "Fallback")
(set-display-table-slot standard-display-table 'truncation
                        (make-glyph-code ?… 'fallback))
(set-display-table-slot standard-display-table 'wrap
                        (make-glyph-code ?↩ 'fallback))
(set-display-table-slot standard-display-table 'selective-display
                        (string-to-vector " …"))


;; When we set a face, we take care of removing any previous settings
(defun set-face (face style)
  "Reset a face and make it inherit style."
  (set-face-attribute face nil
                      :foreground 'unspecified :background 'unspecified
                      :family     'unspecified :slant      'unspecified
                      :weight     'unspecified :height     'unspecified
                      :underline  'unspecified :overline   'unspecified
                      :box        'unspecified :inherit    style))

;; A theme is fully defined by these six faces
(defgroup elegance nil
  "Faces for the elegance theme"
  :prefix "face-")

;; Do not show prefix when displaying the elegance group
(setq custom-unlispify-remove-prefixes t)

(defface face-visual-mark nil
  "Visual-Mark face is for highlighting the current line in such a
way that syntax highlighting is respected while making sure we
are mucking the code up on the right line, much like the
cursorline in vim."
  :group 'elegance)

(defface face-critical
  '((t :weight regular))
  "Critical face is for information that requires immediate action.
It should be of high constrast when compared to other faces. This
can be realized (for example) by setting an intense background
color, typically a shade of red. It must be used scarcely."
  :group 'elegance)

(defface face-popout
  '((t :weight light))
  "Popout face is used for information that needs attention.
To achieve such effect, the hue of the face has to be
sufficiently different from other faces such that it attracts
attention through the popout effect."
  :group 'elegance)

(defface face-strong
  '((t :weight regular))
  "Strong face is used for information of a structural nature.
It has to be the same color as the default color and only the
weight differs by one level (e.g., light/light or
light/bold). IT is generally used for titles, keywords,
directory, etc."
  :group 'elegance)

(defface face-salient
  '((t :weight light))
  "Salient face is used for information that are important.
To suggest the information is of the same nature but important,
the face uses a different hue with approximately the same
intensity as the default face. This is typically used for links."
  :group 'elegance)

(defface face-faded
  '((t :weight light))
  "Faded face is for information that are less important.
It is made by using the same hue as the default but with a lesser
intensity than the default. It can be used for comments,
secondary information and also replace italic (which is generally
abused anyway)."
  :group 'elegance)

(defface face-doc
  '((t :weight light))
  "???"
  :group 'elegance)

(defface face-subtle
  '((t :weight light))
  "Subtle face is used to suggest a physical area on the screen.
It is important to not disturb too strongly the reading of
information and this can be made by setting a very light
background color that is barely perceptible."
  :group 'elegance)


;; ;; Mode line (this might be slow because of the "☰" that requires substitution)
;; ;; This line below makes things a bit faster
;; (set-fontset-font "fontset-default"  '(#x2600 . #x26ff) "Fira Code Light 7")

(define-key mode-line-major-mode-keymap [header-line]
  (lookup-key mode-line-major-mode-keymap [mode-line]))

(defun mode-line-render (left right)
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))
(setq-default mode-line-format
              '((:eval
                 (mode-line-render
                  (format-mode-line (list
                                     ;; line & col number
                                     (propertize "%4l:%2c " 'face `(:inherit face-faded))
                                     ;; buffer name modified indicator
                                     (if (and buffer-file-name (buffer-modified-p))
                                         (propertize " %b ++" 'face `(:inherit face-popout))
                                       (propertize " %b " 'face `(:inherit face-strong)))))
                  (format-mode-line (list
                                     ;; TODO: run battery and time indicators if running exwm
                                     ;; (if (and (equal (getenv "WM") "exwm"))
                                     ;;     (propertize " % ")
                                     ;;   )
                                     ;; major-mode display
                                     ;; (propertize " %m " 'face `(:inherit face-faded))
                                     ))))))


;; Comment if you want to keep the modeline at the bottom
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format'(""))


;; Window divider
(setq window-divider-default-right-width 1)
(setq window-divider-default-bottom-width 1)
(setq window-divider-default-places 'all)
(window-divider-mode)

;; Modeline
(defun set-modeline-faces ()

  ;; Mode line at top
  (set-face 'header-line 'face-strong)
  (set-face-attribute 'header-line nil
                      :underline (face-foreground 'default))
  (set-face-attribute 'mode-line nil
                      :height 10
                      :underline (face-foreground 'default)
                      :overline nil
                      :box nil
                      :foreground (face-background 'default)
                      :background (face-background 'default))
  (set-face 'mode-line-inactive 'mode-line)



  (set-face-attribute 'cursor nil
                      :background (face-foreground 'face-popout))
  (set-face-attribute 'window-divider nil
                      :foreground (face-background 'face-faded))
  (set-face-attribute 'window-divider-first-pixel nil
                      :foreground (face-background 'face-faded))
  (set-face-attribute 'window-divider-last-pixel nil
                      :foreground (face-background 'face-faded))
  )

;; Buttons
(defun set-button-faces ()
  (set-face-attribute 'custom-button nil
                      :foreground (face-foreground 'face-faded)
                      :background (face-background 'face-subtle)
                      :box `(:line-width 1
                                         :color ,(face-foreground 'face-faded)
                                         :style nil))
  (set-face-attribute 'custom-button-mouse nil
                      :foreground (face-foreground 'default)
                      ;; :background (face-foreground 'face-faded)
                      :inherit 'custom-button
                      :box `(:line-width 1
                                         :color ,(face-foreground 'face-subtle)
                                         :style nil))
  (set-face-attribute 'custom-button-pressed nil
                      :foreground (face-background 'default)
                      :background (face-foreground 'face-salient)
                      :inherit 'face-salient
                      :box `(:line-width 1
                                         :color ,(face-foreground 'face-salient)
                                         :style nil)
                      :inverse-video nil))

;; TODO: Light theme colour definitions???
;; first define colours
;; (defconst el_fg           "#1c1c1c")
;; (defconst el_bg           "#ffffff")
;; (defconst el_bg_subtle    "#f0f0f0")
;; (defconst el_bg_critical  "#ff6347")
;; (defconst el_salient      "#00008b")
;; (defconst el_critical     "#ffffff")
;; (defconst el_faded        "#969896")
;; (defconst el_popout       "#ed6a43")
;; (defconst el_strong       "#000000")

;; (defun elegance-light ()
;;   (setq frame-background-mode 'light)
;;   (set-background-color ,el_bg)
;;   (set-foreground-color ,el_fg)
;;   (set-face-attribute 'default nil
;;                       :foreground (face-foreground 'default)
;;                       :background (face-background 'default))
;;   (set-face-attribute 'face-critical nil :foreground ,el_critical :background ,el_bg_critical)
;;   (set-face-attribute 'face-popout nil :foreground ,el_popout)
;;   (set-face-attribute 'face-strong nil :foreground ,el_strong :weight 'regular)
;;   (set-face-attribute 'face-salient nil :foreground ,el_salient :weight 'light)
;;   (set-face-attribute 'face-faded nil :foreground ,el_faded :weight 'light)
;;   (set-face-attribute 'face-subtle nil :background ,el_bg_subtle)
;;   (set-modeline-faces)
;;   (with-eval-after-load 'cus-edit (set-button-faces)))

;;;;;;;;;;;;;;;;;;
;; Light themes ;;
;;;;;;;;;;;;;;;;;;

(defun elegance-light ()
  (setq frame-background-mode 'light)
  (set-background-color "#ffffff")
  (set-foreground-color "#1c1c1c")
  (set-face-attribute 'default nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default))
  (set-face-attribute 'face-visual-mark nil :background "#d0d0d0")
  (set-face-attribute 'face-critical nil :foreground "#ffffff"
                      :background "#ff6347")
  (set-face-attribute 'face-popout nil :foreground "#e36209")
  (set-face-attribute 'face-strong nil :foreground "#000000")
  (set-face-attribute 'face-salient nil :foreground "#00008b")
  (set-face-attribute 'face-faded nil :foreground "#6a737d")
  ;; TODO: correct this color
  (set-face-attribute 'face-doc nil :foreground "#00978a")
  (set-face-attribute 'face-subtle nil :background "#f0f0f0")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

(defun elegance-github ()
  (setq frame-background-mode 'light)
  (set-background-color "#ffffff")
  (set-foreground-color "#24292e")
  (set-face-attribute 'default nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default))
  (set-face-attribute 'face-visual-mark nil :background "#d0d0d0")
  (set-face-attribute 'face-critical nil :foreground "#ffffff"
                      :background "#ff6347")
  (set-face-attribute 'face-popout nil :foreground "#032f62")
  (set-face-attribute 'face-strong nil :foreground "#6f42c1")
  (set-face-attribute 'face-salient nil :foreground "#d73a49")
  (set-face-attribute 'face-faded nil :foreground "#6a737d")
  ;; TODO: correct this color
  (set-face-attribute 'face-doc nil :foreground "#00978a")
  (set-face-attribute 'face-subtle nil :background "#f0f0f0")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

(defun elegance-acme ()
  (setq frame-background-mode 'light)
  (set-background-color "#ffffd7")
  (set-foreground-color "#101412")
  (set-face-attribute 'default nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default))
  (set-face-attribute 'face-visual-mark nil :background "#d7ffff")
  (set-face-attribute 'face-critical nil :foreground "#00ffff"
                      :background "#ff6347")
  (set-face-attribute 'face-popout nil :foreground "#424242")
  (set-face-attribute 'face-strong nil :foreground "#000000")
  (set-face-attribute 'face-salient nil :foreground "#cd00cd")
  (set-face-attribute 'face-faded nil :foreground "#a9a9a1")
  ;; TODO: correct this color
  (set-face-attribute 'face-doc nil :foreground "#00978a")
  (set-face-attribute 'face-subtle nil :background "#ffff87")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

(defun elegance-selenized-light ()
  (setq frame-background-mode 'light)
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
  (set-face-attribute 'face-doc nil :foreground "#00978a")
  (set-face-attribute 'face-subtle nil :background "#ece3cc")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

;;;;;;;;;;;;;;;;;
;; Dark themes ;;
;;;;;;;;;;;;;;;;;

(defun elegance-dark ()
  (setq frame-background-mode 'dark)
  (set-background-color "#424242")
  (set-foreground-color "#fcfcfc")
  (set-face-attribute 'default nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default))
  (set-face-attribute 'face-visual-mark nil :background "#d0d0d0")
  (set-face-attribute 'face-critical nil :foreground "#385f38" :background "#f8f893")
  (set-face-attribute 'face-popout nil :foreground "#f0dfaf")
  (set-face-attribute 'face-strong nil :foreground "#ffffff")
  (set-face-attribute 'face-salient nil :foreground "#dca3a3")
  (set-face-attribute 'face-faded nil :foreground "#a8a8a8")
  (set-face-attribute 'face-subtle nil :background "#4f4f4f")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

;; gunmetal??
(defun elegance-gunmetal-dark ()
  (setq frame-background-mode 'dark)
  (set-background-color "#080808")
  (set-foreground-color "#e7e7e7")
  (set-face-attribute 'default nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default))
  (set-face-attribute 'face-visual-mark nil :background "#4a4a4a")
  (set-face-attribute 'face-critical nil :foreground "#ffffff"
                      :background "#ac8a8c")
  (set-face-attribute 'face-popout nil :foreground "#c49ec4")
  (set-face-attribute 'face-strong nil :foreground "#ffffff")
  (set-face-attribute 'face-salient nil :foreground "#8f8aac")
  (set-face-attribute 'face-faded nil :foreground "#9e9e9e")
  (set-face-attribute 'face-doc nil :foreground "#9e9e9e")
  (set-face-attribute 'face-subtle nil :background "#303030")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

;; freaquancy's theme based on freebsd
;; TODO needs work
(defun elegance-desert ()
  (setq frame-background-mode 'dark)
  (set-background-color "#333333")
  (set-foreground-color "#eeeeee")
  (set-face-attribute 'default nil
                      :foreground (face-foreground 'default)
                      :background (face-background 'default))
  (set-face-attribute 'face-visual-mark nil :background "#666666")
  (set-face-attribute 'face-critical nil :foreground "#ffffff"
                      :background "#e56b55")
  (set-face-attribute 'face-popout nil :foreground "#fffff0")
  (set-face-attribute 'face-strong nil :foreground "#6688ff")
  (set-face-attribute 'face-salient nil :foreground "#FF4500")
  (set-face-attribute 'face-faded nil :foreground "#A9A9A9")
  (set-face-attribute 'face-doc nil :foreground "#A9A9A9")
  (set-face-attribute 'face-subtle nil :background "#4a4a4a")
  (set-modeline-faces)
  (with-eval-after-load 'cus-edit (set-button-faces)))

;; Set theme
(elegance-github)

;; Structural
(set-face 'bold                                          'face-strong)
(set-face 'italic                                         'face-faded)
(set-face 'bold-italic                                   'face-strong)
(set-face 'region                                   'face-visual-mark)
(set-face 'highlight                                     'face-subtle)
(set-face 'fixed-pitch                                       'default)
(set-face 'fixed-pitch-serif                                 'default)
(set-face 'variable-pitch                                    'default)
(set-face 'cursor                                         'face-faded)

;; Semantic
(set-face 'shadow                                         'face-faded)
(set-face 'success                                      'face-salient)
(set-face 'warning                                       'face-popout)
(set-face 'error                                       'face-critical)

;; General
(set-face 'buffer-menu-buffer                            'face-strong)
(set-face 'minibuffer-prompt                             'face-strong)
(set-face 'link                                         'face-salient)
(set-face 'fringe                                         'face-faded)
(set-face 'isearch                                       'face-strong)
(set-face 'isearch-fail                                   'face-faded)
(set-face 'lazy-highlight                                'face-subtle)
(set-face 'trailing-whitespace                           'face-subtle)
(set-face 'show-paren-match                             'face-salient)
(set-face 'show-paren-mismatch                         'face-critical)
(set-face-attribute 'tooltip nil                         :height 0.85)
(set-face 'line-number                                    'face-faded)
(set-face 'line-number-current-line                      'face-strong)

;; Programmation mode
(set-face 'font-lock-comment-face                         'face-faded)
(set-face 'font-lock-doc-face                             'face-faded)
(set-face 'font-lock-string-face                         'face-popout)
(set-face 'font-lock-constant-face                       'face-popout)
(set-face 'font-lock-warning-face                        'face-popout)
(set-face 'font-lock-function-name-face                  'face-strong)
(set-face 'font-lock-variable-name-face                  'face-strong)
(set-face 'font-lock-builtin-face                       'face-salient)
(set-face 'font-lock-type-face                          'face-salient)
(set-face 'font-lock-keyword-face                       'face-salient)
(set-face 'font-lock-negation-char-face                     'face-doc)

;; Documentation
(with-eval-after-load 'info
  (set-face 'info-menu-header                            'face-strong)
  (set-face 'info-header-node                            'face-normal)
  (set-face 'Info-quoted                                  'face-faded)
  (set-face 'info-title-1                                'face-strong)
  (set-face 'info-title-2                                'face-strong)
  (set-face 'info-title-3                                'face-strong)
  (set-face 'info-title-4                               'face-strong))

;; Bookmarks
(with-eval-after-load 'bookmark
(set-face 'bookmark-menu-heading                       'face-strong)
(set-face 'bookmark-menu-bookmark                    'face-salient))

;; Message
(with-eval-after-load 'message
(set-face 'message-cited-text                           'face-faded)
(set-face 'message-header-cc                               'default)
(set-face 'message-header-name                         'face-strong)
(set-face 'message-header-newsgroups                       'default)
(set-face 'message-header-other                            'default)
(set-face 'message-header-subject                     'face-salient)
(set-face 'message-header-to                          'face-salient)
(set-face 'message-header-xheader                          'default)
(set-face 'message-mml                                 'face-popout)
(set-face 'message-separator                           'face-faded))

;; Outline
(with-eval-after-load 'outline
(set-face 'outline-1                                   'face-strong)
(set-face 'outline-2                                   'face-strong)
(set-face 'outline-3                                   'face-strong)
(set-face 'outline-4                                   'face-strong)
(set-face 'outline-5                                   'face-strong)
(set-face 'outline-6                                   'face-strong)
(set-face 'outline-7                                   'face-strong)
(set-face 'outline-8                                  'face-strong))

;; Interface
(with-eval-after-load 'cus-edit
(set-face 'widget-field                                'face-subtle)
(set-face 'widget-button                               'face-strong)
(set-face 'widget-single-line-field                    'face-subtle)
(set-face 'custom-group-subtitle                       'face-strong)
(set-face 'custom-group-tag                            'face-strong)
(set-face 'custom-group-tag-1                          'face-strong)
(set-face 'custom-comment                               'face-faded)
(set-face 'custom-comment-tag                           'face-faded)
(set-face 'custom-changed                             'face-salient)
(set-face 'custom-modified                            'face-salient)
(set-face 'custom-face-tag                             'face-strong)
(set-face 'custom-variable-tag                             'default)
(set-face 'custom-invalid                              'face-popout)
(set-face 'custom-visibility                          'face-salient)
(set-face 'custom-state                               'face-salient)
(set-face 'custom-link                               'face-salient))

;; Package
(with-eval-after-load 'package
(set-face 'package-description                             'default)
(set-face 'package-help-section-name                       'default)
(set-face 'package-name                               'face-salient)
(set-face 'package-status-avail-obso                    'face-faded)
(set-face 'package-status-available                        'default)
(set-face 'package-status-built-in                    'face-salient)
(set-face 'package-status-dependency                  'face-salient)
(set-face 'package-status-disabled                      'face-faded)
(set-face 'package-status-external                         'default)
(set-face 'package-status-held                             'default)
(set-face 'package-status-incompat                      'face-faded)
(set-face 'package-status-installed                   'face-salient)
(set-face 'package-status-new                              'default)
(set-face 'package-status-unsigned                         'default)

;; Button face is hardcoded, we have to redefine the relevant
;; function
(defun package-make-button (text &rest properties)
"Insert button labeled TEXT with button PROPERTIES at point.
PROPERTIES are passed to `insert-text-button', for which this
function is a convenience wrapper used by `describe-package-1'."
(let ((button-text (if (display-graphic-p)
text (concat "[" text "]")))
(button-face (if (display-graphic-p)
'(:box `(:line-width 1
:color "#999999":style nil)
:foreground "#999999"
:background "#F0F0F0")
'link)))
(apply #'insert-text-button button-text
'face button-face 'follow-link t properties)))
)

;; Flyspell
(with-eval-after-load 'flyspell
(set-face 'flyspell-duplicate                         'face-popout)
(set-face 'flyspell-incorrect                         'face-popout))

;; Ido
(with-eval-after-load 'ido
(set-face 'ido-first-match                            'face-salient)
(set-face 'ido-only-match                               'face-faded)
(set-face 'ido-subdir                                 'face-strong))

;; Diff
(with-eval-after-load 'diff-mode
(set-face 'diff-header                                  'face-faded)
(set-face 'diff-file-header                            'face-strong)
(set-face 'diff-context                                    'default)
(set-face 'diff-removed                                 'face-faded)
(set-face 'diff-changed                                'face-popout)
(set-face 'diff-added                                 'face-salient)
(set-face 'diff-refine-added            '(face-salient face-strong))
(set-face 'diff-refine-changed                         'face-popout)
(set-face 'diff-refine-removed                          'face-faded)
(set-face-attribute     'diff-refine-removed nil :strike-through t))

;; Term
(with-eval-after-load 'term
;; (setq eterm-256color-disable-bold nil)
(set-face 'term-bold                                   'face-strong)
(set-face-attribute 'term-color-black nil
:foreground (face-foreground 'default)
:background (face-foreground 'default))
(set-face-attribute 'term-color-white nil
:foreground "white" :background "white")
(set-face-attribute 'term-color-blue nil
                    :foreground "#42A5F5" :background "#BBDEFB")
(set-face-attribute 'term-color-cyan nil
                    :foreground "#26C6DA" :background "#B2EBF2")
(set-face-attribute 'term-color-green nil
                    :foreground "#66BB6A" :background "#C8E6C9")
(set-face-attribute 'term-color-magenta nil
                    :foreground "#AB47BC" :background "#E1BEE7")
(set-face-attribute 'term-color-red nil
                    :foreground "#EF5350" :background "#FFCDD2")
(set-face-attribute 'term-color-yellow nil
                    :foreground "#FFEE58" :background "#FFF9C4"))

;; vterm
;; (setq ansi-color-names-vector
;;       ["#ffffff" "#ed6a43" "#00008b" "#000000" "#969896" "#ed6a43" "#00008b" "#000000"])

;; ;; is this obsolete??
(with-eval-after-load 'vterm
  (setq vterm-disable-bold-font t)
  (set-face-attribute 'vterm-color-default nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-black nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-red nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-green nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-yellow nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-blue nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-magenta nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-cyan nil :inherit '(face-default))
  (set-face-attribute 'vterm-color-white nil :inherit '(face-default))
  )


;; org-agenda
(with-eval-after-load 'org-agenda
  (set-face 'org-agenda-calendar-event                    'default)
  (set-face 'org-agenda-calendar-sexp                     'face-faded)
  (set-face 'org-agenda-clocking                          'face-faded)
  (set-face 'org-agenda-column-dateline                   'face-faded)
  (set-face 'org-agenda-current-time                      'face-faded)
  (set-face 'org-agenda-date                            'face-salient)
  (set-face 'org-agenda-date-today        '(face-salient face-strong))
  (set-face 'org-agenda-date-weekend                      'face-faded)
  (set-face 'org-agenda-diary                             'face-faded)
  (set-face 'org-agenda-dimmed-todo-face                  'face-faded)
  (set-face 'org-agenda-done                              'face-faded)
  (set-face 'org-agenda-filter-category                   'face-faded)
  (set-face 'org-agenda-filter-effort                     'face-faded)
  (set-face 'org-agenda-filter-regexp                     'face-faded)
  (set-face 'org-agenda-filter-tags                       'face-faded)
  (set-face 'org-agenda-property-face                     'face-faded)
  (set-face 'org-agenda-restriction-lock                  'face-faded)
  (set-face 'org-agenda-structure                        'face-faded))

;; org mode
(with-eval-after-load 'org
  (set-face 'org-archived                                 'face-faded)
  (set-face 'org-block                                    'face-faded)
  (set-face 'org-block-begin-line                         'face-faded)
  (set-face 'org-block-end-line                           'face-faded)
  (set-face 'org-checkbox                                 'face-faded)
  (set-face 'org-checkbox-statistics-done                 'face-faded)
  (set-face 'org-checkbox-statistics-todo                 'face-faded)
  (set-face 'org-clock-overlay                            'face-faded)
  (set-face 'org-code                                     'face-faded)
  (set-face 'org-column                                   'face-faded)
  (set-face 'org-column-title                             'face-faded)
  (set-face 'org-date                                     'face-faded)
  (set-face 'org-date-selected                            'face-faded)
  (set-face 'org-default                                  'face-faded)
  (set-face 'org-document-info                            'face-faded)
  (set-face 'org-document-info-keyword                    'face-faded)
  (set-face 'org-document-title                           'face-faded)
  (set-face 'org-done                                        'default)
  (set-face 'org-drawer                                   'face-faded)
  (set-face 'org-ellipsis                                 'face-faded)
  (set-face 'org-footnote                                 'face-faded)
  (set-face 'org-formula                                  'face-faded)
  (set-face 'org-headline-done                            'face-faded)
  ;;  (set-face 'org-hide                                     'face-faded)
  ;;  (set-face 'org-indent                                   'face-faded)
  (set-face 'org-latex-and-related                        'face-faded)
  (set-face 'org-level-1                                 'face-strong)
  (set-face 'org-level-2                                 'face-strong)
  (set-face 'org-level-3                                 'face-strong)
  (set-face 'org-level-4                                 'face-strong)
  (set-face 'org-level-5                                 'face-strong)
  (set-face 'org-level-6                                 'face-strong)
  (set-face 'org-level-7                                 'face-strong)
  (set-face 'org-level-8                                 'face-strong)
  (set-face 'org-link                                   'face-salient)
  (set-face 'org-list-dt                                  'face-faded)
  (set-face 'org-macro                                    'face-faded)
  (set-face 'org-meta-line                                'face-faded)
  (set-face 'org-mode-line-clock                          'face-faded)
  (set-face 'org-mode-line-clock-overrun                  'face-faded)
  (set-face 'org-priority                                 'face-faded)
  (set-face 'org-property-value                           'face-faded)
  (set-face 'org-quote                                    'face-faded)
  (set-face 'org-scheduled                                'face-faded)
  (set-face 'org-scheduled-previously                     'face-faded)
  (set-face 'org-scheduled-today                          'face-faded)
  (set-face 'org-sexp-date                                'face-faded)
  (set-face 'org-special-keyword                          'face-faded)
  (set-face 'org-table                                    'face-faded)
  (set-face 'org-tag                                      'face-faded)
  (set-face 'org-tag-group                                'face-faded)
  (set-face 'org-target                                   'face-faded)
  (set-face 'org-time-grid                                'face-faded)
  (set-face 'org-todo                                    'face-popout)
  (set-face 'org-upcoming-deadline                        'face-faded)
  (set-face 'org-verbatim                                 'face-faded)
  (set-face 'org-verse                                    'face-faded)
  (set-face 'org-warning                                'face-popout))

;; Mu4e
(with-eval-after-load 'mu4e
  (set-face 'mu4e-attach-number-face                     'face-strong)
  (set-face 'mu4e-cited-1-face                            'face-faded)
  (set-face 'mu4e-cited-2-face                            'face-faded)
  (set-face 'mu4e-cited-3-face                            'face-faded)
  (set-face 'mu4e-cited-4-face                            'face-faded)
  (set-face 'mu4e-cited-5-face                            'face-faded)
  (set-face 'mu4e-cited-6-face                            'face-faded)
  (set-face 'mu4e-cited-7-face                            'face-faded)
  (set-face 'mu4e-compose-header-face                     'face-faded)
  (set-face 'mu4e-compose-separator-face                  'face-faded)
  (set-face 'mu4e-contact-face                          'face-salient)
  (set-face 'mu4e-context-face                            'face-faded)
  (set-face 'mu4e-draft-face                              'face-faded)
  (set-face 'mu4e-flagged-face                            'face-faded)
  (set-face 'mu4e-footer-face                             'face-faded)
  (set-face 'mu4e-forwarded-face                          'face-faded)
  (set-face 'mu4e-header-face                                'default)
  (set-face 'mu4e-header-highlight-face                  'face-subtle)
  (set-face 'mu4e-header-key-face                        'face-strong)
  (set-face 'mu4e-header-marks-face                       'face-faded)
  (set-face 'mu4e-header-title-face                      'face-strong)
  (set-face 'mu4e-header-value-face                          'default)
  (set-face 'mu4e-highlight-face                         'face-popout)
  (set-face 'mu4e-link-face                             'face-salient)
  (set-face 'mu4e-modeline-face                           'face-faded)
  (set-face 'mu4e-moved-face                              'face-faded)
  (set-face 'mu4e-ok-face                                 'face-faded)
  (set-face 'mu4e-region-code                             'face-faded)
  (set-face 'mu4e-replied-face                          'face-salient)
  (set-face 'mu4e-special-header-value-face                  'default)
  (set-face 'mu4e-system-face                             'face-faded)
  (set-face 'mu4e-title-face                             'face-strong)
  (set-face 'mu4e-trashed-face                            'face-faded)
  (set-face 'mu4e-unread-face                            'face-strong)
  (set-face 'mu4e-url-number-face                         'face-faded)
  (set-face 'mu4e-view-body-face                             'default)
  (set-face 'mu4e-warning-face                            'face-faded))

(provide 'elegance)
