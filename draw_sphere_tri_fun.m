function draw_sphere_tri(v1, v2, v3, varargin)
% Draw a triangle on the sphere, defined by corners v1, v2, v3, 
% no two of which may be antipodal. 

npoints = 20; 
v1 = v1(:);
v2 = v2(:); 
v3 = v3(:); 
v1 = v1 / norm(v1);
v2 = v2 / norm(v2);
v3 = v3 / norm(v3);

q = v2 - dot(v2, v1)* v1; 
q = q / norm(q); 
% v1 and q now form an orthonormal basis of the plane spanned by v1 
% and v2. 
n = cross(v1, q);
if (dot(n, v3) < 0)
    t = v1;
    v1 = q;
    q = v1;
    n = -n;
end
nPoints = 10; 
t = linspace(0, 1, npoints);
left = spinterp(v1, v3, t);
right = spinterp(v2, v3, t);

res = zeros(3, npoints, npoints);
for i = 1:npoints
    lp = left(:, i);
    rp = right(:, i);
    s = spinterp(lp, rp, t);
    res(:, i, :) = s;
end

x = squeeze(res(1,:,:));
y = squeeze(res(2,:,:));
z = squeeze(res(3,:,:));
patch(x, y, z, z); 
set(gca, 'DataAspectRatio', [1,1,1]);

draw_sphere_tri([1;0;0], [0; 1; 0], [0;0;1])