local AABB = require("AABB2D")

local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {}
local M = {}
	M.MAX_ITEMS = 4
	M.MAX_DEPTH = 20
	M.new = function(aabb, depth)
		local self = setmetatable({}, O_M)
		self.items = {}
		self.aabb = aabb
		self.depth = depth or 0
		--self.NW
		--self.NE
		--self.SW
		--self.SE
		return self
	end
O_I.split = function(self)
	if not (self.depth < M.MAX_DEPTH) then return false end
	local hw = self.aabb.w/2
	local hh = self.aabb.h/2

	self.NW = M(AABB(self.aabb.x,				self.aabb.y,			hw, hh), depth+1)
	self.NE = M(AABB(self.aabb.x + hw,	self.aabb.y,			hw, hh), depth+1)
	self.SW = M(AABB(self.aabb.x,				self.aabb.y + hh, hw, hh), depth+1)
	self.SE = M(AABB(self.aabb.x + hw, 	self.aabb.y + hh, hw, hh), depth+1)

	return true
end
O_I.insert = function(self, item)
	if not self.aabb:contains(item.point) then return false end
	if #self.items < M.MAX_ITEMS then
		table.insert(self.items, item)
		return true
	end

	if not self.NE then
		if not self:split() then return false end
	end

	if self.NE:insert(item) then return true end
	if self.NW:insert(item) then return true end
	if self.SW:insert(item) then return true end
	if self.SE:insert(item) then return true end

	return false
end
O_I.range_query = function(self, range)
	if not range:intersects(self.aabb) then return false end
	local found = {}

	for _,item in ipairs(self.items) do
		if range:contains(item.point) then
			table.insert(found, item)
		end
	end

	if not self.NW then return found end

	for _,item in ipairs(self.NW:range_query(range)) do table.insert(found, item) end
	for _,item in ipairs(self.NE:range_query(range)) do table.insert(found, item) end
	for _,item in ipairs(self.SW:range_query(range)) do table.insert(found, item) end
	for _,item in ipairs(self.SE:range_query(range)) do table.insert(found, item) end

	return items
end

O_M.__index = O_I
setmetatable(M, M_M)

return M




