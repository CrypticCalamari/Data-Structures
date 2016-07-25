local AABB = require("AABB3D")

local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {}
local M = {}
	M.MAX_ITEMS = 8
	M.MAX_DEPTH = 20
	M.new = function(aabb, depth)
		local self = setmetatable({}, O_M)
		self.octants = {}
		self.items = {}
		self.aabb = aabb
		self.depth = depth or 0
		return self
	end
O_I.split = function(self)
	if not (self.depth < M.MAX_DEPTH) then return false end
	local hw = self.aabb.w/2
	local hh = self.aabb.h/2
	local hl = self.aabb.l/2

	self.octants[1] = M(AABB(self.aabb.x,				self.aabb.y,			self.aabb.z,			hw, hh, hl), depth+1)
	self.octants[2] = M(AABB(self.aabb.x + hw,	self.aabb.y,			self.aabb.z,			hw, hh, hl), depth+1)
	self.octants[3] = M(AABB(self.aabb.x,				self.aabb.y + hh,	self.aabb.z,			hw, hh, hl), depth+1)
	self.octants[4] = M(AABB(self.aabb.x,				self.aabb.y,			self.aabb.z + hl,	hw, hh, hl), depth+1)
	self.octants[5] = M(AABB(self.aabb.x + hw,	self.aabb.y + hh,	self.aabb.z,			hw, hh, hl), depth+1)
	self.octants[6] = M(AABB(self.aabb.x,				self.aabb.y + hh,	self.aabb.z + hl,	hw, hh, hl), depth+1)
	self.octants[7] = M(AABB(self.aabb.x + hw,	self.aabb.y,			self.aabb.z + hl,	hw, hh, hl), depth+1)
	self.octants[8] = M(AABB(self.aabb.x + hw,	self.aabb.y + hh,	self.aabb.z + hl,	hw, hh, hl), depth+1)

	return true
end
O_I.insert = function(self, item)
	if not self.aabb:contains(item.point) then return false end
	if #self.items < M.MAX_ITEMS then
		table.insert(self.items, item)
		return true
	end

	if not self.octants[1] then
		if not self:split() then return false end
	end

	for _,octant in ipairs(self.octants) do
		if octant:insert(item) then return true end
	end

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

	if not self.octants[1] then return found end

	for _,octant in ipairs(self.octants) do
		for _,item in ipairs(octant:range_query(range)) do
			table.insert(found, item)
		end
	end

	return items
end

O_M.__index = O_I
setmetatable(M, M_M)

return M






