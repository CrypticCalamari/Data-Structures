local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {
	contains = function(p)
		for i = 1,#p do
			if p[i] < p1[i] then return false end
			if p[i] > p2[i] then return false end
		end

		return true
	end,
	intersects = function(aabb)
		for i = 1,#aabb.p1 do
			if aabb.p1[i] > p2[i] then return false end
			if aabb.p2[i] < p1[i] then return false end
		end

		return true
	end
}
local M = {}
	M.new = function(p1, p2)
		local self = setmetatable({}, O_M)

		if #p1 ~= #p2 then
			error("Point Construction Failure: Corner point dimensionality mismatch!")
		end

		-- p1 is assumed to be closest corner to origin and p2 the farthest corner

		self.p1 = p1
		self.p2 = p2

		return self
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M
