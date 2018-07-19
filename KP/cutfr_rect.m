 function k1=cutfr_rect(LaKu,LoKu,La01,Lo01,La02,Lo02,boo1,boo2,d21,d22,j11,j22,bnum,day,month,god,orbit,Lsw,nb,sizeKu,IncAngleKu,sigmaKu,preciprateKu,secofdayKu);
 k1=1;
 
for ib=1:nb       
    R= deg2km(distance(La01(ib),Lo01(ib),La02(ib),Lo02(ib)))*0.5; 
    if ~(boo2(ib) || boo1(ib))
        if (d22(ib)<Lsw && d21(ib)<Lsw)|| (d22(ib)>Lsw && d21(ib)<R) || (d22(ib)<R && d21(ib)>Lsw)    
            jav=floor((j11(ib)+j22(ib))/2);

            jstku = jav-floor(R/5)-4;
            jfinku = jav+floor(R/5)+4;

            % cut Ku
            k = 1;
            for i1 = 1:sizeKu(1)
              for j1 = jstku:jfinku                       
                 if LaKu(i1,j1)<=La02(ib) &&  LaKu(i1,j1)>=La01(ib) &&  LoKu(i1,j1)<=Lo02(ib) &&  LoKu(i1,j1)>=Lo01(ib) 
                     if k==1                 
                        dirn = strcat(bnum{ib},'\d',day,'m',month,'g',god,orbit);
                        mkdir(dirn);    
                        fidKu = fopen(strcat(dirn,'\areaKu.txt'),'wt');
%                           fprintf(fidKu,'La        Lo          incAngle       Sigma0      Precipitation          Time  \r\n');
                     end
                     % La Lo inc Sigma0 Precipitation time
                     fprintf(fidKu,'%e   %e   %e   %e   %e   %e   \r\n',LaKu(i1,j1),LoKu(i1,j1),IncAngleKu(i1,j1),sigmaKu(i1,j1),preciprateKu(i1,j1),secofdayKu(j1,1));
                     LaKu1(k) = LaKu(i1,j1);
                     LoKu1(k) = LoKu(i1,j1);
                     k = k+1;
                     k1=2;
                 end
              end
            end
          
            if k>1
                fclose(fidKu);
            end
        end
    end
end