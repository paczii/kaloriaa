Sets

g Geschäfte
k Kunde
;

option optcr = 0.01;


Parameter

fz(k,g)  Fahrtzeiten zu Geschäften
z(k,g)    1 Wenn Geschäft g Kunde k bedienen kann
;


Variables
ZFW Zielfunktionswert;

Binary variables
x(k,g)  Wenn g gewählt wird für Kunde k
;

$include include2.inc

;

Equations

Zielfunktion
SollZuordnen
;

Zielfunktion..
     ZFW =e= sum((k,g), x(k,g) * fz(k,g)) ;

SollZuordnen(k)..
         sum(g, x(k,g) * z(k,g) ) =e= 1;


model Tour /all/;

solve Tour using mip minimizing ZFW;


file outputfile1 / 'solution2.txt'/;

put outputfile1;

loop(k,
     loop(g,
             If (x.l(k,g) = 1.00,

             put k.tl:0, ' ; ' g.tl:0, ' ; ', x.l(k,g) /

            );
     );
);

putclose outputfile1;