#!/bin/csh

#######################################################################
#2019-04-02 (R. Sasaki)
#2020-01-29 (R. Sasaki)
#
#MAXIスペクトル解析用ソフト
#ファイル名を入れてあげればfittingから画像生成まで自動でやってくれる
#単体で走らせて聞かれた情報を与えてやる
#
#A fitting model is just "apec
#The parameters of apec are kT and norm.
#The abundance was fixed to 0.3. (I did not find references of this value. However, this is general)
#
#
#######################################################################

#echo -n "FILE NAME (e.g. {NAME}.log) : "
#set NAME=$<

#cat ~/Dropbox/Public/MAXI_flare_ana/tools/dist.txt

#echo -n "DISTANCE of the star : "
#set DIST=$<

#echo ${1}  | awk '{sub("_.*", "");print $0;}'

#kT
set kT_1_KAKUNIN = `ls kT.txt`
if (${kT_1_KAKUNIN} !=  kT.txt) then
  touch kT.txt
endif

set kT_1_center = `ls kT_center.txt`
if (${kT_1_center} !=  kT_center.txt) then
  touch kT_center.txt
endif


#normalizatoin
set norm_KAKUNIN = `ls norm.txt`
if (${norm_KAKUNIN} !=  norm.txt) then
  touch norm.txt
endif


#EM em_e54.txt
set EM_KAKUNIN = `ls em_e54.txt`
if (${EM_KAKUNIN} !=  em_e54.txt) then
  touch em_e54.txt
endif

set EM_center = `ls em_e54_center.txt`
if (${EM_center} !=  em_e54_center.txt) then
  touch em_e54_center.txt
endif


#Flux
set flux_KAKUNIN = `ls flux.txt`
if (${flux_KAKUNIN} !=  flux.txt) then
  touch flux.txt
endif

#set flux_center = `ls flux_center.txt`
#if (${flux_center} !=  flux_center.txt) then
#  touch flux_center.txt
#endif


#Lx
set Lx_KAKUNIN = `ls lx_e31.txt`
if (${Lx_KAKUNIN} !=  lx_e31.txt) then
  touch lx_e31.txt
endif

set lx_e31_center = `ls lx_e31_center.txt`
if (${lx_e31_center} !=  lx_e31_center.txt) then
  touch lx_e31_center.txt
endif


#CHI-SQUARE関連
set CHI_KAKUNIN = `ls r_chi2.txt`
if (${CHI_KAKUNIN} !=  r_chi2.txt) then
  touch r_chi2.txt
endif

#Degree of freedom関連
set DOF_KAKUNIN = `ls dof.txt`
if (${DOF_KAKUNIN} !=  dof.txt) then
  touch dof.txt
endif



echo "===================================="
echo ${1}

set ST_NAME = `echo ${1}  | awk '{sub("_.*", "");print $0;}'`
set DATE = `echo ${1} | awk '{print substr($0, index($0, "2"))}' | awk '{sub("_1sigma.log.*", "");print $0;}'`


echo ${ST_NAME}

if (${ST_NAME} =~ HR1099) then
  set DIST = 29.62717167
else if (${ST_NAME} =~ IIPeg) then
  set DIST = 39.3629500169261
else if (${ST_NAME} =~ ARLac) then
  set DIST = 42.6744960142021
else if (${ST_NAME} =~ UXAri) then
  set DIST = 50.4721671234398
else if (${ST_NAME} =~ VYAri) then
  set DIST = 41.2999574610438
else if (${ST_NAME} =~ SZPsc) then
  set DIST = 90.1095732410611
else if (${ST_NAME} =~ GTMus) then
  set DIST = 109.593845209653
else if (${ST_NAME} =~ V841Cen) then
  set DIST = 95.5538780541408
else if (${ST_NAME} =~ IMPeg) then
  set DIST = 99.5064480178315
else if (${ST_NAME} =~ CFTuc) then
  set DIST = 87.9553890266857
