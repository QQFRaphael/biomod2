load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

f = addfile("elev.nc", "r")

data = f->Band1

ff = asciiread("rev_r.csv", (/31,2/), "float")
lon = ff(:,0)
lat = ff(:,1)

wks = gsn_open_wks("eps","rev")   
gsn_define_colormap(wks, "cmp_b2r")      

res                     = True  

res@gsnDraw=False
res@gsnFrame=False

res@gsnAddCyclic = False        
res@gsnMaximize = True   
res@cnFillOn            = True             
res@cnFillMode          = "RasterFill"     
res@cnLinesOn           = False           

;res@cnLevelSelectionMode = "ExplicitLevels"    
;res@cnLevels=ispan(100,3000,100)    ;(/200,400,600/)
;res@cnFillColors=(/"green4","yellow2","orange","red"/)

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isShowRivers = False
res@provinceColor="black"
res@provinceThickness=2.2
setup_china_map(res)

res@mpFillOn = True
res@mpLandFillColor   = "white"
res@mpPerimOn = False
res@mpOutlineOn = False

res@mpGridAndLimbOn     = False
res@tmYLLabelFontHeightF = 0.025
res@tmXBLabelFontHeightF = 0.025

res@mpLimitMode="LatLon"
res@mpMaxLatF=35.0
res@mpMinLatF=22.0
res@mpMinLonF=104.0
res@mpMaxLonF=122.0

res@gsnLeftString = ""
res@gsnRightString = ""
res@lbLabelBarOn = False
res@cnLineLabelsOn = False

plot = gsn_csm_contour_map(wks, data, res)

mkres               = True
mkres@gsMarkerIndex = 1
mkres@gsMarkerColor = "red"
mkres@gsMarkerSizeF = 0.04

dum = gsn_add_polymarker(wks,plot,lon,lat,mkres)




fff = addfile("ens-ssp585-2081-2100.nc","r")
rev = fff->Band1

rv                     = True  

rv@gsnDraw=False
rv@gsnFrame=False

rv@gsnAddCyclic = False        
;rv@gsnMaximize = True   
rv@cnFillOn            = True
rv@cnLinesOn           = False           
;rv@cnFillMode          = "RasterFill"     
rv@cnMonoFillPattern=False
rv@cnMonoFillColor=True

rv@cnLevelSelectionMode="ExplicitLevels"
rv@cnLevels=(/0.9999/)
rv@lbLabelBarOn=False
rv@cnInfoLabelOn=False
rv@cnLineLabelsOn = False

rv@cnFillPatterns=(/-1,14/)
;rv@cnFillScaleF = 0.2

rv@gsnLeftString = ""
rv@gsnRightString = ""

resv = gsn_csm_contour(wks, rev, rv)

overlay(plot, resv)


attach_china_map(wks, plot)

draw(plot)
frame(wks)
