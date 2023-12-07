%_____________MASK Modulation and Demodulation Code________
 clear all;
 close all;
 Nb=5;
 Rb=1; %bps
 T=1/Rb;
 
 % Generate Nb bits randomly
 %b =rand(1,Nb)&amp;amp;amp;gt;0.5;
 b =[1 1 0 1 0 0 1 0 1 1];
 %Rb is the bit rate in bits/second
 bit_to_symbol=[];
 for i=1:2:size(b,2)
 a = [b(i) b(i+1)]
 x = bin2dec(num2str(a))
 switch(x) 
 case [0]
 bit_to_symbol=[bit_to_symbol 0];
 case [1]
 bit_to_symbol=[bit_to_symbol 1];
 case [2]
 bit_to_symbol=[bit_to_symbol 2];
 case [3]
 bit_to_symbol=[bit_to_symbol 3];
 end
 
 end
 NRZ_out=[];
 RZ_out=[];
 Manchester_out=[];
 Vp=1;
 for index=1:size(bit_to_symbol,2)
 NRZ_out=[NRZ_out ones(1,200)*bit_to_symbol(index)];
 end
 figure;
 stem(b, 'filled', 'Linewidth', 4);
 xlabel('Sequence Number','FontSize',12)
 ylabel ('Transmitted Bits [0/1]','FontSize',12)
 ylim ([0 2])
 figure;
 plot(NRZ_out, 'b', 'Linewidth', 4);
 xlabel ('Time')
 ylabel ('NRZ output')
 ylim ([0 4])
 grid on
 
 
 t=0.005:0.005:5;
 f=5;
 Modulated=NRZ_out.*(sqrt(2/T)*sin(2*pi*f*t));
 figure;
 plot(Modulated, 'Linewidth', 4);
 xlabel ('Time','FontSize',12)
 ylabel ('Modulated Carrier','FontSize',12)
 ylim ([-6 6])