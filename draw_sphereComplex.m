function draw_sphereComplex(sc)
% draw a sphere complex. Coloring? 
%---------------------

%     sc.set = sphereSet;
%     sc.simplices = u;
%     sc.simplices{dimension} = topSimplices;
%     sc.nVerts = numel(sc.set.elements);
%     sc.vert = @(i) sc.set.elements(i);
%     sc.nEdges = @() size(sc.simplices{1}, 2);
%     sc.edge = @(i) sc.simplices{1}(:,i);
%     sc.nFaces = @() size(sc.simplices{2}, 2);
%     sc.face = @(i) sc.simplices{2}(:,i);
%     sc.simplex = @(d, i) sc.simplices{d}(:, i);
%     sc.nSimplices = @(d) size(sc.simplices{d}, 2);
    
if nargin == 0
    test_draw_sphereComplex()
    return
else
    hold on;
    % Draw each edge as an arc
    ne = sc.nEdges();
    for i = 1:ne
        f = sc.edge(i);
        u = sc.set.locations(:, f(1));
        v = sc.set.locations(:, f(2));
        draw_sphere_edge(u, v);
    end
    % Draw all faces.
    if (sc.dimension > 1)
        nf = sc.nFaces();
        for i = 1:nf
            f = sc.face(i)
            u = sc.set.locations(:, f(1));
            v = sc.set.locations(:, f(2));
            w = sc.set.locations(:, f(3));
            draw_sphere_tri(u, v, w, 'FaceColor', f/4);
        end
    end
    
    hold off;
    set(gca, 'DataAspectRatio', [1 1 1]);
    figure(gcf)
end

function test_draw_sphereComplex()
clf;
ss = make_spherePointSet(4, (1/sqrt(3)) * [-1 -1 -1; 1 -1 1; -1 1 1; 1 1 -1]');
sc = make_sphereComplex(ss, 2, [1 2 3; 1 2 4; 2 3 4; 1 3 4]')
draw_sphereComplex(sc);
pause(3); clf;
ss = make_spherePointSet(4, (1/sqrt(2)) * [-1 -1; 1 -1; 1 1; -1 1]');
sc = make_sphereComplex(ss, 1, [1 2; 2 3; 3 4; 4 1]')
draw_sphereComplex(sc);
