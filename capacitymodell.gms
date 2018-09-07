*Indexmengen

Sets

b Bestellungen
g Geschäfte
p Produkte;

option optcr = 0.01;


*Parameter

parameter

o(b,p)     1 Wenn Produkt p in Bestellung b gewünscht ist
s(g,p)     1 Wenn Produkt p in Geschäft g verfügbar ist
;


*Variablen

Variables
ZFW Zielfunktionswert;

Binary variables
x(g,b)      1 Wenn Geschäft g die Bestellung b bedienen kann
;


$include capacityinclude.inc


Equations

Zielfunktion
Produkte

;

Zielfunktion..
     ZFW =e= sum((g,b),x(g,b)) ;


Produkte(b,p)..
     sum((g), s(g,p) * x(g,b)) =g= sum(g, o(b,p) * x(g,b) )     ;




model Tour /all/;

Option MINLP = SCIP;

solve Tour using mip maximizing ZFW;

display x.l;
display ZFW.l;




file outputfile1 / 'capasolution.txt'/;

put outputfile1;

loop(g,
     loop(b,
             If (x.l(g,b) = 1.00,

             put g.tl:0, ' ; ' b.tl:0, ' ; ', x.l(g,b) /

            );
     );
);

putclose outputfile1;


