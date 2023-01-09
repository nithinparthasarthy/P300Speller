function [map,model] = word_map2_s(dir,targets)
if nargin<2
    targets='abcdefghijklmnopqrstuvwxyzñáéíóú1234567890';
end;

try
    map=load(strcat(dir,'\model_s.mat'));
    map=map.map;
catch e
    'No map.mat file found. Creating file'
    files = ls(strcat(dir,'\spanishText_*'));
    szFile = cell(size(files,1),1);
    for i=1:size(files,1)
        szFile{i}=strtrim(strcat(dir,'\',files(i,:)));
    end;
    
    map=containers.Map;
    
    for i=1:length(szFile)
    %for i=1
        szFile{i}
        fid = fopen(szFile{i});
        text = lower(fscanf(fid,'%c'));
        text = strrep(text,'/',' ');
        text = strrep(text,'-',' ');
        text = strrep(text,'_',' ');
        fclose(fid);
        words = strread(text,'%s');
        html_flag=0;
        for j=1:length(words)
        %for j=1:20
            p='';
            index=0;
            if strcmp(words{j},'endofarticle.')
                continue;
            end;
%             if strcmp(words{j},'</doc>')
%                 continue;
%             end;
            if length(words{j})>20
                continue;
            end;
            if strcmp(words{j}(1),'<')
                html_flag=1;
            end;
            if strcmp(words{j}(end),'>')
                html_flag=0;
                continue;
            end;
            if html_flag
                continue;
            end;
            for k=1:length(words{j})
                if sum(words{j}(k)==targets)>0
                    index=index+1;
                    if(index==1)
                        try
                            map('') = map('') + 1;
                        catch
                            map('') = 1;
                        end;
                    end;
                    p=[p words{j}(k)];
                    try
                        map(p) = map(p) + 1;
                    catch
                        map(p) = 1;
                    end;
                end;
            end;
            if(~isempty(p))
                try
                    map([p '_']) = map([p '_']) + 1;
                catch
                    map([p '_']) = 1;
                end;
            end;
        end;
    end;
	%save(strcat(dir,'\model_s.mat'),'map')
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
model=[];

