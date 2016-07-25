local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {
	contains = function(self, p)
		for i = 1,#p do
			if p[i] <= self.p1[i] then return false end
			if p[i] >= self.p2[i] then return false end
		end

		return true
	end,
	intersects = function(self, aabb)
		for i = 1,#aabb.p1 do
			if aabb.p1[i] >= self.p2[i] then return false end
			if aabb.p2[i] <= self.p1[i] then return false end
		end

		return true
	end
}
local M = {}
	M.new = function(p1, p2)
		local self = setmetatable({}, O_M)

		self.p1 = p1	-- p1 is assumed to be closest corner to origin
		self.p2 = p2	-- p2 the farthest corner

		return self
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M
