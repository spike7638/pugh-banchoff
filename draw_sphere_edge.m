function draw_sphere_edge(v1, v2, varargin)
% Draw an arc on the sphere (or circle) in black, or optional other color/style, from v1 to v2, using 
% npoints points.

npoints = 20; 
v1 = v1(:);
v2 = v2(:); 
v1 = v1 / norm(v1);
v2 = v2 / norm(v2);

q = v2 - dot(v2, v1)* v1; 
q = q / norm(q); 
% v1 and q now form an orthonormal basis of the plane spanned by v1 
% and v2. 
theta = atan2(dot(v2, q), dot(v2, v1));
t = linspace(0, theta, npoints);
c = cos(t);
s = sin(t); 
dim = size(v1, 1); 
v1r = repmat(v1, 1, npoints);
qr = repmat(q, 1, npoints);
cr = repmat(c, dim, 1);
sr = repmat(s, dim, 1);
pts = cr .* v1r + sr .* qr; 

if(size(varargin) == 0)
    varargin{1} = 'k-';
end
if dim == 2
    plot(pts(1,:), pts(2,:), varargin{:})
elseif dim == 3
    plot3(pts(1,:), pts(2,:), pts(3,:), varargin{:})
else
    error('Invalid dimension in draw_sphere_edge');
end
