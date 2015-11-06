%  This function permits to evaluate whether an undirected graph is connected
%
%  Input:
%  - adj: an adjacency matrix of an undirected graph  
%
%  Output:
%  - comps: a vector indicating, for each node, to which component it
%    belongs
%  - comp_sizes: the size (number of nodes) of each component found
%
%  If you are using this efficiency_package for your research, plase kindly cite the paper:
%  
%  "Exploring the Morphospace of Communication Efficiency in Complex Networks"
%  Goñi J, Avena-Koenigsberger A, Velez de Mendizabal N, van den Heuvel M,
%  Betzel RF and Sporns O.
%  PLoS ONE. 2013
%
function [comps,comp_sizes] = get_components(adj)

if size(adj,1)~=size(adj,2)
    error('this adjacency matrix is not square');
end

if ~any(adj-triu(adj))
    adj = adj | adj';
end

if nnz(adj-adj')>0
    error('this adjacency matrix is not symmetrical')
end

if sum(diag(adj))~=size(adj,1) %if main diagonal of adj do not contain all ones, i.e. autoloops
    adj = adj|speye(size(adj)); %the main diagonal is set to ones
end

[useless1,p,useless2,r] = dmperm(adj); 

comp_sizes = diff(r); 
num_comps = numel(comp_sizes); 
comps = zeros(1,size(adj,1)); 
comps(r(1:num_comps)) = ones(1,num_comps); 
comps = cumsum(comps); 
comps(p) = comps;
