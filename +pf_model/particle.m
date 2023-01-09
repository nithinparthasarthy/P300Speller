
classdef particle
    properties
        history
        position=pf_model.langNode.empty;
        weight
        prev_history
        prev_position=pf_model.langNode.empty;
        prev_weight
    end
    methods
        function obj = particle(hist,p)
            if nargin<1
                hist=[];
            end;
            if nargin>1
                obj.position=p;
            end;
            obj.history=hist;
            obj.weight=0;
        end
        function obj = project(obj)
            ind = find(mnrnd(1,obj.position.weights/sum(obj.position.weights)));
            obj.history=[obj.history obj.position.children(ind).letter];
            obj.position=obj.position.children(ind);
        end;
        
        function obj = reset_weight(obj)
            obj.weight=0;
        end;
        
        function obj = add_weight(obj,w)
            obj.weight=obj.weight+w;
        end;
        
        function obj = set_weight_to_prev_weight(obj)
%            obj.weight
            obj.weight=obj.prev_weight;
            obj.history = obj.prev_history;
            obj.position = obj.prev_position;
        end;
        
        function obj = update_prev_weight(obj)
%            obj.weight
            obj.prev_weight=obj.weight;
            obj.prev_history = obj.history;
            obj.prev_position = obj.position;
        end;        
        
    end
end