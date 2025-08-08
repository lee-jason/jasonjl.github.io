include .env
export

install:
	bundle install

sync_assets:
	aws s3 sync ./assets s3://${AWS_S3_ASSETS_BUCKET} --acl public-read

dev:
	make install
	make sync_assets
	bundle exec jekyll serve

spellcheck s:
	@for i in _posts/*.md; do aspell -c $$i; done
	@for i in _drafts/*.md; do aspell -c $$i; done

clean c:
	rm -f _site/*.bak
	rm -f _drafts/*.bak
	rm -f _posts/*.bak

drafts d:
	make install
	make sync_assets
	jekyll server --drafts

future f:
	make install
	make sync_assets
	jekyll server --drafts --future

