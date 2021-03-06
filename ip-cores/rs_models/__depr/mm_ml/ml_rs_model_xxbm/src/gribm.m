 % RiBM
 % Reformulation of the iBM Algorithm
 % �������� � ������� �����, ���� � � ���������!
 % [lambda, omega] = gribm(t, unicalc)
 % t - ������������ ����� ������������ ������
 % s - ��������
 % unicalc - ������ �����, ��� �������� ������ ��� 
 %           ���������� �������� � �����
 function [lambda, omega] = gribm(t, s, unicalc)

 % "High-Speed Low-Complexity Reed-Solomon Decoder
 % using Pipelined Berlekamp-Massey Algorithm and Its 
 % Folded Architecture"

 %%% ��������� �������� %%%
 delta = zeros(3*t+2, 2*t+1);
 ttt = zeros(3*t+2, 2*t+1);
 k = zeros(1, 2*t+1);
 gamma = zeros(1, 2*t+1);
 % init
 delta((3*t)+1, 0+1) = 1;
 ttt((3*t)+1, 0+1) = 1;
 k(0+1) = 0;
 gamma(0+1) = 1;
 for i = 0:2*t-1
     delta(i+1, 0+1) = s((i)+1);
     ttt(i+1, 0+1) = s((i)+1);
 end
 % calc
 for r = 0:2*t-1  % ����� ����� ���������
   % step 1
   for i = 0:3*t
     delta((i)+1, (r+1)+1) = ...
         gsum(gmult(gamma((r)+1), delta((i+1)+1, (r)+1), unicalc),...
              gmult(delta(0+1,(r)+1), ttt((i)+1, (r)+1), unicalc), unicalc);
           
   end
   % step 2
   pp = r;
   k((pp)+1)
   if (delta(0+1, (r)+1) ~= 0) && (k((pp)+1) >= 0) 
      for i = 0:3*t
        ttt((i)+1, (r+1)+1) = delta((i+1)+1, (r)+1);
      end
      gamma((r+1)+1) = delta(0+1, (r)+1);
      k((pp+1)+1) = -k((pp)+1)-1;
   else
      for i = 0:3*t  % ������ �� ����������
        ttt((i)+1, (r+1)+1) = ttt((i)+1, (r)+1);
      end
      gamma((r+1)+1) = gamma((r)+1);
      k((pp+1)+1) = k((pp)+1)+1;
   end
 end
 %
 delta
 lambda = delta(t+1:2*t+1, 2*t+1);
 omega = delta(1:t, 2*t+1);
