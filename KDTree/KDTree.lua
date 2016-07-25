local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local M = {}
	M.new = function(point, item)
		local self = setmetatable({}, O_M)

		self.point = point
		self.item = item

		-- self.left
		-- self.right

		return self
	end
local O_I = {}
	O_I.insert = function(point, item)
	end
	O_I.delete_at = function(point)
	end
	O_I.nearest_pals = function(point, radius)
		
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M