else if (${ST_NAME} =~ SigmaGem) then
  set DIST = 37.0193500142525
else if (${ST_NAME} =~ V824Ara) then
  set DIST = 30.5063132815336
else if (${ST_NAME} =~ ARPsc) then
  set DIST = 45.9586280430357
else if (${ST_NAME} =~ HR5110) then
  set DIST = 46.1482373680737
else if (${ST_NAME} =~ TWA7) then
  set DIST = 34.0289995133853
else if (${ST_NAME} =~ HD347929) then
  set DIST = 240.217156309304
else if (${ST_NAME} =~ Algol) then
  set DIST = 27.571
else if (${ST_NAME} =~ EQPeg) then
  set DIST = 6.26135653541611
else if (${ST_NAME} =~ ATMic) then
  set DIST = 9.88159868456158
else if (${ST_NAME} =~ YZCMi) then
  set DIST = 5.98735709675449
else if (${ST_NAME} =~ FKAqr) then
  set DIST = 8.89941788907588
else if (${ST_NAME} =~ AUMic) then
  set DIST = 9.7248357718359
else if (${ST_NAME} =~ Wolf630) then
  set DIST = 6.195
else if (${ST_NAME} =~ UVCeti) then
  set DIST = 2.67594327000268
else if (${ST_NAME} =~ EVLac) then
  set DIST = 5.04948495253484
else if (${ST_NAME} =~ YYGem) then
  set DIST = 15.098373452228
else if (${ST_NAME} =~ CCEri) then
  set DIST = 11.5373122446649
else if (${ST_NAME} =~ FTPsc) then
  set DIST = 14.9681776543069
endif

echo ${DIST}


if (${ST_NAME} =~ IIPeg) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ HR1099) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ ARLac) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ UXAri) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ VYAri) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ SZPsc) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ GTMus) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ V841Cen) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ IMPeg) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ CFTuc) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ SigmaGem) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ V824Ara) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ ARPsc) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ BHCVn) then
  set TYPE = "RSCVn"
else if (${ST_NAME} =~ TWA7) then
  set TYPE = "YSOs"
else if (${ST_NAME} =~ HD347929) then
  set TYPE = "unknown"
else if (${ST_NAME} =~ Algol) then
  set TYPE = "Algol"
else if (${ST_NAME} =~ EQPeg) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ ATMic) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ YZCMi) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ FKAqr) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ AUMic) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ Wolf630) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ UVCeti) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ EVLac) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ YYGem) then
  set TYPE = "dMe"
else if (${ST_NAME} =~ CCEri) then
  set TYPE = "dKe"
else if (${ST_NAME} =~ FTPsc) then
  set TYPE = "dMe"
endif

echo ${TYPE}


#kT_1の抽出
set kT_1 = `grep "#   1    1   apec       kT         keV" ${1} | awk '{OFMT="%.3f"} {print $7*1}' | tail -1`
#echo ${kT_1}
#Error
#minus
#set kT_1_MIN = `grep "#     1" ${1} | sed -e 's/(/ /g' | sed -e 's/)/ /g' | sed -e 's/)/ /g' | sed -e 's/,/ /g' | awk '{OFMT="%.3f"} {print (($5)^2)^(0.5)}' | tail -1`
set kT_1_MIN = `grep "#     1" ${1} | awk '{OFMT="%.3f"} {print $3*1}' | tail -1`
#echo ${kT_1_MIN}
#plus
#set kT_1_PLUS = `grep "#     1" ${1} | sed -e 's/(/ /g' | sed -e 's/)/ /g' | sed -e 's/)/ /g' | sed -e 's/,/ /g' | awk '{OFMT="%.3f"} {print (($6)^2)^(0.5)}' |  tail -1`
set kT_1_PLUS = `grep "#     1" ${1} | awk '{OFMT="%.3f"} {print $4*1}' |  tail -1`
#echo ${kT_1_PLUS}
#書き出し（QDP style）

