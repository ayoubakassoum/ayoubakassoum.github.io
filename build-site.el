;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)


(require 'ox-publish)


;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
     ;;org-html-head "<link rel="stylesheet" type="text/css" href="org_personal.css"/>")  ;;now directly in index.org. org_personal is adapted from https://gongzhitaao.org/orgcss/org.css
     ;;org-html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://gongzhitaao.org/orgcss/org.css\"/>")
)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "website:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil              ;; Don't Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file t)        ;; Include time stamp in file
       
       (list "website:static"
             :base-directory "./content"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|bib"
             :publishing-directory "./public"
             :recursive t
             :publishing-function 'org-publish-attachment
             )))

;; Generate the site output
(org-publish-all t)



(message "Build complete!")
