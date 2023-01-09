function [model,targets] = word_map2_phoneme(map_dir,dict_dir,wmodel)

%map_dir='U:\Data\CMU_phoneme_corpus\';
map_file=strcat(map_dir,'SphinxPhones_40.txt');
fid = fopen(map_file);
text = lower(fscanf(fid,'%c'));
fclose(fid);
targets=strread(text,'%s');

%dict_dir='U:\Data\CMU_phoneme_corpus\';
model_file=strcat(dict_dir,'\model.mat');
try
    model = load(model_file);
    model=model.model;
    return
catch e
end

%wmodel='Z:\users\wspeier\Data\brown\';
if ischar(wmodel)
    wmodel = pf_model.word_map2(wmodel,'abcdefghijklmnopqrstuvwxyz123456789_');
elseif ~strmcp(class(wmodel),'containers.Map')
    error('model must either be a language model or a path to a corpus directory.');
end

dict_file=strcat(dict_dir,'\cmudict_SPHINX_40.txt');
fid = fopen(dict_file);
words=textscan(fid,'%s %[^\r]\r\n');
phones=words{2};
phones=cellfun(@(x) strsplit(x),phones,'UniformOutput',false);
phones=cellfun(@(x) cellfun(@(y) find(strcmpi(y,targets)),x),phones,'UniformOutput',false);
words=words{1};
%text = lower(fscanf(fid,'%c'));
fclose(fid);

si=length(targets);
root=pf_model.langNode(si,length(targets));
worked=0;
langNodes=containers.Map();
langNodes(char([]))=root;
for i=1:length(words)
%     i
    try
        alts=[i;strmatch([words{i} '('],words)];
        weight=wmodel(lower(words{i})).weights(36);
        weight=ceil(weight/length(alts));
        for j=alts'
            p=phones{j};
            for k=1:length(p)
                %k
                parentNode=langNodes(char('a'+p(1:(k-1))));
                if ~langNodes.isKey(char('a'+p(1:k)))
                    langNodes(char('a'+p(1:k)))=pf_model.langNode(p(k),length(targets));
                    parentNode.children(p(k))=langNodes(char('a'+p(1:k)));
                    parentNode.weights(p(k))=0;
                end
                parentNode.totalWeight=parentNode.totalWeight+weight;
                parentNode.weights(p(k))=parentNode.weights(p(k))+weight;
                langNodes(char('a'+p(1:(k-1))))=parentNode;
            end
            temp=langNodes(char('a'+p));
            temp.children(si)=langNodes(char([]));
            temp.weights(si)=temp.weights(si)+weight;
            temp.totalWeight=temp.totalWeight+weight;
            langNodes(char('a'+p))=temp;
        end
        worked=worked+1;
    catch e
    end
end
model=langNodes;

'saving'
save(strcat(dict_dir,'\model.mat'),'model');
    
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
% end
% model=langNodes;

