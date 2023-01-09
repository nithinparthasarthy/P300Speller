
N = 60000; % N is the block length of random data
M = 20000; % Feedback control signal subsampling rate assuming div80 clock

sum_x = 0; % Initialize accumulator
fdbk = 0;
dc_offset = 20;
cumulFdbk = 0; % Cumulative feedback
dmode = 0; % datagen mode
Thr = 1500;   % Threshold to check prior to issuing correction
fid = fopen('vec.txt','w');

for tot = 1:N 
 
   if dmode == 0
      x =  randi(128, 80,1) - 1; % Random integer data generation in the range [0, 127]
   elseif dmode == 1
      x = 100*ones(80,1);
   elseif dmode == 2
      x = zeros(80,1);
   end
   x = x - 64 + dc_offset - cumulFdbk; % Rescale to a range of [-64,63] after adding
   if x > 63     % Saturate the range
       x = 63;
   elseif x < -64
       x= -64
   end
   sum_x = sum_x + sum(x);
   if sum_x > (2^27) - 1   % Saturate to 27 bits
       sum_x = (2^27) - 1;
   elseif sum_x < -(2^27)
       sum_x = -(2^27)
   end
   
   fprintf(fid, "%x ",bitand(x+128,127)); 
   fprintf(fid, "%f %d\n",bitand(sum_x+2^27,(2^27)-1), cumulFdbk);
   
   
   if tot%M == 0
       if sum_x > Thr
           fdbk = 1;
       elseif sum_x < -Thr
           fdbk = -1;
       else
           fdbk = 0;
       end
       sum_x = 0;
       cumulFdbk = cumulFdbk + fdbk;
   end            
end
fclose(fid);