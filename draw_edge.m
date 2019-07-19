function draw_edge(v1, v2, varargin)
% Draw an edge between v1 and v2, which may be 2d or 3d points, using the line spec in the varargs. 

v1 = v1(:);
v2 = v2(:); 
dim = numel(v1);

if(size(varargin) == 0)
    varargin{1} = 'k-';
end
if dim == 2
    plot([v1(1), v2(1)], [v1(2), v2(2)], varargin{:})
elseif dim == 3
    plot3([v1(1), v2(1)], [v1(2), v2(2)], [v1(3), v2(3)], varargin{:})
else
    error('Invalid dimension in draw_edge');
end
