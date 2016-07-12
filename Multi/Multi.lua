#!/usr/bin/lua
local Point = require("Point")

local class_meta = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local object_meta = {

}
local object_idx = {
	getPoint = function(self, p)
		if #p ~= #self._size then
			error("Invalid Argument in Multi:getPoint(point)")
		end
		
		local m = self._size[#p]
		local s = p[#p]

		for i = 1,#p-1 do
			s = s + ((p[#p-i]-1) * m)
			m = m * self._size[#p-i]
		end

		return self._a[s]
	end
}
object_meta.__index = object_idx
local Multi = {}
	Multi.new = function(size, init)
		local self = setmetatable({}, object_meta)

		self._size = size
		self._a = {}

		local function aTree(tree, size, depth, point)
			for i = 1,size[depth] do
				local p = point:copy()
				p:push(i)

				if depth < #size then
					aTree(tree, size, depth + 1, p)
				else
					table.insert(tree, {p, init})
				end
			end
		end
		aTree(self._a, self._size, 1, Point())

		return self
	end
setmetatable(Multi, class_meta)

local dimensions = Point(5, 3, 10, 6)
local m = Multi(dimensions, 0)

for i, v in ipairs(m._a) do
	print(i, v[1])
end

print(m:getPoint(Point(2, 3, 1, 1))[1])
print(m:getPoint(Point(3, 1, 4, 5))[1])
print(m:getPoint(Point(5, 3, 2, 2))[1])
print(m:getPoint(Point(3, 2, 7, 6))[1])
print(m:getPoint(Point(4, 2, 5, 5))[1])

return Multi





