certamen.exe: P1.l P1.y
	bison -d P1.y
	flex P1.l
	gcc -Wall -o $@ P1.tab.c lex.yy.c -lfl

clean:
	rm P1.tab.* lex.yy.c certamen.exe