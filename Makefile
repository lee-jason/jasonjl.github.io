include .env
export

dev:
	bundle install
	aws s3 sync ./assets s3://${AWS_S3_ASSETS_BUCKET} --acl public-read
	bundle exec jekyll serve

spellcheck s:
	@for i in _posts/*.md; do aspell -c $$i; done
	@for i in _drafts/*.md; do aspell -c $$i; done

clean c:
	rm -f _site/*.bak
	rm -f _drafts/*.bak
	rm -f _posts/*.bak

drafts d:
	jekyll server --drafts

future f:
	jekyll server --drafts --future

