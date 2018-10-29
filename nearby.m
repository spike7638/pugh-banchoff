function s = nearby(pt1, pt2)
% Compare pt1 and pt2 and see whether their distance is smaller 
% than .001; if they are lists of points (each point being a 
% column), then compare pairwise, and return true only if
% all pairs are nearby. 
epsilon = .001; 

diff = pt2 - pt1; 
d2 = dot(diff, diff);
t = (d2 < epsilon * epsilon);
s = all(t); 

% nearby([1;2], [1;2.001])
% nearby([1;2], [1;2.01])
% nearby([1 1;2 2], [1 1;2.001 2.01])
