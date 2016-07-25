print("Dracula: What is a man? A miserable little pile of secrets. But enough talk... Have at you!")
local AABB = require("AABB_CornerBased")
local Point = require("Point")

local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local M = {}
	M.MAX_ITEMS = 4
	M.MAX_DEPTH = 20
	M.new = function(aabb, depth)
		local self = setmetatable({}, O_M)
		self.items = {}					-- [2] = {point, value}
		self.aabb = aabb				-- Axis-Aligned Bounding Box
		self.depth = depth or 0	-- Depth of this sub-tree in the overall tree
		return self
	end

local O_I = {}
	O_I.split = function(self)
		if not (self.depth < M.MAX_DEPTH) then return false end

		local hw = self.aabb.p2[1] - self.aabb.p1[1]/2
		local hh = self.aabb.p2[2] - self.aabb.p1[2]/2

		self.NE = M(
								AABB(
									self.aabb.p1:diffCopy(1, hw),
									self.aabb.p2:diffCopy(2, hh),
									self.depth+1))
		self.NW = M(
								AABB(
									self.aabb.p1,
									Point(hw, hh),
									self.depth+1))
		self.SW = M(
								AABB(
									self.aabb.p1:diffCopy(2, hh),
									self.aabb.p2:diffCopy(1, hw),
									self.depth+1))
		self.SE = M(
								AABB(
									Point(hw, hh),
									self.aabb.p2:copy(),
									self.depth+1))

		--[[
		self.NE = M({hw, self.x[2]}, {self.y[1], hh}, self.depth+1)
		self.NW = M({self.x[1], hw}, {self.y[1], hh}, self.depth+1)
		self.SW = M({self.x[1], hw}, {hh, self.y[2]}, self.depth+1)
		self.SE = M({hw, self.x[2]}, {hh, self.y[2]}, self.depth+1)
		]]

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
		local items = {}

		if not self.aabb:intersects(range) then return items end

		for i,item in ipairs(self.items) do
			if range:contains(item.point) then
				table.insert(items, item)
			end
		end

		if not self.NE then return items end

		for _,item in ipairs(self.NE:range_query(range)) do table.insert(items, item) end
		for _,item in ipairs(self.NW:range_query(range)) do table.insert(items, item) end
		for _,item in ipairs(self.SW:range_query(range)) do table.insert(items, item) end
		for _,item in ipairs(self.SE:range_query(range)) do table.insert(items, item) end

		return items
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M






