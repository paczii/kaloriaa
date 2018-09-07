set i /
Fahrer1
Fahrer2
Fahrer3
Fahrer33
Kunde1
Kunde2
Kunde3
Kunde4
Kunde5
Kunde6
Kunde7
Kunde8
/

h /
Fahrer1
Fahrer2
Fahrer3
Fahrer33
/

p /
Nudeln
Salat
Eis
/
;

Parameter
  rw(h) /
Fahrer1   900.0
Fahrer2   900.0
Fahrer3   900.0
Fahrer33  900
/

Parameter
  kmmin(h) /
Fahrer1   0.5
Fahrer2   0.3
Fahrer3   0.5
Fahrer33  0.5
/



Parameter
  po(h,i) /
Fahrer1.Kunde1   0.0
Fahrer1.Kunde2   0.0
Fahrer1.Kunde3   0.0
Fahrer1.Kunde4   0.0
Fahrer1.Kunde5   0.0
Fahrer1.Kunde6   0.0
Fahrer1.Kunde7   0.0
Fahrer1.Kunde8   0.0
Fahrer2.Kunde1   0.0
Fahrer2.Kunde2   0.0
Fahrer2.Kunde3   0.0
Fahrer2.Kunde4   0.0
Fahrer2.Kunde5   0.0
Fahrer2.Kunde6   0.0
Fahrer2.Kunde7   0.0
Fahrer2.Kunde8   0.0
Fahrer3.Kunde1   1.0
Fahrer3.Kunde2   0.0
Fahrer3.Kunde3   1.0
Fahrer3.Kunde4   1.0
Fahrer3.Kunde5   1.0
Fahrer3.Kunde6   1.0
Fahrer3.Kunde7   1.0
Fahrer3.Kunde8   1.0
Fahrer33.Kunde1   0.0
Fahrer33.Kunde2   1.0
Fahrer33.Kunde3   1.0
Fahrer33.Kunde4   1.0
Fahrer33.Kunde5   1.0
Fahrer33.Kunde6   1.0
Fahrer33.Kunde7   1.0
Fahrer33.Kunde8   1.0
/



Parameter
  fahrerzahl /
4
/

Parameter
  dummyende /
4
/

Parameter
  kundenanfang /
5
/

Parameter tf(i)
/
Fahrer1 120
Fahrer2 120
Fahrer3 120
Fahrer33 120
Kunde1  120
Kunde2  120
Kunde3  120
Kunde4  120
Kunde5  120
Kunde6  120
Kunde7  120
Kunde8  120
/
;

Parameter ts(i)
/
Fahrer1 360
Fahrer2 360
Fahrer3 360
Fahrer33 360
Kunde1  360
Kunde2  360
Kunde3  360
Kunde4  360
Kunde5  360
Kunde6  360
Kunde7  360
Kunde8  360
/
;


Parameter
  d(i,p) /
Kunde1.Salat    1.0
Kunde2.Nudeln   1.0
Kunde3.Nudeln   1.0
Kunde4.Nudeln   1.0
Kunde5.Nudeln   1.0
Kunde6.Nudeln   1.0
Kunde7.Nudeln   2.0
Kunde8.Eis      1.0
/


Parameter
  s(i,p) /
Fahrer1.Nudeln    00.0
Fahrer2.Salat     90.0
Fahrer2.Nudeln    90.0
Fahrer2.Eis       90.0
Fahrer3.Nudeln    90.0
Fahrer3.Eis       90.0
Fahrer3.Salat     90.0
Fahrer33.Nudeln   90.0
Fahrer33.Eis      90.0
Fahrer33.Salat    90.0
/

Parameter
  fz(i,j) /
