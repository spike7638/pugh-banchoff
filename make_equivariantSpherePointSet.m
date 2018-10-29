function esps = make_equivariantSpherePointSet(groupAction, groupRepresentation, locations)
% Create an equivariant sphere-point-set from its point-locations,
% and a group action and group representation. The group is assumed to act
% on the set of locations via corresponding indices, as is the group
% representation. 

if nargin == 0
    test_make_equivariantSpherePointSet()
    return
end

if (size(locations, 2) <= 0)
    error('make_equivariantSpherePointSet:TooSmall', 'need at least one point in set');
elseif (groupAction.group.order ~= groupRepresentation.group.order) 
    error('make_equivariantSpherePointSet:BadGroups', 'groups for action and representation must have same order');
elseif (size(locations, 1) ~= groupRepresentation.dim) 
    error('make_equivariantSpherePointSet:BadDimension', 'Representation acts on points in a different-dimensional space than the given locations');
else
    try
        h = make_homomorphism(groupAction.group, groupRepresentation.group, 1:(groupAction.group.order))
    catch
        error('make_equivariantSpherePointSet:NonIsomorphicGroups', 'identity map between groups not a homomorphism.');
    end
end

% OK. We have a set of locations, and a group action, and a representation.
% Let's make sure they're sphere-points:
try
    esps.set = make_spherePointSet(size(locations, 2), locations);
catch
    error('make_equivariantSpherePointSet:BadPoints', 'Given locations do not form a sphere set.')
end
esps.action = groupAction;
esps.representation = groupRepresentation; 

function test_make_equivariantSpherePointSet()
g = make_group('Z/2Z', 2, ['0', '1'], [1, 2; 2, 1]);
s = make_set(2);
ga = make_groupAction(g, s, g.mult);

m1 = eye(3);
m2 = -m1;
mats = zeros(3,3,2);
mats(:,:,1) = m1; 
mats(:,:,2) = m2; 
gr = make_groupRepresentation(g, 3, mats);


s3 = make_equivariantSpherePointSet(ga, gr, [eye(3); -eye(3)]');

