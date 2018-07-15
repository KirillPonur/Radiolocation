    function [boo1,d21,j11]= apprpt(LaKu,LoKu,La0,Lo0,jmin,jmax,npolosy,nb);
    
    j1 = jmin;   
    for ib=1:nb
        boo1(ib) = true;
        j11(ib) = jmin;
        d21(ib) = deg2km(distance(LaKu(npolosy,j1),LoKu(npolosy,j1),La0(ib),Lo0(ib)));  
    end
    boo_s = true;  
    
    while boo_s && j1<jmax %(boo1(1)||boo1(2)||boo1(3)||boo1(4)||boo1(5)||boo1(6)) && j1<3300
        j1 = j1+1;        
        for ib =1:nb
            dist11(ib) = deg2km(distance(LaKu(npolosy,j1-2),LoKu(npolosy,j1-2),La0(ib),Lo0(ib)));
            dist21(ib) = deg2km(distance(LaKu(npolosy,j1),LoKu(npolosy,j1),La0(ib),Lo0(ib)));        
            dist31(ib) = deg2km(distance(LaKu(npolosy,j1+2),LoKu(npolosy,j1+2),La0(ib),Lo0(ib)));  

            if dist21(ib)<dist11(ib) && dist21(ib)<dist31(ib) 
               boo1(ib) = false;
               j11(ib) = j1;
               d21(ib) = dist21(ib);
            end              
        end   
        boo_s = boo1(1);
        for ib=1:nb
            boo_s = boo_s || boo1(ib);
        end
    end