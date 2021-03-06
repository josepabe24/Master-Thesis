function [im_block,Block_List]=Blocking(MSA)
% Blocking splits the MSA into blocks according to the blocking criterion
% inputs:
% MSA= Sequence alignment

    sum_vec=sum(MSA~='-',1);
    inx=find(sum_vec>=2);
    im_block=[];
    Block_List=[];
    % Blocking the MSA by checking the blocking criterion
    for i=size(inx,2):-1:1
                
        if i==size(inx,2)
            Block_List=[Block_List;{MSA(:,inx(i):end)}];
                    
        else
            stop=inx(i+1)-1;
            Block_List=[{MSA(:,inx(i):stop)};Block_List];
        end
    end
    if inx(1)~=1
        im_block=[{MSA(:,1:inx(1)-1)}];
    end
end