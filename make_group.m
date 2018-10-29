function g = make_group(group_name, order, names, multiplication_table)
% Create a group from its order, the names of the elements, and a multn
% table; check that the mult table defines a group
if nargin == 0
    test_make_group()
else
    g.group_name = group_name;
    g.order = order;
    g.names = names;
    g.mult = multiplication_table;
    
    % Check identity
    for i = 1:g.order
        if (g.mult(1, i) ~= i)
            error(['Group construction failed identity test']);
        elseif (g.mult(i, 1) ~= i)
            error(['Group construction failed identity test']);
        end
    end
    % Check inverses
    u = ismember(repmat([1], g.order, 1), g.mult);
    v = ismember(repmat([1], g.order, 1), g.mult');
    if ~(all(u) & all(v))
        error(['Group construction failed inverse test']);
    end
    
    %Check associativity (ugh!)
    for i = 1:g.order
        for j = 1:g.order
            for k = 1:g.order
                t = g.mult(i, j);
                s = g.mult(t, k);
                u = g.mult(j, k);
                v = g.mult(i, u);
                if (s ~= v)
                    error(['Group construction failed associativity test']);
                end
            end
        end
    end
end

function test_make_group()
g = make_group('Z/2Z', 2, ['0', '1'], [1, 2; 2, 1]);
g = make_group('Z/4Z', 4, ['0', '1', '2', '3'], ...
    [1, 2, 3, 4;
     2, 3, 4, 1;
     3, 4, 1, 2;
     4, 1, 2, 3]);
g = make_group('klein', 4, ['0,0', '1,0', '0,1', '1,1'], ...
    [1, 2, 3, 4;
     2, 1, 4, 3;
     3, 4, 1, 2;
     4, 3, 2, 1]);
 