#if (${kT_1} =~ ${kT_1_MIN}) then
#  set kT_1_CALC = "NaN"
#else if (${kT_1} =~ ${kT_1_PLUS}) then
#  set kT_1_CALC = "NaN"
#endif


if (${kT_1_PLUS} != 0) then
  if (${kT_1_MIN} != 0) then
    if (${kT_1_PLUS} != ${kT_1}) then
      if (${kT_1_MIN} != ${kT_1}) then
        set kT_1_CALC = ${kT_1}
        echo "kT was derived!"
        echo ${ST_NAME} ${DATE} ${TYPE} ${kT_1_CALC} >> kT_center.txt
      endif
    endif
  endif
endif


if (${kT_1_PLUS} == 0) then
  if (${kT_1_MIN} == 0) then
    set kT_1_CALC = "NaN"
    set kT_1_PLUS = "NaN"
    set kT_1_MIN = "NaN"
    echo "kT was NOT derived"
    echo ${ST_NAME} ${DATE} ${TYPE} ${kT_1_CALC} >> kT_center.txt
  endif
endif

if (${kT_1_PLUS} == ${kT_1}) then
  set kT_1_CALC = "${kT_1_MIN}<"
  set kT_1_MIN = "NaN"
  set kT_1_PLUS = "NaN"
  echo "kT lower limit"
  echo ${ST_NAME} ${DATE} ${TYPE} ${kT_1_MIN} >> kT_center.txt
endif

if (${kT_1_MIN} != 0) then
  if (${kT_1_PLUS} == 0) then
    set kT_1_CALC = "${kT_1_MIN}<"
    set kT_1_MIN = "NaN"
    set kT_1_PLUS = "NaN"
    echo "kT lower limit"
    echo ${ST_NAME} ${DATE} ${TYPE} ${kT_1_MIN} >> kT_center.txt
  endif
else if (${kT_1_PLUS} != 0) then
  if (${kT_1_MIN} == 0) then
    set kT_1_CALC = "<${kT_1_PLUS}"
    set kT_1_PLUS = "NaN"
    set kT_1_MIN = "NaN"
    echo "kT upper limit"
    echo ${ST_NAME} ${DATE} ${TYPE} ${kT_1_PLUS} >> kT_center.txt
  endif
endif

echo "kT       : C = ${kT_1_CALC}, PLUS = ${kT_1_PLUS}, MIN = ${kT_1_MIN}"


#if (${kT_1_PLUS} != 0) then
#  if (${kT_1_MIN} != 0) then
#    set kT_1_CALC = ${kT_1}
#  endif
#endif
#
#
#if (${kT_1_PLUS} == 0) then
#  if (${kT_1_MIN} == 0) then
#    set kT_1_CALC = "NaN"
#    set kT_1_PLUS = "NaN"
#    set kT_1_MIN = "NaN"
#  endif
#endif
#

#if (${kT_1_MIN} != 0) then
#  if (${kT_1_PLUS} == 0) then
#    set kT_1_CALC = "${kT_1_MIN}<"
#    set kT_1_MIN = "NaN"
#    set kT_1_PLUS = "NaN"
#  endif
#else if (${kT_1_PLUS} != 0) then
#  if (${kT_1_MIN} == 0) then
#    set kT_1_CALC = "<${kT_1_PLUS}"
#    set kT_1_PLUS = "NaN"
#    set kT_1_MIN = "NaN"
#  endif
#endif




echo ${ST_NAME} ${DATE} ${TYPE} ${kT_1_CALC} ${kT_1_PLUS} ${kT_1_MIN} >> kT.txt


