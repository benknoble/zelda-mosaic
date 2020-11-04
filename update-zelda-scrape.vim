edit zelda-scrape.pl
/zelda_sites(\[/
+1
normal! di[
-1
read !./csv_to_prolog.py zeldadungeon_urls.csv
normal! >i[
exit
