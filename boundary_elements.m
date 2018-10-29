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