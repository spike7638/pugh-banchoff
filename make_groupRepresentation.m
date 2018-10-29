function gr = make_groupRepresentation(group, dim, matrices)
% Create a group action of a group on R^n, i.e., a representation into GL(n). 
% Here "dim" is the dimension n, and the matrices correspond to element of
% the group: matrices(:,:,i) is the map for the left action of element i
% on a point of R^n. 

if nargin == 0
    test_make_group_representation()
else
    gr.group = group; 
    gr.dim = dim;
    gr.matrices = matrices;
    gr.mat = @(i) squeeze(matrices(:,:,i)); 
    gr.act = @(i, x) gr.mat(i) * x;
    
    % Sanity-check dimensions:
    if ~(size(matrices, 1) == dim && size(matrices, 2) == dim && size(matrices, 3) == group.order)
        error('Group-representation-construction error: dimensions or order do not match.');
    end
    
    % Check identity: the identity element of the group must map to eye(n)
    
    if (  ~isequal(gr.mat(1), eye(gr.dim)))
        error(['Group-representation construction: identity rule failure']);
    end
    
    % Check products: for every g1, g2 in G
    % we have mat(g1g2) = mat(g1) * mat(g2) 
    
    g = gr.group;
    
    for i = 1:g.order
        gi = gr.mat(i);
        for j = 1:g.order
            gj = gr.mat(j);
            gk = gr.mat(g.mult(i, j));
            q = gi * gj;
            d = q - gk;
            s = trace(d*d');
            if (s > 0.00001)
                error(['Group-representation construction: product rule failure']);
            end
        end
    end
end

function test_make_group_representation()
g = make_group('Z/2Z', 2, ['0', '1'], [1, 2; 2, 1]);
m1 = eye(2);
m2 = -m1;
mats = zeros(2,2,2);
mats(:,:,1) = m1; 
mats(:,:,2) = m2; 
r = make_groupRepresentation(g, 2, mats);

g = make_group('Z/4Z', 4, ['0', '1', '2', '3'], ...
    [1, 2, 3, 4;
    2, 3, 4, 1;
    3, 4, 1, 2;
    4, 1, 2, 3]);
mats = zeros(2,2,4);
mats(:,:,1) = m1; 
mats(:,:,2) = m2; 
mats(:,:,3) = m1; 
mats(:,:,4) = m2; 
r = make_groupRepresentation(g, 2, mats);