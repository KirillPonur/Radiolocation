load('Latitude.mat')
load('Longitude.mat')
% load('nMap.mat')
load('nMapLoc.mat')
load('cmap.mat')
[A,R] = geotiffread('image-download.tif');
geoshow(A,R)
hold on
 h=geoshow(Latitude,Longitude,nMap,cmap);
% h=geoshow(Latitude,Longitude,nMapLoc,cmap);
set(h,'FaceAlpha',0.5)


