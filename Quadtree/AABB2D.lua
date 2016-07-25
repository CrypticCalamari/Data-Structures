local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {
	contains = function(self, x, y)
		return ((x > self.x) and
						(y > self.y) and
						(x < self.x + self.w) and
						(y < self.y + self.h))
	end,
	intersects = function(self, b)
		return ((b.x < self.x + self.w) and
						(b.y < self.y + self.h) and
						(b.x + b.w > self.x) and
						(b.y + b.h > self.y))
	end
}
local M = {}
	M.new = function(x, y, w, h)
		local self = setmetatable({}, O_M)
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		return self
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M