#norm_1の抽出
#set EM_1 = `grep "#   4    1   apec       norm " ${1} | awk '{OFMT="%.3f"} {print $6*1.196497*0.01*('${DIST}')^2}' | tail -1`
set norm_1 = `grep "#   4    1   apec       norm " ${1} | awk '{OFMT="%.3f"} {print $6*1}' | tail -1`
set EM = `echo ${norm_1} | awk '{print $1*1.196497*0.01*('${DIST}')^(2)}'`
#echo ${norm_1}
#Error
#minus
#set norm_1_MIN = `grep "#     4" ${1} | sed -e 's/(/ /g' | sed -e 's/)/ /g' | sed -e 's/)/ /g' | sed -e 's/,/ /g' | awk '{OFMT="%.3f"} {print (($5)^2)^(0.5)}' | tail -1`
set norm_1_MIN = `grep "#     4" ${1} | awk '{OFMT="%.3f"} {print $3*1}' | tail -1`
set EM_MIN = `echo ${norm_1_MIN} | awk '{print $1*1.196497*0.01*('${DIST}')^(2)}'`
#echo ${norm_1_MIN}
#plus
set norm_1_PLUS = `grep "#     4" ${1} | awk '{OFMT="%.3f"} {print $4*1}' |  tail -1`
set EM_PLUS = `echo ${norm_1_PLUS} | awk '{print $1*1.196497*0.01*('${DIST}')^(2)}'`
#echo ${norm_1_PLUS}
#書き出し（QDP style）



if (${norm_1_PLUS} != 0) then
  if (${norm_1_MIN} != 0) then
    if (${norm_1_PLUS} != ${norm_1}) then
      if (${norm_1_MIN} != ${norm_1}) then
        set norm_1_CALC = ${norm_1}
        set EM_CALC = ${EM}
        echo "EM was detived!"
        echo ${ST_NAME} ${DATE} ${TYPE} ${EM_CALC} >> em_e54_center.txt
      endif
    endif
  endif
endif


if (${norm_1_PLUS} == 0) then
  if (${norm_1_MIN} == 0) then
    set norm_1_CALC = "NaN"
    set norm_1_PLUS = "NaN"
    set norm_1_MIN = "NaN"
    set EM_CALC = "NaN"
    set EM_PLUS = "NaN"
    set EM_MIN = "NaN"
    echo "EM was NOT detived"
    echo ${ST_NAME} ${DATE} ${TYPE} ${EM_CALC} >> em_e54_center.txt
  endif
endif

if (${norm_1_PLUS} == ${norm_1}) then
  set norm_1_CALC = "${norm_1_MIN}<"
  set norm_1_MIN = "NaN"
  set norm_1_PLUS = "NaN"
  set EM_CALC = "${EM_MIN}<"
  set EM_MIN = "NaN"
  set EM_PLUS = "NaN"
  echo "EM lower limit 1"
  echo ${ST_NAME} ${DATE} ${TYPE} ${EM_MIN} >> em_e54_center.txt
endif

if (${norm_1_MIN} != 0) then
  if (${norm_1_PLUS} == 0) then
    set norm_1_CALC = "${norm_1_MIN}<"
    set norm_1_MIN = "NaN"
    set norm_1_PLUS = "NaN"
    set EM_CALC = "${EM_MIN}<"
    set EM_MIN = "NaN"
    set EM_PLUS = "NaN"
    echo "EM lower limit 2"
    echo ${ST_NAME} ${DATE} ${TYPE} ${EM_MIN} >> em_e54_center.txt
  endif
else if (${norm_1_PLUS} != 0) then
  if (${norm_1_MIN} == 0) then
    set norm_1_CALC = "<${norm_1_PLUS}"
    set norm_1_PLUS = "NaN"
    set norm_1_MIN = "NaN"
    set EM_CALC = "<${EM_PLUS}"
    set EM_PLUS = "NaN"
    set EM_MIN = "NaN"
    echo "EM upper limit"
    echo ${ST_NAME} ${DATE} ${TYPE} ${EM_PLUS} >> em_e54_center.txt
  endif
endif

echo "norm     : C = ${norm_1_CALC}, PLUS = ${norm_1_PLUS}, MIN = ${norm_1_MIN}"
echo "EMe+54   : C = ${EM_CALC}, PLUS = ${EM_PLUS}, MIN = ${EM_MIN}"


