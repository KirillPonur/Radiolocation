function f = wcol(xmin,xmax, x)

d = xmax - xmin;
dd = d/4+0.00001;

if (x>=xmin) && (x<xmin+dd)
    xx = x - xmin;
    B= 255;
    R = 0;
    G = 255*xx/dd;
end
if (x>=xmin+dd) && (x<xmin+2*dd)
    xx = x - xmin - dd;
    B = (dd - xx)*255/dd;
    G = 255;
    R = 0;
end
if (x>=xmin+2*dd) && (x<xmin+3*dd)
    xx = x - xmin - 2*dd;
    B = 0;
    G = 255;
    R = 255*xx/dd;
end
if (x>=xmin+3*dd) && (x<=xmin+4*dd)
    xx = x - xmin - 3*dd;
    B = 0;
    G = (dd - xx)*255/dd;
    R = 255;
end
f = [R/255 G/255 B/255];
