function ga = make_group_action(group, set, action_table)
% Create a group action of a group on a set. 
% The result of element i of the group acting on element k of the set 
% is the element action_table(i, k) of the set. 
if nargin == 0
    test_make_groupAction()
else
    ga.group = group; 
    ga.set = set;
    ga.action_table = action_table;
    ga.act = @(g, i) ga.action_table(g, i);
    
    % Check identity: for every s in S, we have e . s = s. 
    % where "e . s" denotes the action of e (the identity) on s. 
    for i = 1:ga.set.size
        if (ga.act(1, i) ~= i)
            error(['Group-action construction: identity rule failure']);
        end
    end
    % Check products: for every s in S, and g1, g2 in G
    % we have g2 . (g1 . s) = (g1*g2) . s. 

    g = ga.group; 
    s = ga.set;
    
    for i = 1:g.order
        for j = 1:g.order
            for u = 1:s.size
                t = ga.act(j, u);
                v = ga.act(i, t);
                p = g.mult(i, j);
                w = ga.act(p, u);
                if (v ~= w)
                    error(['Group-action construction failed associativity test']);
                end
            end
        end
    end
end

function test_make_groupAction()
g = make_group('Z/2Z', 2, ['0', '1'], [1, 2; 2, 1]);
s = make_set(2);
ga = make_group_action(g, s, g.mult);

g = make_group('Z/4Z', 4, ['0', '1', '2', '3'], ...
    [1, 2, 3, 4;
     2, 3, 4, 1;
     3, 4, 1, 2;
     4, 1, 2, 3]);
s = make_set(4);
ga = make_group_action(g, s, g.mult);

g = make_group('klein', 4, ['0,0', '1,0', '0,1', '1,1'], ...
    [1, 2, 3, 4;
     2, 1, 4, 3;
     3, 4, 1, 2;
     4, 3, 2, 1]);
s = make_set(2);
ga = make_group_action(g, s, [1 2; 2 1; 1 2; 2 1]);

