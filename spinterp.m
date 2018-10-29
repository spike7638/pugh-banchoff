function r = spinterp(p, q, t)
% Find the point that's t of the way (0 <= t <= 1) from p to q on 
% an arc of the unit sphere. Preconditon: p ~= -q. 
% Also works for a list of t-values, producing a 3 x n array. 

t = t(:)'; 
p = p(:);
q = q(:);
p = p / norm(p); q = q/norm(q); 
if nearby(p, -q)
    error('Spinterp:antipodal', 'Cannot interpolate between antipodal points')
end
if (min(t) < 0) || (max(t) > 1) 
    error('Spinterp:outOfRange', 'Cannot interpolate outside of interval [0,1]')
end

v = q - dot(q, p) * p; 
v = v / norm(v);
% p and v are now a basis for the pq plane. 
theta = atan2(dot(q, v), dot(q, p)); 
angle = (1-t)* theta;   
r = p * cos(angle) + v * sin(angle); 
