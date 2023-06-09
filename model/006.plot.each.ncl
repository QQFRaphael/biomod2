load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/calendar_decode2.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$GEODIAG_ROOT/geodiag.ncl"

path = "ncOutput/"
scene = "ens-ssp585-2081-2100"

f = addfile(path+scene+"-ROC.nc", "r")

data = f->Band1

data = where(isnan_ieee(data),data@_FillValue,data)

wks = gsn_open_wks("eps",scene)         

res                     = True  

res@gsnDraw=False
res@gsnFrame=False

res@gsnAddCyclic = False        
res@gsnMaximize = True   
res@cnFillOn            = True             
res@cnFillMode          = "RasterFill"     
res@cnLinesOn           = False           

res@cnLevelSelectionMode = "ExplicitLevels"    
res@cnLevels=(/200,400,600/)
res@cnFillColors=(/"white","orange","chartreuse","cornflowerblue"/)

res@isShowProvince = True
res@isShowSouthChinaSea = False
res@isShowRivers = True
res@riverColor = "blue"
res@riverThickness = 0.9
res@provinceColor="black"
res@provinceThickness=2.2
setup_china_map(res)

res@mpFillOn = True
res@mpLandFillColor   = "white"
res@mpPerimOn = False
res@mpOutlineOn = False

res@mpGridAndLimbOn     = True
res@mpGridSpacingF         = 5
res@mpGridLineThicknessF   = 2.0
res@mpGridLineColor        = "Gray30"
res@mpGridLineDashPattern       = 2
res@tmXTLabelsOn=False
res@tmYRLabelsOn=False
res@tmYLLabelFontHeightF = 0.025
res@tmXBLabelFontHeightF = 0.025

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
res@lbLabelBarOn = False
res@cnLineLabelsOn = False

plot = gsn_csm_contour_map(wks, data, res)
attach_china_map(wks, plot)

draw(plot)
frame(wks)
