local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {
	__len = function(o)
		return #o.heap
	end
}
local O_I = {}
local M = {}
	M.new = function()
		local self = setmetatable({}, O_M)
		self.heap = {}
		return self
	end

O_I.size = function(self) return #self.heap end
O_I.isEmpty = function(self) return (#self.heap == 0) end
O_I.push = function(self, item)
	
end

O_M.__index = O_I
setmetatable(M, M_M)

return M
