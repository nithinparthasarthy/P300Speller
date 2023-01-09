clear all;
charset = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x',...
           'y','z','1','2','3','4','5','6','7','_','.']; % 8 and 9 are left out since they are period and backspace 


corpusdata = load('newmodels.mat');
word_model = corpusdata.biword_model;
fid = fopen('probs_for_python_biword.txt', 'w');
count = 0;

for a=1:length(charset) 
 word = strcat(charset(a))
 if isKey(word_model, word+"_")
   fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
   for b=1: length(charset)
     word = strcat( charset(a) ,charset(b))
     if isKey(word_model, word+"_")
       fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
       for c=1:length(charset)
          word = strcat( charset(a) ,charset(b) ,charset(c))
          if isKey(word_model, word+"_")
            fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
            for d=1:length(charset)
               word = strcat( charset(a) ,charset(b) ,charset(c), charset(d))
               if isKey(word_model, word+"_")
                  fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                  for e=1:length(charset)  
                    word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e))
                    if isKey(word_model, word+"_")
                      fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                      for f=1:length(charset)
                        word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f))
                        if isKey(word_model, word+"_")
                          fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                          for g=1:length(charset)
                            word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g))
                            if isKey(word_model, word+"_")
                              fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
  %                            fflush(fid);
                              for h=1:length(charset)
                                word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h))
                                if isKey(word_model, word+"_")
                                   fprintf(fid, "%s  %d\n", word, word_model(word+"_"))

                                   for i=1:length(charset)
                                    word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i))
                                    if isKey(word_model, word+"_")
                                      fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                      for j=1:length(charset)
                                        word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j))
                                        if isKey(word_model, word+"_")
                                          fprintf(fid, "%s  %d\n", word, word_model(word+"_"))

                                          for k=1:length(charset)
                                             word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k))
                                             if isKey(word_model, word+"_")
                                               fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                               for l=1:length(charset)
                                                  word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l))
                                                  if isKey(word_model, word+"_")
                                                    fprintf(fid, "%s  %d\n", word, word_model(word+"_")) 
                                                    for m=1:length(charset)
                                                        word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m))
                                                        if isKey(word_model, word+"_")
                                                           fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                           for n=1:length(charset)
                                                              word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n))
                                                              if isKey(word_model, word+"_")
                                                                 fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                 for o=1:length(charset)
                                                                    word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o))
                                                                    if isKey(word_model, word+"_")
                                                                        fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                        for p=1:length(charset)
                                                                            word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p))
                                                                            if isKey(word_model, word+"_")
                                                                               fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                               for q=1:length(charset)
                                                                                 word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q))
                                                                                 if isKey(word_model, word+"_")
                                                                                    fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                    for r=1:length(charset)
                                                                                      word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r))
                                                                                      if isKey(word_model, word+"_")
                                                                                           fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                           for s=1:length(charset)
                                                                                               word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s))
                                                                                               if isKey(word_model, word+"_")
                                                                                                  fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                  for t=1:length(charset)
                                                                                                     word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t))
                                                                                                     if isKey(word_model, word+"_")
                                                                                                         fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                         for u=1:length(charset)
                                                                                                            word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t), charset(u))
                                                                                                            if isKey(word_model, word+"_")
                                                                                                               fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                               for v=1:length(charset)
                                                                                                                  word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t), charset(u), charset(v))
                                                                                                                  if isKey(word_model, word+"_")
                                                                                                                      fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                                      for w=1:length(charset)
                                                                                                                         word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t), charset(u), charset(v), charset(w))
                                                                                                                         if isKey(word_model, word+"_")
                                                                                                                            fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                                            for x=1:length(charset)
                                                                                                                              word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t), charset(u), charset(v), charset(w), charset(x))
                                                                                                                              if isKey(word_model, word+"_")
                                                                                                                                 fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                                                 for y=1:length(charset)
                                                                                                                                    word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t), charset(u), charset(v), charset(w), charset(x), charset(y))
                                                                                                                                    if isKey(word_model, word+"_")
                                                                                                                                      fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                                                      for z=1:length(charset)
                                                                                                                                          word = strcat( charset(a) ,charset(b) ,charset(c) ,charset(d) ,charset(e) ,charset(f) ,charset(g) ,charset(h) ,charset(i), charset(j), charset(k), charset(l), charset(m), charset(n), charset(o), charset(p), charset(q), charset(r), charset(s), charset(t), charset(u), charset(v), charset(w), charset(x), charset(y), charset(z))
                                                                                                                                          if isKey(word_model, word+"_")
                                                                                                                                            fprintf(fid, "%s  %d\n", word, word_model(word+"_"))
                                                                                                                                          end
                                                                                                                                      end
                                                                                                                                    end
                                                                                                                                 end
                                                                                                                              end
                                                                                                                            end
                                                                                                                         end
                                                                                                                      end
                                                                                                                  end
                                                                                                               end
                                                                                                            end
                                                                                                         end
                                                                                                     end
                                                                                                  end
                                                                                               
                                                                                               end
                                                                                           end
                                                                                      end
                                                                                    end
                                                                                 end
                                                                               end
                                                                            end
                                                                        end
                                                                    end
                                                                 end
                                                              end
                                                           end
                                                        end
                                                    end
                                                  end
                                               end
                                             end
                                          end
                                         end
                                      end
                                    end    
                                  end 
                                end
                              end
                            end
                          end
                        end
                      end  
                    end
                  end
                end
              end
            end
         end
      end
   end
 end
end

fprintf("Total word count is %d\n", count)
fclose(fid);
  
