     
function [rv, rv_vector, flash_sequence, flashboard_matrix, adap_flashboard] = flashboard_polling_adaptive_flashboard(j, rv, rv_vector, flashboard_choice, pr, adap_flashboard, flash_scheme, charset)

   flash_sequence_regular = {'a','b','c','d','e','f';
             'g','h','i','j','k','l';
             'm','n','o','p','q','r';
             's','t','u','v','w','x';
             'y','z','1','2','3','4';
             '5','6','7','.','9','_';};
           
           
   flashboard_matrix =    [0 0 0 0 0 0 ...
                           0 0 0 0 0 0 ...
                           0 0 0 0 0 0 ...
                           0 0 0 0 0 0 ...
                           0 0 0 0 0 0 ...
                           0 0 0 0 0 0];
    
      if (j == 1)
           adap_flashboard = flash_sequence_regular;
           adap_flashboard = freqdistribution_adaptive_flashboard(adap_flashboard, flashboard_choice, charset, pr); 
      end
      if flash_scheme == 0
             
           if rv == 12
             rv = 1;
           else
             rv = rv + 1;
           end 
      elseif flash_scheme == 1
           if (j == 1)            
             rv_vector = randperm(12); 
             rv = rv_vector(1);
           else
             rv = rv_vector(j);
           end
      elseif flash_scheme == 2 % Weighted flashing, sort the probabilities of rows and columns
                               % based on the flashboard type. 
          if (j == 1)             
             row_prob = zeros(1,6);
             col_prob = zeros(1,6);
             if (flashboard_choice == 0)  % Regular 
                 for yy=1:6
                   row_prob(yy) = sum(pr(6*(yy-1)+1:6*(yy-1)+6));
                   col_prob(yy) = 0;
                   for zz=1:6
                      col_prob(yy) = col_prob(yy) + pr(yy+(zz-1)*6);
                   end
                 end
             elseif (flashboard_choice == 1)
                 sorted_pr = sort(pr, 'descend');
                 for yy=1:6
                   row_prob(yy) = sum(sorted_pr(6*(yy-1)+1:6*(yy-1)+6));
                   col_prob(yy) = 0;
                   for zz=1:6
                      col_prob(yy) = col_prob(yy) + sorted_pr(yy+(zz-1)*6);
                   end
                 end
             elseif (flashboard_choice == 4) % Diagonal flashboard
                 sorted_prob = sort(pr, 'descend');    
                 diag_prob(1) = sorted_prob(1);
                 diag_prob(8) = sorted_prob(2);
                 diag_prob(15) = sorted_prob(3);
                 diag_prob(22) = sorted_prob(4);
                 diag_prob(29) = sorted_prob(5);
                 diag_prob(36) = sorted_prob(6);
                 diag_prob(2) = sorted_prob(7);
                 diag_prob(9) = sorted_prob(8);
                 diag_prob(16) = sorted_prob(9);
                 diag_prob(23) = sorted_prob(10);
                 diag_prob(30) = sorted_prob(11);
                 diag_prob(7) = sorted_prob(12);
                 diag_prob(14) = sorted_prob(13);
                 diag_prob(21) = sorted_prob(14);
                 diag_prob(28) = sorted_prob(15);
                 diag_prob(35) = sorted_prob(16);
                 diag_prob(3) = sorted_prob(17);
                 diag_prob(10) = sorted_prob(18);
                 diag_prob(17) = sorted_prob(19);
                 diag_prob(24) = sorted_prob(20);
                 diag_prob(13) = sorted_prob(21);
                 diag_prob(20) = sorted_prob(22);
                 diag_prob(27) = sorted_prob(23);
                 diag_prob(34) = sorted_prob(24);
                 diag_prob(4) = sorted_prob(25);
                 diag_prob(11) = sorted_prob(26);
                 diag_prob(18) = sorted_prob(27);
                 diag_prob(19) = sorted_prob(28);      
                 diag_prob(26) = sorted_prob(29);
                 diag_prob(33) = sorted_prob(30);
                 diag_prob(5) = sorted_prob(31);
                 diag_prob(12) = sorted_prob(32);
                 diag_prob(25) = sorted_prob(33);
                 diag_prob(32) = sorted_prob(34);
                 diag_prob(6) = sorted_prob(35);
                 diag_prob(31) = sorted_prob(36);
                for yy=1:6
                  row_prob(yy) = sum(diag_prob(6*(yy-1)+1:6*(yy-1)+6));
                  col_prob(yy) = 0;
                  for zz=1:6
                      col_prob(yy) = col_prob(yy) + diag_prob(yy+(zz-1)*6);
                  end
                end
             end
             [sorted_rowprob, rowidx] = sort(row_prob, 'descend');
             [sorted_colprob, colidx] = sort(col_prob, 'descend');
             rv_vector = [rowidx, colidx+6];
             rv = rv_vector(1);
          else
             rv = rv_vector(j);
          end
      end
          
    flash_sequence = {' ',' ',' ',' ',' ',' ';
                      ' ',' ',' ',' ',' ',' ';
                      ' ',' ',' ',' ',' ',' ';
                      ' ',' ',' ',' ',' ',' ';
                      ' ',' ',' ',' ',' ',' ';
                      ' ',' ',' ',' ',' ',' '};
                       
    if rv <= 6
        flash_row = adap_flashboard(rv,:);
    else
        flash_row = adap_flashboard(:,rv-6);
    end
        
          
    for jj=1:6
      for kk = 1:6
         test = flash_sequence_regular{jj,kk};
         if any(strcmp(test,flash_row))==1
             flash_sequence{jj,kk} = test;
             flashboard_matrix(6*(jj-1)+kk) = rv;
         end
       end
    end
end