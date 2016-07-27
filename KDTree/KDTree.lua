local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local M = {}
	M.new = function(point, item, depth)
		local self = setmetatable({}, O_M)
		self.point = point
		self.item = item
		self.depth = depth or 0
		-- self.left
		-- self.right
		return self
	end
local O_I = {}
	O_I.insert = function(self, point, item)
		local i = (depth % #self.point) + 1

		if self.point[i] >= point[i] then
			if self.left then
				self.left:insert(point, item)
			else
				self.left = M(point, item, self.depth+1)
			end
		else
			if self.right then
				self.right:insert(point, item)
			else
				self.right = M(point, item, self.depth+1)
			end
		end
	end
	O_I.delete = function(self, point)
	end
	O_I.range_query = function(self, range)
		
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M