echo ${ST_NAME} ${DATE} ${TYPE} ${norm_1_CALC} ${norm_1_PLUS} ${norm_1_MIN} >> norm.txt
###
#EM_1の計算
#awk '{OFMT="%.3f"} {print $1, $2, $3, $4*1.196497*0.01*('${DIST}')^(2), $5*1.196497*0.01*('${DIST}')^(2), $6*1.196497*0.01*('${DIST}')^(2)}' norm_1.txt > em_e54.txt
echo ${ST_NAME} ${DATE} ${TYPE} ${EM_CALC} ${EM_PLUS} ${EM_MIN} >> em_e54.txt




#fluxの抽出
set flux = `grep "(2.0000 - 20.000 keV)" ${1} | tail -1 | sed 's/(//g' | awk '{OFMT="%.3f"} {print $6*1e+10}'`
#set flux_calc = `echo ${flux} | awk '{OFMT="%.3f"} {print $1*1e+10}'`
set Lx = `echo ${flux} | awk '{OFMT="%.3f"} {print ($1)*1.196497*('${DIST}')^2*0.001}'`
#echo "center : ${flux} -> ${Lx}"
#echo ${flux}
#Error
#minus
set flux_MIN = `grep -A 1 "(2.0000 - 20.000 keV)" ${1} | tail -1 | sed 's/(//g' | awk '{OFMT="%.3f"} {print $7*1e+10}'`
set Lx_MIN = `echo ${flux_MIN} | awk '{OFMT="%.3f"} {print ($1)*1.196497*('${DIST}')^2*0.001}'`
#echo "min_error : ${flux_MIN} -> ${Lx_MIN}"
#echo ${flux_min_pre}
#set flux_min = `echo ${flux} ${flux_min_pre} | awk '{OFMT="%.3f"} {print $2*1e+10 - $1*1e+10}'`
#set flux_MIN_pre = `grep -A 1 "(2.0000 - 20.000 keV)" ${1} | tail -1 | sed 's/(//g' | awk '{OFMT="%.3f"} {print $7}'`
#set flux_MIN = `echo ${flux} ${flux_MIN_pre} | awk '{OFMT="%.3f"} {print $2*1e+10 - $1*1e+10}'`
#echo ${flux_MIN}
#plus
set flux_PLUS = `grep -A 1 "(2.0000 - 20.000 keV)" ${1}| tail -1 | sed 's/(//g' | sed 's/)//g' | awk '{OFMT="%.3f"} {print $9*1e+10}'`
set Lx_PLUS = `echo ${flux_PLUS} | awk '{OFMT="%.3f"} {print ($1)*1.196497*('${DIST}')^2*0.001}'`
#echo "plus_errpr : ${flux_PLUS} -> ${Lx_PLUS}"
#echo ${flux_plus_pre}
#set flux_plus = `echo ${flux} ${flux_plus_pre} | awk '{OFMT="%.3f"} {print $2*1e+10 - $1*1e+10}'`
#set flux_plus_pre = `grep -A 1 "(2.0000 - 20.000 keV)" ${1}| tail -1 | sed 's/(//g' | sed 's/)//g' | awk '{OFMT="%.3f"} {print $9}'`
#set flux_plus = `echo ${flux} ${flux_PLUS_pre} | awk '{OFMT="%.3f"} {print $2*1e+10 - $1*1e+10}'`
#echo ${flux_PLUS}
#書き出し（QDP style）

if (${norm_1_PLUS} != 0) then
  if (${flux_MIN} != 0) then
    if (${flux_PLUS} != ${flux}) then
      if (${flux_MIN} != ${flux}) then
        set flux_CALC = ${flux}
        set Lx_CALC = ${Lx}
        echo "Flux was detived!"
        echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_CALC} >> lx_e31_center.txt
      endif
    endif
  endif
endif



