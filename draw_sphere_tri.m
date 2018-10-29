function draw_sphere_tri(v1, v2, v3, varargin)
% Draw a triangle on the sphere, defined by corners v1, v2, v3, 
% no two of which may be antipodal. 

npoints = 20; 
v1 = v1(:);
v2 = v2(:); 
v1 = v1 / norm(v1);
v2 = v2 / norm(v2);
v3 = v3(:); 
v3 = v3 / norm(v3);

n = cross(v1, v2);
n = n / norm(n);
if dot (n, v3) < 0 
    t = v1; 
    v1 = v2;
    v2 = t;
    n = -n;
end

q = v2 - dot(v2, v1)* v1; 
q = q / norm(q); 
% v1 and q now form an orthonormal basis of the plane spanned by v1 
% and v2. 

t = linspace(0, 1, npoints);
left = spinterp(v1, v3, t);
right = spinterp(v2, v3, t);

res = zeros(3, npoints, npoints);
for i = 1:npoints
    lp = left(:, i);
    rp = right(:, i);
    s = spinterp(lp, rp, t);
    res(:, :, i) = s;
end

x = squeeze(res(1,:,:));
y = squeeze(res(2,:,:));
z = squeeze(res(3,:,:));
surf(x, y, z, z, 'EdgeColor', 'none', 'FaceLighting', 'gouraud', varargin{:}); 

% Test code:
%draw_sphere_tri([1;0;0], [0; 1; 0], [0;0;1], 'FaceColor', [0.4, 0.4, 0.9])
%set(gca, 'DataAspectRatio', [1,1,1]);
%camlight;
%figure(gcf)
