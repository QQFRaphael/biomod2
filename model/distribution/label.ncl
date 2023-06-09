load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

f = addfile("elev.nc", "r")

data = f->Band1

ff = asciiread("samples.csv", (/177,2/), "float")
lon = ff(:,0)
lat = ff(:,1)

wks = gsn_open_wks("eps","label")   
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
;res@cnLevels=(/200,400,600/)
;res@cnFillColors=(/"green4","yellow2","orange","red"/)

res@isShowProvince = True
res@isShowSouthChinaSea = True
res@isShowRivers = False
res@provinceColor="black"
res@provinceThickness=2.2
setup_china_map(res)

res@mpFillOn = True
res@mpLandFillColor   = "white"
res@mpPerimOn = False
res@mpOutlineOn = False

res@mpGridAndLimbOn     = False
res@tmYLLabelFontHeightF = 0.001
res@tmXBLabelFontHeightF = 0.001

res@mpProjection = "LambertConformal"
res@mpCenterLonF =        110
res@mpCenterLatF =        30
res@mpLambertParallel1F = 30
res@mpLambertParallel2F = 60
res@mpLambertMeridianF =  110
res@mpLimitMode="LatLon"
res@mpMinLatF              =  17
res@mpMaxLatF              =  53
res@mpMinLonF              =  82
res@mpMaxLonF              = 127

res@pmTickMarkDisplayMode="Always"

res@gsnLeftString = ""
res@gsnRightString = ""
res@lbLabelBarOn = True
res@lbLabelFontHeightF = 0.02
res@cnLineLabelsOn = False

plot = gsn_csm_contour_map(wks, data, res)

mkres               = True
mkres@gsMarkerIndex = 1
mkres@gsMarkerColor = "red"
mkres@gsMarkerSizeF = 0.02

dum = gsn_add_polymarker(wks,plot,lon,lat,mkres)

attach_china_map(wks, plot)

draw(plot)
frame(wks)
