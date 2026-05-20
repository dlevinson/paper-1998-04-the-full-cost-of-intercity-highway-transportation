* FROM TIME SERIES DATA (1988)
* STATE YEAR HIGHWAY GSP TOTPUB PVTCAP AREA ROWAY TCAPO TMANT
* HIGHWAY - Highway Capital
* GSP - Gross State Product
* TOTPUB - Total Public Capital (incl. Highways)
* PVTCAP - Total Private Capital
* AREA - Area in Square Miles
* ROWAY - Right of Way Capital Outlay
* TCAPO - Total Capital Outlay
* TMANT - Total Maintenance
* FROM HIGHWAY STATISTICS 1993
* U - URBAN, R - RURAL, I - INTERSTATE, L - LOCAL, T - TOTAL, F -FREEWAY
* CAP - CAPITAL, MNT - MAINTENANCE
* MIL - MILES , gt4  greater than 4 lanes, le4 less than or equal to four
* PASSVEH - % Passenger Vehiles
* TRUSING - % Single Truck
* TRUCOMB - % Combination Truck
* VMT - Vehicle Miles Traveled
* ALASKA NEWYORK CALIFORN SOUTHEAST MIDWEST NORTHEAST - Dummies
* STADMH - State Administered Highways
* LADMRD - Locally Administered Roads
* FEDROAD - Federally Administered Roads

*DATA LIST FILE 'C:\HIGHWAYS\HIGHWAY3.TXT' FREE / STATE1 (A)
*   YEAR HIGHWAY GSP TOTPUB PVTCAP AREA ROWAY TCAPO TMANT
*   STATE2 (A)
*   CAPUI   CAPUL   CAPUT   MNTUI  MNTUL   MNTUT
*   CAPRI   CAPRL   CAPRT   MNTRI  MNTRL   MNTRT
*   CAPTI   CAPTL   CAPTT   MNTTI  MNTTL   MNTTT
*   MILRI   MILRL   MILRT   MILUI   MILUF   MILUL  MILUT
*   UMILgt4    UMILle4   RMILgt4  RMILle4
*   RPASSVEH   RTRUSING   RTRUCOM  UPASSVEH  UTRUSING   UTRUCOMB
*   ALASKA  NEWYORK     CALIFORN   SOUTHEAS   MIDWEST  NORTHEAS
*   VMTRI   VMTRL   VMTRT  VMTUI   VMTUF   VMTUL   VMTUT
*   CSTADMH   CLADMRD   CFEDROAD   CTAL
*   MSTADMH   MLADMRD   MREDROAD   MTAL
*   ADM_MISC    LAW_SAFE   INTEREST   BONDRET
*   TDISB   MILRISQ.

*save outfile='C:\HIGHWAYS\HIGHWAY3.X'.

get file='C:\HIGHWAYS\HIGHWAY3.X'.

select if (YEAR > 0).

* Interest Rate, assume 7%

compute IRATE=0.07.

compute TOTCAP=CAPRI+CAPRL+CAPUI+CAPUL.

compute MILRLSQ = MILRL * MILRL.

* HIGHINF = Inflator 1988 to 1993 (assume 20%)

compute HIGHINF = 1.2 * HIGHWAY.

compute CAPNEW = 1000*HIGHINF*IRATE.

compute TOTEXP = CAPNEW+MNTRI+MNTRL+MNTUI+MNTUL+ADM_MISC+LAW_SAFE.

compute LNTOTEXP=LN(TOTEXP).

compute LNVMTRI=LN(VMTRI).

compute LNVMTRL=LN(VMTRL).

compute LNVMTUI=LN(VMTUI+VMTUF).

compute LNVMTUL=LN(VMTUL).

compute LNMILRI=LN(MILRI).

compute LNMILRL=LN(MILRL).

compute LNMILUI=LN(MILUI+MILUF).

compute LNMILUL=LN(MILUL).

