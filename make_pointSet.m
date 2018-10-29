function ps = make_pointSet(setSize, locations)
% Create a point-set from its size, dimension, and locaations of elements. 

if nargin == 0
    test_make_pointSet()
elseif (setSize >= 0) % should check that it's an int, but matlab consts are
    % doubles by default, so that's a pain, and I've skipped it. 
    ps.size = setSize;
    ps.dim = size(locations, 1);
    ps.elements = 1:ps.size;
    ps.locations = locations; 
else
    error('Set size must be a nonnegative integer');
end


function test_make_pointSet()
s3 = make_pointSet(3, eye(3));
