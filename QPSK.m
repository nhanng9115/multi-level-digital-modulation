%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Quadri-Phase-Shift-Keying               %
%               By Ankitkumar K Chheda                 %
%     Pune Institute of Computer Technology, Pune      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%Taking Input Bit Sequence
temp = input ('Want to enter bit sequence (1) Yes / (2) No : ');
clc;
if temp == 1
    bit_seq = input('Enter bit sequence [0 1 0 1 0 ... ] : ');
else 
    disp ('Default bit sequence taken [0 1 0 1 1 0 1 1 0 1 1 1]');
    input('Press any key to continue');
    bit_seq = [0 1 1 0 1 0 0 1];
end

%Initiations
N = length(bit_seq);
fc = 1;                                 %Carrier Frequency for Demo
t = 0 : 0.001 : 2;                      % Bit Period = 2 * (1/fc)
b = [];
qpsk = [];
bec = [];
bes = [];
b_o = [];
b_e = [];
bit_e = [];
bit_o = [];

%Creating input waveform on Bit Sequence
for i = 1 : N
    bx = bit_seq(i) * ones(1, 1000);
    b = [b bx];
end

%Seperating Even and Odd Bits
for i = 1 : N
    if bit_seq(i) == 0
        bit_seq(i) = -1;
    end
    if mod(i,2) == 0
        e_bit = bit_seq(i);
        b_e = [b_e e_bit];
    else
        o_bit = bit_seq(i);
        b_o = [b_o o_bit];
    end
end

%Calculating QPSK Signal
for i = 1 : N/2
    be_c = (b_e(i) * cos (2*pi*fc*t));
    bo_s = (b_o(i) * sin (2*pi*fc*t));
    q = be_c + bo_s;
    even = b_e(i) * ones(1,2000);
    odd = b_o(i) * ones (1,2000);
    bit_e = [bit_e even];
    bit_o = [bit_o odd];
    qpsk = [qpsk q];
    bec = [bec be_c];
    bes = [bes bo_s];
end
clc;
figure('Name','QPSK Demonstration')

% Plot waveform of Input Bits Sequence
% subplot(411);       plot(b, 'o');       grid on;
% axis([0 (N*1000) 0 1])
% xlabel('Time'); ylabel('I/P Bit Stream');
% title ('\bf\color{blue} Demonstration of QPSK Waveforms');

%Plot waveform of Odd Bits 
subplot(311);       plot(bes,'LineWidth',3);          hold on;
plot(bit_o, 'rs:');                     grid on;
axis([0 (N*1000) -1 1]);                ylabel('Odd Bits','FontSize',15);

%Plot waveform of Even Bits 
subplot(312);       plot (bec,'LineWidth',3);         hold on; 
plot(bit_e, 'rs');                      grid on;
axis([0 (N*1000) -1 1]);                ylabel('Even Bits','FontSize',15);

%Plot waveform of QPSK signal 
subplot(313);       plot (qpsk,'LineWidth',3);        grid on;
axis([0 (N*1000) -1.5 1.5]);            ylabel('QPSK','FontSize',15); xlabel('Time','FontSize',15)