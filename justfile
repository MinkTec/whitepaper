
version := `cat VERSION`

build:
	echo '\newcommand{\paperversion}{'{{version}}'}' > src/version.tex
	cd src && tectonic -X build

watch:
	cd src && tectonic -X watch

release:
	git tag v{{version}}
	git push origin v{{version}}
