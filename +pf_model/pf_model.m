classdef pf_model < handle
    properties
        particles=cell(0);
        model
        targets;
    end
    properties(Access = private)
        prior;
        likelihood;
    end
    methods
        function pfObj=pf_model(nPart,m,t,pFlag,m2)
            fprintf('loading model\n');
            tic
            if isa(m,'char')
                if nargin>3&&pFlag
                    [pfObj.model,pfObj.targets]=pf_model.word_map2_phoneme(m,t,m2);
                else
                    pfObj.model=pf_model.word_map2(m,t);
                    pfObj.targets=t;
                end
            else
                pfObj.model=m;
                pfObj.targets=t;
            end
            fprintf('model loaded in %0.1f seconds\n',toc);
            
            pfObj.reset(nPart);
        end
        
        function resample(pfObj)
            p = pfObj.particles;
            w=cellfun(@(x) x.weight,p);
            w=w-max(w);
            w=exp(w);
            [~,c]=find(mnrnd(1,w/sum(w),length(p)));
            pfObj.particles=p(c);
            pfObj.particles=cellfun(@(x) x.reset_weight,pfObj.particles,'UniformOutput',false);
        end
        
        function project(pfObj)
            p=pfObj.particles;
            pfObj.particles=cellfun(@(x) x.project,p,'UniformOutput',false);
        end
        
        function update_dist(pfObj,dist)
            p = pfObj.particles;
            l=log(dist);
            
            pfObj.particles=cellfun(@(x) x.add_weight(l(x.history(end))),p,'UniformOutput',false);
        end
        
        function prev_state(pfObj,reset_state)
            p = pfObj.particles;
            if reset_state == 1
               pfObj.particles=cellfun(@(x) x.set_weight_to_prev_weight,pfObj.particles,'UniformOutput',false);
            else
               pfObj.particles=cellfun(@(x) x.update_prev_weight,pfObj.particles,'UniformOutput',false);
            end
        end
            
        function reset(pfObj,nPart)
            p(1:nPart)=pf_model.particle([],pfObj.model(''));
            pfObj.particles=num2cell(p);
        end
        
        function d=get_dist(pfObj)
            p = pfObj.particles;
            w=cellfun(@(x) x.weight,p);
            ind=cellfun(@(x) x.position.letter,p);
            d=zeros(length(pfObj.targets),1);
            for i=1:length(pfObj.targets)
                d(i)=sum(exp(w(ind==i)));
            end
            d=d/sum(d);
%            d'
        end
        
        function out=get_results(pfObj)
            p=pfObj.particles;
            out=containers.Map;
            result=cellfun(@(x) pfObj.targets(x.history)',p,'UniformOutput',false);
            w=cellfun(@(x) x.weight,p);
            w=w-max(w);
            w=exp(w);
            w=w/sum(w);
            for m=1:length(result)
                try
                    out(result{m})=out(result{m})+w(m);
                catch e
                    out(result{m})=w(m);
                end
            end
        end
    end
end
       