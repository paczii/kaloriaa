Sets

b Boxen
p Produkte
;

option optcr = 0.01;


Parameter

c        Volumen der Boxen
w(p)     Volumen von Produkt p
;


Variables
ZFW Zielfunktionswert;

Binary variables
x       Gibt an ob Produkt p in Box b gelegt wird
y       Gibt an ob Box b im Einsatz ist
;

$include binpacking.inc

Equations
Zielfunktion
Kapazitaet
AlleProdukteZuordnen
;

Zielfunktion..
     ZFW =e= sum((b),y(b));

Kapazitaet(b)..
         sum(p, x(p,b) * w(p) ) =l= c * y(b) ;

AlleProdukteZuordnen(p)..
         sum((b), x(p,b)  ) =e= 1 ;


model BinPacking /all/;

solve BinPacking using mip minimizing ZFW;

file outputfile1 / 'binsolution.txt'/;

put outputfile1;

put ZFW.l /

putclose outputfile1;

