function draw_point(p, varargin)
% Draw a point in either 2-space or 3-space, with specified attributes

dim = numel(p); 

if(size(varargin) == 0)
    varargin{1} = 'm.';
end
if dim == 2
    plot(p(1), p(2), varargin{:})
elseif dim == 3
    plot3(p(1), p(2), p(3), '.', varargin{:})
else
    error('Invalid dimension in draw_point');
end

% Test code:

% draw_point([1, 1, 2], 'MarkerFaceColor', [1 0 1], 'MarkerSize', 40);
% figure(gcf)