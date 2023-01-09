function [c,n1,n2] = word_bimap2(dir,targets)
if nargin<2
    targets='abcdefghijklmnopqrstuvwxyz1234567890';
end;

try
    model=load(strcat(dir,'\bimodel.mat'));
    c=model.c;
    n1=model.n1;
    n2=model.n2;
catch e
    'No map.mat file found. Creating file'
    files = ls(strcat(dir,'\c*'));
    szFile = cell(size(files,1),1);
    for i=1:size(files,1)
        szFile{i}=strtrim(strcat(dir,'\',files(i,:)));
    end;
    
    c=containers.Map;
    p='_';
    for i=1:length(szFile)
%    for i=2
        if(regexp(files(i,:),'c\D\d'))
            szFile{i}
            fid = fopen(szFile{i});
            text = lower(fscanf(fid,'%c'));
            fclose(fid);
            words = strread(text,'%s');
            for j=1:length(words)
                index=0;
                for k=1:length(words{j})
                    if sum(words{j}(k)==targets)>0
                        index=index+1;
                        if(index==1)
                            try
                                c(p) = c(p) + 1;
                            catch
                                c(p) = 1;
                            end;
                        end;
                        p=[p words{j}(k)];
                        try
                            c(p) = c(p) + 1;
                        catch
                            c(p) = 1;
                        end;
                    elseif strcmp(words{j}(k),'/')&&(index>0)
                        if(~isempty(p))
                            try
                                c([p '_']) = c([p '_']) + 1;
                            catch
                                c([p '_']) = 1;
                            end;
                        end;
                        p=[p(strfind(p,'_')+1:end) '_'];
                        break;
                    elseif strcmp(words{j},'./.')
                        try
                            c(p) = c(p) + 1;
                        catch
                            c(p) = 1;
                        end;
                        try
                            c([p '_']) = c([p '_']) + 1;
                        catch
                            c([p '_']) = 1;
                        end;
                        p='_';
                        break;
                    end;
                end;
            end;
        end;
    end;
    %save(strcat(dir,'\bimodel.mat'),'c')
    
    keys=c.keys;
    n1=containers.Map;
    n2=containers.Map;
    for i=1:length(keys)
        k=strfind(keys{i},'_');
        if length(k)>1
            k=k(1);
            for j=k:length(keys{i})
                try
                    n1(keys{i}(1:j))=n1(keys{i}(1:j))+1;
                catch
                    n1(keys{i}(1:j))=1;
                end;
                try
                    n2(keys{i}((k+1):j))=n2(keys{i}((k+1):j))+1;
                catch
                    n2(keys{i}((k+1):j))=1;
                end;
            end;
        end;
    end;
    save(strcat(dir,'\bimodel.mat'),'c','n1','n2');
end;

% si=find(targets=='_');
% root=pf_model.langNode(si,length(targets));
% keySet=map.keys;
% keySet=keySet(2:end);
% parentKeys=cellfun(@(x) x(1:length(x)-1),keySet,'UniformOutput',false);
% letters=cellfun(@(x) find(x(end)==targets), keySet);
% nodes=pf_model.langNode(letters,length(targets));
% nodes(letters==si)=root;
% langNodes=containers.Map(keySet(letters~=si),num2cell(nodes(letters~=si)));
% langNodes('')=root;
% parentNodes=values(langNodes,parentKeys);
% valid=cellfun(@(x) sum(x(end)==targets)>0,keySet);
% %for i=1:length(keySet)
% for i=find(valid)
%     key=keySet{i};
%     letter=letters(i);
%     parentNode=parentNodes{i};
%     node=nodes(i);
%     parentNode.totalWeight=parentNode.totalWeight+map(key);
%     parentNode.weights(letter)=parentNode.weights(letter)+map(key);
%     parentNode.children(letter)=node;
% end;
% model=langNodes;

