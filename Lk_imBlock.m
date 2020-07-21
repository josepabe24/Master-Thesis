function LK_im=Lk_imBlock(Block,mu,lamda,tList)
    n=size(Block,2)
    %start=bi2de(cat(2,1,repmat(0,1,n-1)),'left-msb')
    stop=(2^(n-1))-1 %bi2de(cat(2,1,repmat(0,1,n-1)),'left-msb')
    
    anc=[];
    for i=0:(stop-1)
        anc=[anc;de2bi(i,'left-msb',n)]
    end
    
    LK_im=0;
    
    for i=1:size(anc,1)
        [im_block,block]=Split_im(anc(i,:),Block)
                 
         
            prob_im=imm_prob(im_block(2:end,:),tList,mu,lamda)
            geom_im=(1-(lamda/mu));
            prob_im=prob_im*geom_im;
            sub_probim=0.25^size(im_block,2)            
         
         
         
         if ~isempty(block)
             par=sum(block(1,:)~='-');
             geom=(lamda/mu)^par;
             b=subblocking(block)
             prob_col=1;
             sub_col=1;
             for n=1:size(b,1)
                leav=b{n}(2:end,:)
                prob_col=prob_col*col_prob(leav,tList,mu,lamda)
                sub_col=sub_col*Substitution(leav,tList)
             end
             
             LK_im=LK_im+(geom*prob_im*sub_probim*prob_col*sub_col)
         else
             
             LK_im=LK_im+(prob_im*sub_probim)
         end
                 
    end
    
    prob_empty_im=imm_prob([],tList,mu,lamda)
    
    prob_empty_im=prob_empty_im*geom_im;
    prob_blk=LK_Block(Block,mu,lamda,tList)
    LK_im=LK_im+(prob_empty_im*prob_blk)
    %include geometric prob 1-lam/mu for immortal
end