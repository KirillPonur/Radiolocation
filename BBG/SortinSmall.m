function [] = Sortin( LaKu,LoKu,LaTop,LaBottom,LoRight,LoLeft,dirn,whatK,IncAngleKu,sigmaKu,preciprateKu,secofdayKu)
    sizeKu=size(LaKu);
    firstTime=true;
     for ii=1:sizeKu(1)
        for jj=1:sizeKu(2)
           if LaKu(ii,jj)<= LaTop && LaKu(ii,jj)>= LaBottom
            if LoKu(ii,jj)<= LoRight && LoKu(ii,jj)>= LoLeft
                                 
                 if firstTime
                        [folderStatus,folderMessage]=mkdir(dirn);   %making directory with 'dirn' name
                        fidKu = fopen(strcat(dirn,'\area',whatK,'.txt'),'wt');
                        %fprintf(fidKu,'%12s   %12s   %12s   %12s   %12s   %12s\r\n','La','Lo','incAngle','Sigma0','Precipitation','Time');
                        firstTime=false;
                 end
                 
%                fprintf(fidKu,'La        Lo          incAngle       Sigma0      Precipitation          Time  \r\n');
                    
                  % La Lo inc Sigma0 Precipitation time
                 fprintf(fidKu,'%e   %e   %e   %e   %e   %e   \r\n',LaKu(ii,jj),LoKu(ii,jj),IncAngleKu(ii,jj),sigmaKu(ii,jj),preciprateKu(ii,jj),secofdayKu(jj,1));
                 %LaKuSort(k) = LaKu(i1,j1);
                 %LoKuSort(k) = LoKu(i1,j1);
                 %k = k+1;
                 %k1=2;
            end
           end
        end
     end
     fclose(fidKu);

     
     
%       firstTime=true;
%     k = 1;
%     tic;
%     for i = 1:sizeK(1)
%       for j = 1:sizeK(2)
%           if LaK(i,j) <= LaMax && LaK(i,j) >= LaMin
%               if or(LoK(i,j)<=LoMax && LoK(i,j)>=LoMin,LoK(i,j)<=LoMaxJump && LoK(i,j)>=LoMinJump) 
%                  dist = distance(LaK(i,j),LoK(i,j),La0,Lo0);        
%                  if dist <= R
%                      %creating folder, only if needed
%                       if firstTime
%                         [folderStatus,folderMessage]=mkdir(dirn);%making directory with 'dirn' name
%                         fidK = fopen(strcat(dirn,strcat('\area',whatK,'.txt')),'wt');
%                         fprintf(fidK,'%12s   %12s   %12s   %12s   %12s   %12s\r\n','La','Lo','incAngle','Sigma0','Precipitation','Time');
%                         firstTime=false;
%                       end
%                      % La Lo inc Sigma0 Precipitation time
%                      fprintf(fidK,'%e   %e   %e   %e   %e   %e   \r\n',LaK(i,j),LoK(i,j),IncAngleK(i,j),sigmaK(i,j),preciprateK(i,j),secofdayK(j,1));
%                      LaK_New(k) = LaK(i,j);
%                      LoK_New(k) = LoK(i,j);
%                      k = k+1;
%                  end
%              end
%           end
%       end
%     end
%     LaK_New(k:end)=[];
%     LoK_New(k:end)=[];
%     if ~firstTime
%         fclose(fidK);
%     end
% end

