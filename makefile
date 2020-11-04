.POSIX:
SHELL = /bin/sh
.SUFFIXES:

PROCS = 1

zelda-scrape.pl: zeldadungeon_urls.csv update-zelda-scrape.vim csv_to_prolog.py
	vim -S update-zelda-scrape.vim

images.csv: zelda-scrape.pl
	./zelda-scrape.pl | grep -v 'reddit\|wp-content\|Map_HyruleCastle"\|Genie-Art.png' > '$@'

images: images.csv
	mkdir '$@'
	./csv_to_shell.py images.csv | xargs -L1 -P'$(PROCS)' ./imdl