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
* lane miles in lane miles
* PASSVEH - % Passenger Vehiles
* TRUSING - % Single Truck
* TRUCOMB - % Combination Truck
* VMT - Vehicle Miles Traveled (annual, millions)
* ALASKA NEWYORK CALIFORN SOUTHEAST MIDWEST NORTHEAST - Dummies
* STADMH - State Administered Highways
* LADMRD - Locally Administered Roads
* FEDROAD - Federally Administered Roads
* PGSAL93 - State Government Salaries
* PBITCON - Price Bituminous Concrete
* PRESTL - Price Reinforcing Steel
* PSTSTL - Price Structural Steel
* PSTCON - Price Structural Concrete
* POP90 - 1990 Population (thsd)
* AREA - Area in Sq. Miles
* POPDENS = POP90*1000/AREA
* BONDRATE = Rating of Moody's 1994, p307 1995 Stat Abstract of US
*"AL" 1988 8905.74 53547 20204.46 66008.17 52423 41714000 4.70E+08 3.42E+08 125348 77005 202353 7008 87510 94518 29484 238395 267879 7412 55938 63350 154832 315400 470232 14420 143448 157868 602 72226 72828 297 21 19063 19381 92209 43 254 0 602 56

*DATA LIST FILE 'C:\HIGHWAYS\HIGHWAY5.TXT' FREE / STATE (A4) YEAR
*   HIGHWAY GSP TOTPUB PVTCAP AREA ROWAY TCAPO TMANT
*   CAPUI   CAPUL   CAPUT   MNTUI  MNTUL   MNTUT
*   CAPRI   CAPRL   CAPRT   MNTRI  MNTRL   MNTRT
*   CAPTI   CAPTL   CAPTT   MNTTI  MNTTL   MNTTT
*   MILRI   MILRL   MILRT   MILUI   MILUF   MILUL  MILUT MILTT
*   UMILgt4    UMILle4   RMILgt4  RMILle4
*   RPASSVEH RTRUSING   RTRUCOM  UPASSVEH  UTRUSING   UTRUCOMB
*   ALASKA  NEWYORK     CALIFORN   SOUTHEAS   MIDWEST  NORTHEAS
*   VMTRI   VMTRL   VMTRT  VMTUI   VMTUF   VMTUL   VMTUT
*   CSTADMH   CLADMRD   CFEDROAD   CTAL
*   MSTADMH   MLADMRD   MREDROAD   MTAL
*   ADM_MISC    LAW_SAFE   INTEREST   BONDRET
*   TDISB
*   PGSAL93 PGSAL94 PBCON93 PEXCAV93 PRESTL93 PSTSTL93
*   PSTCON93 POP90 SQMILES POPDENS BONDRATE (A4).

*save outfile='C:\HIGHWAYS\HIGHWAY5.X'.

get file='C:\HIGHWAYS\HIGHWAY5.X'.

select if (YEAR > 0).

compute irate = 0.07.

if ( BONDRATE = '   X' ) IRATE = 0.0555.
if ( BONDRATE = ' AAA' ) IRATE = 0.0475.
if ( BONDRATE = ' AA1' ) IRATE = 0.0495.
if ( BONDRATE = '  AA' ) IRATE = 0.0515.
if ( BONDRATE = '  A1' ) IRATE = 0.0535.
if ( BONDRATE = '   A' ) IRATE = 0.0555.
if ( BONDRATE = 'BBA1' ) IRATE = 0.0575.
if ( BONDRATE = ' BBB' ) IRATE = 0.0595.

compute x = 1.

* Interest Rate, assume = bondrate

* means variables=IRATE by x.

compute TOTCAP=CAPRI+CAPRL+CAPUI+CAPUL.
compute MILRLSQ = MILRL * MILRL.
compute MILRISQ = MILRI * MILRI.

* HIGHINF = Inflator 1988 to 1993 (assume 20%)

select if (MNTRI > 0 and MNTRL > 0 and MNTUI > 0 and MNTUL > 0).
select if (ADM_MISC > 0 and LAW_SAFE > 0 and HIGHWAY > 0).

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
compute ORTRUC=1/((RTRUCOM/100)*(VMTRI+VMTRL)).
compute RTRUC2=((RTRUCOM/100)*(VMTRI+VMTRL))**2.

compute UTRUC=((UTRUCOMB/100)*(VMTUI+VMTUF+VMTUL)).
compute OUTRUC=1/((UTRUCOMB/100)*(VMTUI+VMTUF+VMTUL)).
compute UTRUC2=((UTRUCOMB/100)*(VMTUI+VMTUF+VMTUL))**2.

compute RTRUS=((RTRUSING/100)*(VMTRI+VMTRL)).
compute ORTRUS=1/((RTRUSING/100)*(VMTRI+VMTRL)).
compute RTRUS2=((RTRUSING/100)*(VMTRI+VMTRL))**2.

compute UTRUS=((UTRUSING/100)*(VMTUI+VMTUF+VMTUL)).
compute OUTRUS=((UTRUSING/100)*(VMTUI+VMTUF+VMTUL)).
compute UTRUS2=((UTRUSING/100)*(VMTUI+VMTUF+VMTUL))**2.

compute RCAR=((RPASSVEH/100)*(VMTRI+VMTRL)).
compute ORCAR=((RPASSVEH/100)*(VMTRI+VMTRL)).
compute RCAR2=((RPASSVEH/100)*(VMTRI+VMTRL))**2.

