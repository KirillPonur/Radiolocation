 function k1=cutfr_rect_swath(LaKu,LoKu,La01,Lo01,La02,Lo02,boo1,boo2,d21,d22,j11,j22,bnum,day,month,god,orbit,Lsw,nb,sizeKu,IncAngleKu,sigmaKu,preciprateKu,secofdayKu);
 k1=1;
 
sizeKu = size(LaKu); 
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
                        dirn = strcat(bnum{ib},'\d',day,'m',month,'g',god,orbit,'_swath');
                        mkdir(dirn);    
                        fidLa = fopen(strcat(dirn,'\LaKu.txt'),'wt');
                        fidLo = fopen(strcat(dirn,'\LoKu.txt'),'wt');
                        fidSig = fopen(strcat(dirn,'\SigKu.txt'),'wt');
                        fidInc = fopen(strcat(dirn,'\IncKu.txt'),'wt');
                        fidTime = fopen(strcat(dirn,'\SecKu.txt'),'wt');
                        fidPrec = fopen(strcat(dirn,'\PrecKu.txt'),'wt');
                     end
                     
                     
                     k1=2;                                          
                     jj1(k) = j1;
                     k = k+1;
                 end
              end
            end            
            nmin=min(jj1);
            nmax=max(jj1);
                
            dlmwrite(strcat(dirn,'\IncKu.txt'),IncAngleKu(:,nmin:nmax),'delimiter','\t');
            dlmwrite(strcat(dirn,'\SigKu.txt'),sigmaKu(:,nmin:nmax),'delimiter','\t');
            dlmwrite(strcat(dirn,'\LaKu.txt'),LaKu(:,nmin:nmax),'delimiter','\t');
            dlmwrite(strcat(dirn,'\LoKu.txt'),LoKu(:,nmin:nmax),'delimiter','\t');
            dlmwrite(strcat(dirn,'\PrecKu.txt'),preciprateKu(:,nmin:nmax),'delimiter','\t');
            dlmwrite(strcat(dirn,'\SecKu.txt'),secofdayKu(nmin:nmax),'delimiter','\t');
            
            imagesc(sigmaKu(:,nmin:nmax));
            
            if k>1
                fclose(fidLa);
                fclose(fidLo);
                fclose(fidSig);
                fclose(fidInc);
                fclose(fidTime);
                fclose(fidPrec);
            end
        end
    end
end