Fahrer3.Kunde4   7.0
Fahrer3.Kunde5   7.0
Fahrer3.Kunde6   1.0
Fahrer3.Kunde7   23.0
Fahrer33.Kunde4   7.0
Fahrer33.Kunde5   7.0
Fahrer33.Kunde6   40.0
Fahrer33.Kunde7   23.0
Fahrer33.Kunde8   13.0
Fahrer1.Kunde4   12.0
Fahrer1.Kunde5   13.0
Fahrer1.Kunde6   11.0
Fahrer1.Kunde7   28.0
Fahrer3.Kunde8   8.0
Fahrer1.Kunde8   6.0
Fahrer2.Kunde4   11.0
Fahrer2.Kunde5   12.0
Fahrer2.Kunde6   10.0
Fahrer2.Kunde7   11.0
Fahrer2.Kunde8   5.0
Fahrer2.Kunde1   1.0
Fahrer3.Kunde1   10.0
Fahrer33.Kunde1   10.0
Fahrer1.Kunde1   0.0
Fahrer2.Kunde2   0.0
Fahrer3.Kunde2   9.0
Fahrer33.Kunde2   9.0
Fahrer1.Kunde2   1.0
Fahrer2.Kunde3   10.0
Fahrer3.Kunde3   6.0
Fahrer33.Kunde3   6.0
Fahrer1.Kunde3   11.0
Kunde4.Kunde5   4.0
Kunde5.Kunde4   4.0
Kunde4.Kunde6   4.0
Kunde5.Kunde6   7.0
Kunde6.Kunde4   5.0
Kunde6.Kunde5   10.0
Kunde4.Kunde7   25.0
Kunde5.Kunde7   24.0
Kunde6.Kunde7   23.0
Kunde7.Kunde4   27.0
Kunde7.Kunde5   27.0
Kunde7.Kunde6   24.0
Kunde4.Kunde8   9.0
Kunde5.Kunde8   6.0
Kunde6.Kunde8   8.0
Kunde7.Kunde8   23.0
Kunde8.Kunde4   8.0
Kunde8.Kunde5   6.0
Kunde8.Kunde6   8.0
Kunde8.Kunde7   24.0
Kunde4.Kunde1   11.0
Kunde5.Kunde1   12.0
Kunde6.Kunde1   10.0
Kunde7.Kunde1   30.0
Kunde8.Kunde1   6.0
Kunde1.Kunde4   12.0
Kunde1.Kunde5   13.0
Kunde1.Kunde6   11.0
Kunde1.Kunde7   28.0
Kunde1.Kunde8   6.0
Kunde4.Kunde2   10.0
Kunde5.Kunde2   11.0
Kunde6.Kunde2   9.0
Kunde7.Kunde2   9.0
Kunde8.Kunde2   5.0
Kunde1.Kunde2   1.0
Kunde2.Kunde4   11.0
Kunde2.Kunde5   12.0
Kunde2.Kunde6   10.0
Kunde2.Kunde7   11.0
Kunde2.Kunde8   5.0
Kunde2.Kunde1   1.0
Kunde4.Kunde3   5.0
Kunde5.Kunde3   6.0
Kunde6.Kunde3   5.0
Kunde7.Kunde3   26.0
Kunde8.Kunde3   8.0
Kunde1.Kunde3   11.0
Kunde2.Kunde3   10.0
Kunde3.Kunde4   3.0
Kunde3.Kunde5   4.0
Kunde3.Kunde6   5.0
Kunde3.Kunde7   25.0
Kunde3.Kunde8   8.0
Kunde3.Kunde1   10.0
Kunde3.Kunde2   9.0
/  ;

*y.fx('Kunde1', 'Fahrer1')  =  1  ;
*y.fx('Kunde2', 'Fahrer1')  =  1  ;
*y.fx('Kunde3', 'Fahrer1')  =  1  ;
*y.fx('Kunde4', 'Fahrer1')  =  1  ;
*y.fx('Kunde5', 'Fahrer1')  =  1  ;
*y.fx('Kunde6', 'Fahrer1')  =  1  ;
*y.fx('Kunde7', 'Fahrer1')  =  1  ;
*y.fx('Kunde8', 'Fahrer1')  =  1  ;




*x.fx('Fahrer2', 'Kunde8', 'Fahrer2')  =  1  ;
*x.fx('Kunde8', 'Kunde1', 'Fahrer2')  =  1  ;
*x.fx('Fahrer3', 'Kunde4', 'Fahrer3')  =  1  ;
*x.fx('Kunde4', 'Kunde5', 'Fahrer3')  =  1  ;
*x.fx('Fahrer1', 'Kunde7', 'Fahrer1')  =  1  ;
