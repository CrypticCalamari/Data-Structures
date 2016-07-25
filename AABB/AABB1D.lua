local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {
	contains = function(self, x)
		return ((x > self.x) and
						(x < self.x + self.dx))
	end,
	intersects = function(self, bb)
		return ((b.x < self.x + self.dx) and
						(b.x + b.dx > self.x))
	end
}
local M = {}
	M.new = function(x, dx)
		local self = setmetatable({}, O_M)

		self.x = x
		self.dx = dx

		return self
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M
