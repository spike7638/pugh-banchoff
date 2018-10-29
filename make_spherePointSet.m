function ps = make_spherePointSet(setSize, locations)
% Create a point-set from its size, dimension, and locaations of elements. 

if nargin == 0
    test_make_spherePointSet()
elseif (setSize >= 0) % should check that it's an int, but matlab consts are
    % doubles by default, so that's a pain, and I've skipped it. 
    ps.size = setSize;
    ps.dim = size(locations, 1);
    ps.elements = 1:ps.size;
    ps.locations = locations; 
else
    error('Set size must be a nonnegative integer');
end
u = (abs(dot(locations, locations) - 1) < .001);
if ~all(u) 
    error('spherePointSet construction: Points not all on unit sphere');
end

function test_make_spherePointSet()
s3 = make_spherePointSet(3, eye(3));
s3 = make_spherePointSet(3, 2*eye(3)); % should produce an error!

