clear all
for j=2:1000
c(j,:)=wcol(1,1050,j);
end
scatter(1:1000,1:1000,5,c)