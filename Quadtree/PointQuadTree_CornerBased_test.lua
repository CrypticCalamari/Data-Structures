local QuadTree = require("PointQuadTree_CornerBased")
local AABB = require("AABB_CornerBased")
local Point = require("Point")

q = QuadTree(AABB(Point(0, 0), Point(128, 128)))

math.randomseed(os.time())
for i = 1, 100 do
	q:insert({point = Point(math.random(128), math.random(128)), 42})
end

range = AABB(
					Point(0,0),
					Point(64,64))
t = q:range_query(range)
print(#t)

