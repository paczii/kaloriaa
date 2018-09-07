Sets

g Geschäfte
a Arbeitsplatz
k Kunde
;

option optcr = 0.01;

Parameter

fza(a,g)  Fahrtzeiten zu Geschäften
fzk(g,k)  Fahrtzeiten von Geschäften zum Kunden
z(k,g)    1 Wenn Geschäft g Kunde k bedienen kann
;


Variables
ZFW Zielfunktionswert;

Binary variables
x(a,k,g)  Wenn G gewählt wird für Kunde k
;

$include include3.inc

Equations

Zielfunktion
SollZuordnen
ArbeitsplatzZuordnen
;

Zielfunktion..
     ZFW =e= sum((a,g,k), x(a,k,g) * fza(a,g)) + sum((a,g,k), x(a,k,g) * fzk(g,k));

SollZuordnen(k)..
         sum((g,a), x(a,k,g) * z(k,g)) =e= 1;

ArbeitsplatzZuordnen(k,a)$((ord(k)<>ord(a)))..
         sum(g,x(a,k,g)) =e= 0;

model Tour /all/;

solve Tour using mip minimizing ZFW;


file outputfile1 / 'solution3.txt'/;

put outputfile1;

loop(k,
     loop(g,
            loop(a,
             If (x.l(a,k,g) = 1.00,

             put k.tl:0, ' ; ' g.tl:0, ' ; ', x.l(a,k,g) /

                );
            );
     );
);

putclose outputfile1;

