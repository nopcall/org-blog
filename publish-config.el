;;; orgblog-publisher nothing
(require 'org-publish)

(setq org-publish-project-alist
      '(
        ;; These are the main web files
        ("org-notes"
         :base-directory "./posts/" ;; Change this to your local dir
         :base-extension "org"
         :publishing-directory "./output/"
;;         :body-only t
         :recursive t
         :publishing-function org-publish-org-to-html
;;         :link-home "index.html"
;;         :link-up "sitemap.html"
         :html-link-home "index.html"
         :html-link-up "sitemap.html"

         :headline-levels 4       ; Just the default for this project.
         :section-numbers nil
         :auto-preamble t
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.

         :author "Holbrook"
         :email "wanghaikuo@gmail.com"
;;         :style    "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\"/>"
         :html-head  "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\"/>"
         :html-preamble "可以添加博客的头部"
         :html-postamble " 评论系统代码(disqus,多说等等)
      <p class=\"author\">Author: %a (%e)</p><p>Last Updated %d . Created by %c </p>"


;;         :section-numbers nil
;;         :table-of-contents t
;;         :style-include-default nil
         )

        ;; These are static files (images, pdf, etc)
        ("post-static"
         :base-directory "./posts/" ;; Change this to your local dir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc"
         :publishing-directory "./output/images/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ;; These are static files (images, pdf, etc)
        ("blog-static"
         :base-directory "./_sites/" ;; Change this to your local dir
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|asc"
         :publishing-directory "./output/"

         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org" :components ("org-notes" "org-static"))
        )
      )

(defun myweb-publish nil
  "Publish myweb."
  (interactive)
  (org-publish-all))

(myweb-publish)

