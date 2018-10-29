function s = make_set(size)
% Create a set from its size; the elements are always 1...s, where s is the size.
if nargin == 0
    test_make_set()
elseif (size >= 0) % should check that it's an int, but matlab consts are
    % doubles by default, so that's a pain, and I've skipped it. 
    s.size = size;
    s.elements = 1:s.size;
else
    error('Set size must be a nonnegative integer');
end

function test_make_set()
s3 = make_set(3);
s0 = make_set(0);
if (s3.size ~= 3) || ~isequal(s3.elements, [1, 2, 3])
    error('Failed to make 3-element set')
elseif (s0.size ~= 0) 
    error('Failed to make empty set')
elseif (size(s0.elements) ~= 0)
    error('Failed to make empty set')
end