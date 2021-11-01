C1.exe: C1.l C1.y
	bison -d C1.y
	flex C1.l
	gcc lex.yy.c C1.tab.c

clean:
	rm C1.tab.* lex.yy.c a.out