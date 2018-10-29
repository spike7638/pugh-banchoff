function sc = make_sphereComplex(sphereSet, dimension, topSimplices)
% Create a sphere complex from a sphere point set, a dimension (of the complex)
% and a list of top-dimensional simplices, where each simplex is a 
% column of the input matrix. Lower-dimensional simplices are the 
% boundaries of all higher-dimensional ones. 
if nargin == 0
    sc = test_make_sphereComplex()
    return
else
    u = cell(dimension, 1);
    u{dimension} = topSimplices;
    sc.dimension = dimension; 
    for d = (sc.dimension-1):-1:1
        u{d} = boundary_elements(u{d+1});
    end
    
    sc.set = sphereSet;
    sc.simplices = u;
    sc.simplices{dimension} = topSimplices;
    sc.nVerts = numel(sc.set.elements);
    sc.vert = @(i) sc.set.elements(i);
    sc.nEdges = @() size(sc.simplices{1}, 2);
    sc.edge = @(i) sc.simplices{1}(:,i);
    sc.nFaces = @() size(sc.simplices{2}, 2);
    sc.face = @(i) sc.simplices{2}(:,i);
    sc.simplex = @(d, i) sc.simplices{d}(:, i);
    sc.nSimplices = @(d) size(sc.simplices{d}, 2);
    
    % build lower-dimensional simplices
    for d = (sc.dimension-1):-1:1
        sc.simplices{d} = boundary_elements(sc.simplices{d+1});
    end
end

function e = boundary_elements(ss)
% For a list of simplices, where ith simplex is s(:, i)
% produce all boundary elements (each counted once) in sorted order

q = size(ss, 1);
if (q == 1) 
    e = [];
    return;
end
n = size(ss, 2);
res = zeros(q-1, q*n);
t = 1; 
for d = 1:q
    t = n*(d - 1) + 1;
    select = 1:q;
    select(d) = [];
    res(:, t:(t+n-1)) = ss(select, :);
end
res = sort(res); % sort each simplex into ascending order
t = sortrows(res');
t = unique(t, 'rows');
e = t'; % Now simplices are sorted too, and unique.  

% TEST CASE: 
%boundary_elements([[1;3;4], [4; 1; 2]])

function sc = test_make_sphereComplex()
ss = make_spherePointSet(4, (1/sqrt(3)) * [-1 -1 -1; 1 -1 1; -1 1 1; 1 1 -1]');
sc = make_sphereComplex(ss, 2, [1 2 3; 1 2 4; 2 3 4; 1 3 4]')



