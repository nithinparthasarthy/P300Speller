classdef langNode < handle
    properties
        letter;
        children=pf_model.langNode.empty;
        weights;
        totalWeight;
        word;
    end
    methods
        function obj = langNode(l,n)
 %           fprintf("l is %d\n", l)
            if(nargin<1)
                obj.letter=-1;
            else
%                fprintf("l is %d\n", l)
                obj(length(l))=pf_model.langNode;
                if(nargin<2)
                    n=1;
                end;
                for i=1:length(obj)
                    obj(i).weights=zeros(n,1);
                    obj(i).totalWeight=0;
                    obj(i).letter=l(i);
                end;
            end;
        end
    end
end