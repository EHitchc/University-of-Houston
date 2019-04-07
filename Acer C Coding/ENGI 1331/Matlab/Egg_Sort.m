function [ medium,large,jumbo] = Egg_Sort(eggs)

     fc=length(eggs);
     count_med=0; count_jumbo=0;count_large=0;
     for i=1:1:fc
         if eggs(i) < 4
             count_med=count_med+1;
             %medium(count_med)=eggs(i);
             medium=count_med;
         elseif eggs(i) > 5
             count_jumbo=count_jumbo+1;
             %jumbo(count_jumbo)=eggs(i);
             jumbo=count_jumbo;
             
         else
             count_large=count_large+1;
             %large(count_large)=eggs(i);
             large=count_large;
             

end

     end