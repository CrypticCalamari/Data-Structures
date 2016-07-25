local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {
	contains = function(self, x, y, z)
		return ((x > self.x) and
						(y > self.y) and
						(z > self.z) and
						(x < self.x + self.w) and
						(y < self.y + self.h) and
						(z < self.z + self.l))
	end,
	intersects = function(self, b)
		return ((b.x < self.x + self.w) and
						(b.y < self.y + self.h) and
						(b.z < self.z + self.l) and
						(b.x + b.w > self.x) and
						(b.y + b.h > self.y) and
						(b.z + b.l > self.z))
	end
}
local M = {}
	M.new = function(x, y, z, w, h, l)
		local self = setmetatable({}, O_M)
		self.x = x
		self.y = y
		self.z = z
		self.w = w
		self.h = h
		self.l = l
		return self
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M
