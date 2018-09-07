*Indexmengen

Sets

i Standorte von Kunden und Fahrzeugen
h Fahrzeuge
p Produkte;

alias(i,j)

option optcr = 0.1;


*Parameter

parameter

fz(i,j)  Fahrtzeit von Standort i zu Standort j
d(i,p)     Nachfrage an Produkten an Standort i (= Kunden)
s(i,p)     Angebot an Produkten von Standort i (= Fahrer)
sz       Servicezeit
po(h,i)  1 Wenn Kunde i von Fahrzeug h beliefert werden kann (Kapazität und Liefergebiet)
fahrerzahl
kundenanfang
MO    Big M
tf(i)  fr�hste m�gliche Ankunftszeit an Ort i
ts(i)  sp�teste m�gliche ankunftszeit an Ort i
rw(h)   Reichweite von Fahrzeug h
;

sz = 4;
MO = 10000;

*Variablen

Variables
ZFW Zielfunktionswert;

Binary variables
x  Teile von Touren
y  Zuordnung von Touren
;

Positive variable
z  Hilfsvariable
k  Anzahl der eingesetzten Fahrzeuge
t(i) Ankunftszeit an Ort i
q  Dauer der Tour h
rwh
da
pause
ta
;

$include include.inc


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
*Gesamtdauer
ErsteFahrtzeit
Reichweite
ReichweitenRestriktion
Fahrtzeit
Pausenzeit
Hintereinander
Abfahrtszeit
;

Zielfunktion..
*     ZFW =e= sum((i,j,h),fz(i,j)*x(i,j,h)) + sum((i,h), y(i,h) * sz ) + k * 1000 + sum((i,h), pause(i,h)) ;
     ZFW =e= sum((i,j,h),fz(i,j)*x(i,j,h)) ;


Hintereinander(i,j)$((ord(i)=3) and (ord(j)=4) )..
          ta(j) =g= t(i)  ;

*Abfahrtszeit(i)..
*          ta(i)  =e= t(i) + 10  ;

Abfahrtszeit(i)$((ord(i)<=fahrerzahl) )..
        ta(i) =e= sum((j,h), x(i,j,h) * t(j)) - sum((j,h), fz(i,j) * x(i,j,h) ) ;




OrtErreichen(i,h)..
         sum(j, x(i,j,h)) =e= y(i,h);

OrtVerlassen(j,h)..
         sum(i, x(i,j,h)) =e= y(j,h);

OrtZuTour(i)$(ord(i)>=kundenanfang)..
         sum(h, y(i,h) * po(h,i) ) =e= 1;

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

*Kapazitaetsbedingung(h)..
*            sum((i)$(ord(i)>=kundenanfang), y(i,h))  =e= sum((i)$(ord(i)>=kundenanfang), y(i,h))        ;

ReichweitenRestriktion(h)..
             sum((i,j), x(i,j,h) * fz(i,j) ) * kmmin(h)  =l= rw(h)          ;

Reichweite(h)..
             rwh(h) =e= sum((i,j), x(i,j,h) * fz(i,j) ) * kmmin(h)          ;

Fahrtzeit(h)..
             da(h) =e= sum((i,j), x(i,j,h) * fz(i,j) * sz)          ;


AnzahlFahrzeuge..
      k =e= sum((i,h)$(ord(i)<=fahrerzahl), y(i,h))   ;

FruhsteAnkunft(i)$((ord(i)>=kundenanfang))..
      t(i) =g= tf(i);

*SpaetesteAnkunft(i)$((ord(i)>=kundenanfang))..
SpaetesteAnkunft(i)..
      t(i) =l= ts(i);



ErsteFahrtzeit(i,j)$((ord(i)<=fahrerzahl) and (ord(j)>=kundenanfang) )..
      t(j) =g= tf(i) + sum(h, fz(i,j) * x(i,j,h));

GenugendZeitService(i,j,h)$((ord(i)>=kundenanfang) and (ord(j)>=1) and (ord(i)<>ord(j)))..
      t(j) =g= t(i) + sz + fz(i,j) - (1 - x(i,j,h)) * MO;

MaximaleDauer(i,j,h)$((ord(i)>=kundenanfang)and (ord(j)<=fahrerzahl))..
      t(i) + sz + fz(i,j) - (1 - x(i,j,h))*MO =l= 1200;

*Gesamtdauer(i,j,h)$((ord(i)>=kundenanfang)and (ord(j)<=fahrerzahl))..
*      t(i) + sz + fz(i,j) - (1 - x(i,j,h))*MO =l= q(h);


Pausenzeit(i,j,h)$((ord(i)>=kundenanfang) and (ord(j)>=1) and (ord(i)<>ord(j)))..
      pause(i,h) =g= ( t(j) - (t(i) + sz + fz(i,j)) ) - (1 - x(i,j,h))*MO ;


model Tour /all/;

Option MINLP = SCIP;

solve Tour using minlp minimizing ZFW;

display x.l, y.l;
display k.l, t.l, rwh.l, da.l, ta.l;
display ZFW.l;
display pause.l;




file outputfile1 / 'solution.txt'/;

put outputfile1;

put 'Zielfunktionswert:  ',ZFW.l /

loop(i,
     loop(h,
             If (y.l(i,h) = 1.00,

             put i.tl:0, ' ; ' h.tl:0, ' ; ', y.l(i,h) /

            );
     );
);

putclose outputfile1;


file outputfile2 / 'solution2.txt'/;

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
