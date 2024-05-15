GEM_TO_PUSH = `ls craby*.gem | tail -n 1`

build:
	gem build craby.gemspec

publish:
	@echo "gem push ${GEM_TO_PUSH}"
	@gem push ${GEM_TO_PUSH}