compute UCAR=((UPASSVEH/100)*(VMTUI+VMTUF+VMTUL)).
compute OUCAR=((UPASSVEH/100)*(VMTUI+VMTUF+VMTUL)).
compute UCAR2=((UPASSVEH/100)*(VMTUI+VMTUF+VMTUL))**2.

compute lnrmgt4=LN(RMILGT4).
compute lnrmle4=LN(RMILLE4).
compute lnumgt4=LN(UMILGT4).
compute lnumle4=LN(UMILLE4).
compute lnmigt4=ln(rmilgt4+umilgt4).
compute lnmile4=ln(rmille4+umille4).
compute miles = milri+milrl+milui+miluf+milul.
compute traffic= utruc+rtruc+utrus+rtrus+ucar+rcar.
compute purbmil= (milui+miluf+milul)/(milri+milrl+milui+miluf+milul).
compute umiles=milui+miluf+milul.
compute rmiles=milri+milrl.
compute mill=milrl+milul.
compute lnmill =ln(mill).
compute mili4=umille4+rmille4.
compute mili5=umilgt4+rmilgt4.
compute lnmili4=ln(mili4).
compute lnmili5=ln(mili5).
compute pfwy=(milui+miluf+milri)/(umiles+rmiles).
compute lnpfwy=ln(pfwy).
compute uwidth=(umille4*3+umilgt4*6)/(umille4+umilgt4).
compute rwidth=(rmille4*3+rmilgt4*6)/(rmille4+rmilgt4).
compute width=((umille4+rmille4)*4+milul*3+milrl*2+(rmilgt4+umilgt4)*7)/
    (umille4+umilgt4+rmilgt4+rmille4+milul+milrl).
compute lnuwidth=ln(uwidth).
compute lnrwidth=ln(rwidth).
compute purbtraf= (utruc+utrus+ucar)/(utruc+rtruc+utrus+rtrus+ucar+rcar).
compute urbtraf= (utruc+utrus+ucar).
compute rurtraf= (rtruc+rtrus+rcar).

compute ptruck= 1-(ucar+rcar)/(utruc+rtruc+utrus+rtrus+ucar+rcar).
compute truck= utruc+rtruc+utrus+rtrus.
compute urbtruck=utruc+utrus.
compute rurtruck=rtruc+rtrus.
compute miles2=miles*miles.
compute traffic2=traffic*traffic.

compute rvc=(rurtraf*1000000/(365*24))/(rmille4*4*2000+rmilgt4*8*2000).
compute uvc=(urbtraf*1000000/(365*24))/(umille4*4*2000+rmilgt4*8*2000).


compute auto=ucar+rcar.
compute comb=utruc+rtruc.
compute sing=utrus+rtrus.
compute lnumiles=ln(umiles).
compute lnrmiles=ln(rmiles).
compute lntotexp=ln(totexp).
compute lnauto=ln(auto).
compute lncomb=ln(comb).
compute lnsing=ln(sing).
compute lnpurbm=ln(purbmil).
compute lnmiles=ln(miles).

compute x=1.

*means variables= PGSAL93 PGSAL94 PBCON93 PEXCAV93 PRESTL93 PSTSTL93
*   PSTCON93 POPDENS by x.

* means computed for 41 cases passing selects.

compute mgsal93=26441.
comptue mgsal94=27117.
compute mbcon93=25.9261.
compute mexcav93=3.0039.
compute mrestl93=0.5074.
compute mststl93=0.8809.
compute mstcon93=266.311.
compute mpopdens=142.64.



compute pexcav=pexcav93/mexcav93.
compute psurf=pbcon93/mbcon93.
compute pstruc=pststl93/mststl93+pstcon93/mstcon93+prestl93/mrestl93.
compute pdens=popdens/mpopdens.
compute plabor=pgsal93/mgsal93.
compute pconst=pexcav+psurf+pstruc.


compute lnPEXCAV=ln(PEXCAV).
compute lnPSURF=ln(PSURF).
compute lnPLABOR=ln(PLABOR).
compute lnPSTRUC=ln(PSTRUC).
compute lnPDENS=ln(PDENS).
compute lnPCONST=ln(PCONST).

compute PKAP = capnew/miles.
compute lnPKAP=ln(PKAP).
compute lnirate=ln(irate).
compute lnwidth=ln(width).
compute pgt4=(rmilgt4+umilgt4)/(rmilgt4+rmille4+umilgt4+umille4).
compute lnpgt4=ln(pgt4).
compute mpsqm=miles/area.
compute lnmpsqm=ln(mpsqm).
compute varexp=totexp-capnew.
compute lnvarexp=ln(varexp).
compute lntotexp=ln(totexp).

compute h=(auto*auto+sing*sing+comb*comb)/((auto+sing+comb)*(auto+sing+comb)).
compute lnh=ln(h).
select if (auto > 0 and comb > 0 and sing > 0 and totexp > 0 and pdens>0).
select if (plabor > 0 and pexcav > 0 and psurf > 0 and pstruc>0).

compute vmt=auto+comb+sing.
compute lnvmt=ln(vmt).
compute lnmiles2=ln(miles2).

regression variables=lntotexp lnauto lncomb lnsing lnplabor lnirate lnmiles
  /dependent=lntotexp
  /method=enter.



