
version := `cat VERSION`

build:
	printf '\\\\newcommand{\\\\paperversion}{%s}' {{version}} > src/version.tex
	epstopdf assets/rectify_logo.eps assets/rectify_logo.pdf
	tectonic -X build

watch:
	tectonic -X watch

release:
	git tag v{{version}}
	git push origin v{{version}}
