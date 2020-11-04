.POSIX:
SHELL = /bin/sh
.SUFFIXES:

zelda-scrape.pl: zeldadungeon_urls.csv update-zelda-scrape.vim csv_to_prolog.py
	vim -S update-zelda-scrape.vim

images.csv: zelda-scrape.pl
	./zelda-scrape.pl | grep -v 'reddit\|wp-content' > '$@'
