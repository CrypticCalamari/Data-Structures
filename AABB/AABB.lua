local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
O_M = {}
O_I = {
	clone = function(self)
		return M({unpack(self.point)}, {unpack(self.extent)})
	end,
	contains = function(self, point)
		for i = 1,#self.point do
			if point[i] < self.point[i] then return false end
			if point[i] > self.point[i] + self.extent[i] then return false end
		end
		return true
	end,
	intersects = function(self, b)
		for i = 1,#self.point do
			if b.point[i] > self.point[i] + self.extent[i] then return false end
			if b.point[i] + b.extent[i] < self.point[i] then return false end
		end
		return true
	end
}
local M = {}
	M.new = function(point, extent)
		if #point ~= ~extent then
			error("AABB: Constructor: parameter size mismatch")
		end

		local self = setmetatable({}, O_M)
		self.point = point
		self.extent = extent
		return self
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M