compute VMTTOT=VMTRI+VMTRL+VMTUI+VMTUL+VMTUF.

compute MILETOT=MILRI+MILRL+MILUI+MILUL+MILUF.

compute VCRI = (VMTRI/MILRI).

compute VCRL = (VMTRL/MILRL).

compute VCUI = ((VMTUI+VMTUF)/(MILUI+MILUF)).

compute VCUL = (VMTUL/MILUL).

compute LNVCRI = LN(VMTRI/MILRI).

compute LNVCRL = LN(VMTRL/MILRL).

compute LNVCUI = LN((VMTUI+VMTUF)/(MILUI+MILUF)).

compute LNVCUL = LN(VMTUL/MILUL).

compute LNRTRUC=LN((RTRUCOM/100)*(VMTRI+VMTRL)).

compute LNUTRUC=LN((UTRUCOMB/100)*(VMTUI+VMTUF+VMTUL)).

compute RTRUC=((RTRUCOM/100)*(VMTRI+VMTRL)).

compute UTRUC=((UTRUCOMB/100)*(VMTUI+VMTUF+VMTUL)).

compute RTRUS=((RTRUSING/100)*(VMTRI+VMTRL)).

compute UTRUS=((UTRUSING/100)*(VMTUI+VMTUF+VMTUL)).

compute RCAR=((RPASSVEH/100)*(VMTRI+VMTRL)).

compute UCAR=((UPASSVEH/100)*(VMTUI+VMTUF+VMTUL)).

compute lnrmgt4=LN(RMILGT4).

compute lnrmle4=LN(RMILLE4).

compute lnumgt4=LN(UMILGT4).

compute lnumle4=LN(UMILLE4).

compute miles = milri+milrl+milui+miluf+milul.

compute traffic= utruc+rtruc+utrus+rtrus+ucar+rcar.

compute purbmil= (milui+miluf+milul)/(milri+milrl+milui+miluf+milul).

compute purbtraf= (utruc+utrus+ucar)/(utruc+rtruc+utrus+rtrus+ucar+rcar).

compute urbtraf= (utruc+utrus+ucar).

compute ptruck= 1-(ucar+rcar)/(utruc+rtruc+utrus+rtrus+ucar+rcar).

compute truck= utruc+rtruc+utrus+rtrus.

compute miles2=miles*miles.

compute traffic2=traffic*traffic.
compute auto=ucar+rcar.
compute comb=utruc+rtrus.
compute sing=utrus+rtrus.
compute lntotexp=ln(totexp).
compute lnauto=ln(auto).
compute lncomb=ln(comb).
compute lnsing=ln(sing).
compute lnpurb=ln(purbtraf).
compute lnmiles=ln(miles).
compute iaa=lnauto*lnauto.
compute iac=lnauto*lncomb.
compute ias=lnauto*lnsing.
compute iap=lnauto*lnpurb.
compute iam=lnauto*lnmiles.
compute icc=lncomb*lncomb.
compute ics=lncomb*lnsing.
compute icp=lncomb*lnpurb.
compute icm=lncomb*lnmiles.
compute iss=lnsing*lnsing.
compute isp=lnsing*lnpurb.
compute ism=lnsing*lnmiles.
compute ipp=lnpurb*lnpurb.
compute ipm=lnpurb*lnmiles.
compute imm=lnmiles*lnmiles.

regression variables= lntotexp lnauto lncomb lnsing lnpurb lnmiles
   iaa iac ias iap iam icc ics icp icm iss isp ism ipp ipm imm
  /CRITERIA TOLERANCE (0.0000001)
  /dependent=lntotexp
  /method=enter.



regression variables= lntotexp lnauto lncomb lnsing lnpurb
   iaa iac ias iap icc ics icp iss isp ipp
  /CRITERIA TOLERANCE (0.0000001)
  /dependent=lntotexp
  /method=enter.