if (${flux_PLUS} == 0) then
  if (${flux_MIN} == 0) then
    set flux_CALC = "NaN"
    set flux_PLUS = "NaN"
    set flux_MIN = "NaN"
    set Lx_CALC = "NaN"
    set Lx_PLUS = "NaN"
    set Lx_MIN = "NaN"
    echo "Flux was NOT detived!"
    echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_CALC} >> lx_e31_center.txt
  endif
endif


if (${flux_PLUS} == ${flux}) then
  set flux_CALC = "${flux_MIN}<"
  set flux_MIN = "NaN"
  set flux_PLUS = "NaN"
  set Lx_CALC = "${Lx_MIN}<"
  set Lx_MIN = "NaN"
  set Lx_PLUS = "NaN"
  echo "Flux lower limit"
  echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_MIN} >> lx_e31_center.txt
endif


if (${flux_MIN} == ${flux}) then
  set flux_CALC = "<${flux_PLUS}"
  set flux_PLUS = "NaN"
  set flux_MIN = "NaN"
  set Lx_CALC = "<${Lx_PLUS}"
  set Lx_PLUS = "NaN"
  set Lx_MIN = "NaN"
  echo "Flux upper limit"
  echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_PLUS} >> lx_e31_center.txt
endif



if (${flux_MIN} != 0) then
  if (${flux_PLUS} == 0) then
    set flux_CALC = "${flux_MIN}<"
    set flux_MIN = "NaN"
    set flux_PLUS = "NaN"
    set Lx_CALC = "${Lx_MIN}<"
    set Lx_MIN = "NaN"
    set Lx_PLUS = "NaN"
    echo "Flux lower limit"
    echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_MIN} >> lx_e31_center.txt
  endif
else if (${flux_PLUS} != 0) then
  if (${flux_MIN} == 0) then
    set flux_CALC = "<${flux_PLUS}"
    set flux_PLUS = "NaN"
    set flux_MIN = "NaN"
    set Lx_CALC = "<${Lx_PLUS}"
    set Lx_PLUS = "NaN"
    set Lx_MIN = "NaN"
    echo "Flux upper limit"
    echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_PLUS} >> lx_e31_center.txt
  endif
endif

echo "Fluxe-10 : C = ${flux_CALC}, PLUS = ${flux_PLUS}, MIN = ${flux_MIN}"
echo "Lxe+31   : C = ${Lx_CALC}, PLUS = ${Lx_PLUS}, MIN = ${Lx_MIN}"

echo ${ST_NAME} ${DATE} ${TYPE} ${flux_CALC} ${flux_PLUS} ${flux_MIN} >> flux.txt
echo ${ST_NAME} ${DATE} ${TYPE} ${Lx_CALC} ${Lx_PLUS} ${Lx_MIN} >> lx_e31.txt

#echo ${ST_NAME} ${DATE} ${TYPE} $flux_calc $flux_plus $flux_min >> flux.txt

#Lx
#awk '{OFMT="%.3f"}{print $1, $2, $3, $4*1.196497*('${DIST}')^2*0.001, $5*1.196497*('${DIST}')^2*0.001, $6*1.196497*('${DIST}')^2*0.001}' flux.txt > lx_e31.txt



#Reduced Chi-squaredの抽出

set CHI = `grep "Reduced chi-squared" ${1} | tail -1 | awk '{OFMT="%.3f"} {print $5}'`
#echo ${CHI}
echo "r-chi^2  : ${CHI}"
echo ${ST_NAME} ${DATE} ${TYPE} ${CHI} >> r_chi2.txt



#Degree of freedomの抽出
set DOF = `grep "Reduced chi-squared" ${1} | tail -1 | awk '{OFMT="%.3f"} {print $7}'`
#echo ${DOF}
echo "d.o.f.   : ${DOF}"
echo ${ST_NAME} ${DATE} ${TYPE} ${DOF} >> dof.txt


echo "===================================="
