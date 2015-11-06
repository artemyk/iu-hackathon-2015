
function [D P B] = get_shortest_path_lengths(D)

% input:    D is a distance matrix; if D is a strength matrix,
%           a transformation to distance must be done ( e.g. D' = (1./D)-1 )
% output:   D is the distance btween all pairs of elements
%           P is the number of edges in the path
%           B is a matrix wh0e element b_ij is the last node
%           in the shortest path between i and j

 
P = double(D>0);
D(D == 0) = inf;
n = size(D,1);

B = repmat(1:n,n,1);

for k=1:n
    
    i2k_k2j = bsxfun(@plus, D(:,k),D(k,:));
    
    if nargout>1 
        path = bsxfun(@gt, D, i2k_k2j);
        [i j] = find(path);  
        P(path) = P(i,k) + P(k,j)';
        B(path) = B(i,k);
    end
    D = min(D, i2k_k2j);
    %D(i2k_k2j<D)=i2k_k2j(i2k_k2j<D);
end

    

    
    
    
    
    
    
    
    
    
    
    
    