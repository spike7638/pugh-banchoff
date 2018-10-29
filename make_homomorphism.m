function h = make_homomorphism(group1, group2, mapping_table)
% Create a homorphism from one group to another. 
% mapping_table(i) (where i is in the first group) gives 
% the corresponding element of group2. 

if nargin == 0
    test_make_homomorphism()
else
    h.domain = group1;
    h.codomain = group2; 
    h.table = mapping_table;
    h.map = @(i) mapping_table(i); 
    
    % Check identity (h(e) = e')
    if h.map(1) ~= 1
        error('make_homomorphism:identity', 'homomorphism construction: identity failure');
    end
    
    % Check product rule (h(ab) = h(a) h(b))
    for i = 1:h.domain.order
        for j = 1:h.domain.order
            k = h.domain.mult(i, j);
            ip = h.map(i);
            jp = h.map(j);
            kp = h.map(k);
            kpp = h.codomain.mult(ip, jp);
            if (kp ~= kpp)
                error('make_homomorphism:product', 'homomorphism construction: failed product rule')
                i
                j
            end
        end
    end
end

function test_make_homomorphism()
z2 = make_group('Z/2Z', 2, ['0', '1'], [1, 2; 2, 1]);
z4 = make_group('Z/4Z', 4, ['0', '1', '2', '3'], ...
    [1, 2, 3, 4;
     2, 3, 4, 1;
     3, 4, 1, 2;
     4, 1, 2, 3]);
klein = make_group('klein', 4, ['0,0', '1,0', '0,1', '1,1'], ...
    [1, 2, 3, 4;
     2, 1, 4, 3;
     3, 4, 1, 2;
     4, 3, 2, 1]);

h = make_homomorphism(z2, z2, [1, 2]);
h = make_homomorphism(z2, z2, [1, 1]);
try
    h = make_homomorphism(z2, z2, [2, 1]);
catch ME
    if ~( ME.identifier == 'make_homomorphism:identity')
        error('test failed in make_homomorphism');
    end
end
h = make_homomorphism(z2, z4, [1, 3]);
try
    h = make_homomorphism(z2, z4, [1, 4]);
catch ME
    if ~( ME.identifier == 'make_homomorphism:product')
        error('test failed in make_homomorphism');
    end
end
% Test cases
% h = make_homomorphism(klein, z2, [1, 2, 2, 1]);
% h = make_homomorphism(klein, z2, [1, 1, 1, 1]);
% h = make_homomorphism(klein, z2, [1, 2, 2, 2]); % should fail!
