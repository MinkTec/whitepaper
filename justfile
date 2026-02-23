
version := `cat VERSION`

build:
	echo '\newcommand{\paperversion}{{{{version}}}}' > src/version.tex
	tectonic -X build

watch:
	tectonic -X watch

release:
	git tag v{{version}}
	git push origin v{{version}}
