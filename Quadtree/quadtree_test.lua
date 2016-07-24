local QuadTree = require("QuadTree")

q = QuadTree({0,128}, {0,128}, 0)

math.randomseed(os.time())
for i = 1, 100 do
	q:insert({{x=math.random(128), y=math.random(128)}, 42})
end

t = q:range_query({x={0,64}, y={0,64}})
print(#t)

--print(tostring(q))
