Sets

i Standorte von Kunden und Fahrzeugen
h Fahrzeuge
p Produkte;

alias(i,j)

option optcr = 0.05;
option Reslim = 21000;


parameter

fz(i,j)     Fahrtzeit von Standort i zu Standort j
d(i,p)      Nachfrage an Produkten an Standort i (= Kunden)
s(i,p)      Angebot an Produkten von Standort i (= Fahrer)
sz          Servicezeit
fahrerzahl
kundenanfang
MO          Big M
tf(i)       Frühste Ankunftszeit an Ort i
ts(i)       Späteste Ankunftszeit an Ort i
rw(h)       Reichweite von Fahrzeug h
kmmin(h)    Geschwindigkeit von h
;

sz = 15;
MO = 10000;


Variables
ZFW     Zielfunktionswert;

Binary variables
x       Teile von Touren
y       Zuordnung von Touren
;

Positive variable
z       Hilfsvariable
k       Anzahl der Fahrzeuge
t(i)    Ankunftszeit an Ort i
q       Dauer der Tour h
;

$include homedelivery.inc


Equations

Zielfunktion
OrtErreichen
OrtVerlassen
OrtZuTour
KeineKurzzyklen
KeinSelbstanfahren
Kapazitaetsbedingung
NurEineTour
NurEinFahrer
AnzahlFahrzeuge
FruhsteAnkunft
SpaetesteAnkunft
GenugendZeitService
MaximaleDauer
ErsteFahrtzeit
ReichweitenRestriktion
;

Zielfunktion..
     ZFW =e= sum((i,j,h),fz(i,j)*x(i,j,h))  + k * 60 + sum((i,h)$((ord(i)>=kundenanfang)), y(i,h) * sz) ;


OrtErreichen(i,h)..
         sum(j, x(i,j,h)) =e= y(i,h);

OrtVerlassen(j,h)..
         sum(i, x(i,j,h)) =e= y(j,h);

OrtZuTour(i)$(ord(i)>=kundenanfang)..
         sum(h, y(i,h) * po(i,h) ) =e= 1;

NurEineTour(i)$(ord(i)<=fahrerzahl)..
         sum(h, y(i,h)) =l= 1;

KeineKurzzyklen(i,j)$((ord(i)>=kundenanfang) and (ord(j)>=kundenanfang) and
                 (ord(i)<>ord(j)))..
         z(i)-z(j)+ card(i)*sum(h, x(i,j,h)) =l= card(i)-1;

KeinSelbstanfahren(i,h)..
         x(i,i,h) =e= 0        ;

NurEinFahrer(i,h)$((ord(i)<=fahrerzahl) and (ord(i)<>ord(h)))..

          y(i,h) =e= 0         ;

Kapazitaetsbedingung(h,p)..
          sum((i)$((ord(i)>=kundenanfang)), d(i,p) * y(i,h)) =l= sum((i)$((ord(i)<=fahrerzahl)), s(i,p) * y(i,h))      ;

ReichweitenRestriktion(h)..
             sum((i,j), x(i,j,h) * fz(i,j) ) * (kmmin(h) / 60)  =l= rw(h)          ;

AnzahlFahrzeuge..
      k =e= sum((i,h)$(ord(i)<=fahrerzahl), y(i,h))   ;

FruhsteAnkunft(i)$((ord(i)>=kundenanfang))..
      t(i) =g= tf(i);

SpaetesteAnkunft(i)..
      t(i) =l= ts(i);

ErsteFahrtzeit(i,j)$((ord(i)<=fahrerzahl) and (ord(j)>=kundenanfang) )..
      t(j) =g= tf(i) + sum(h, fz(i,j) * x(i,j,h));

GenugendZeitService(i,j,h)$((ord(i)>=kundenanfang) and (ord(j)>=1) and (ord(i)<>ord(j)))..
      t(j) =g= t(i) + sz + fz(i,j) - (1 - x(i,j,h)) * MO;

MaximaleDauer(i,j,h)$((ord(i)>=kundenanfang)and (ord(j)<=fahrerzahl))..
      t(i) + sz + fz(i,j) - (1 - x(i,j,h))*MO =l= 1200;


model Tour /all/;

solve Tour using mip minimizing ZFW;


file outputfile1 / 'homedeliverysolution-allocation.txt'/;

put outputfile1;

loop(i,
     loop(h,
             If (y.l(i,h) = 1.00,

             put i.tl:0, ' ; ' h.tl:0, ' ; ', y.l(i,h) /

            );
     );
);

putclose outputfile1;


file outputfile2 / 'homedeliverysolution-routes.txt'/;

put outputfile2;

loop(i,
     loop(j,
            loop(h,

             If (x.l(i,j,h) = 1.00,

             put i.tl:0, ' ; ' j.tl:0, ' ; ', h.tl:0, ' ; ' x.l(i,j,h) /

             );
             );
     );
);

putclose outputfile2;

file outputfile3 / 'homedeliverysolution-arrivaltime.txt'/;

put outputfile3;

loop(i,
             If (t.l(i) > 0.00,

         put i.tl:0, ' ; ' t.l(i) /

             );


);

putclose outputfile3;