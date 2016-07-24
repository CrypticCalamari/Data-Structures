print("Dracula: What is a man? A miserable little pile of secrets. But enough talk... Have at you!")
local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
	O_M.__tostring = function(o)
		local t = {}

		for i = 1, o.depth do table.insert(t, "+---") end
		table.insert(t, "Top Left Corner: (")
		table.insert(t, tostring(o.x[1]))	table.insert(t, ",")	table.insert(t, tostring(o.y[1]))
		table.insert(t, ")\n")

		for i = 1, o.depth do table.insert(t, "+---") end
		table.insert(t, "Bottom Right Corner: (")
		table.insert(t, tostring(o.x[2]))	table.insert(t, ",")	table.insert(t, tostring(o.y[2]))
		table.insert(t, ")\n")

		for i = 1, o.depth do table.insert(t, "+---") end
		table.insert(t, "Depth: ") table.insert(t, tostring(o.depth))	table.insert(t, "\n")

		for i = 1, o.depth do table.insert(t, "+---") end
		table.insert(t, "Items: [")
		for i,v in ipairs(o.items) do
			table.insert(t, "(") table.insert(t, tostring(v[1].x)) table.insert(t, ", ")
			table.insert(t, tostring(v[1].y)) table.insert(t, "),")
			table.insert(t, "value:")	table.insert(t, tostring(v[2])) table.insert(t, ", ")
		end
		if #o.items > 0 then
			table.remove(t)
		end
			table.insert(t, "]\n")

		table.insert(t, tostring(o.NE))
		table.insert(t, tostring(o.NW))
		table.insert(t, tostring(o.SW))
		table.insert(t, tostring(o.SE))
		if not o.NE then table.insert(t, "\n") end

		return table.concat(t)
	end
local M = {}
	M.MAX_DEPTH = 10	-- MAX_ITEMS^10
	M.MAX_ITEMS = 4
	M.new = function(x, y, depth)
		local self = setmetatable({}, O_M)
		
		self.items = {}			--[2] = {{x, y}, value}
		self.x = x					--[2] = {x1, x2}
		self.y = y					--[2] = {y1, y2}
		self.depth = depth

		return self
	end
	M.point_in_rectangle = function(rect, point)
		return	point.x > rect.x[1] and
						point.x < rect.x[2] and
						point.y > rect.y[1] and
						point.y < rect.y[2]
	end

local O_I = {}
	O_I.split = function(self)
		if not (self.depth < M.MAX_DEPTH) then return false end
		local hw = (self.x[2] + self.x[1])/2
		local hh = (self.y[2] + self.y[1])/2

		self.NE = M({hw, self.x[2]}, {self.y[1], hh}, self.depth+1)
		self.NW = M({self.x[1], hw}, {self.y[1], hh}, self.depth+1)
		self.SW = M({self.x[1], hw}, {hh, self.y[2]}, self.depth+1)
		self.SE = M({hw, self.x[2]}, {hh, self.y[2]}, self.depth+1)

		return true
	end
	O_I.insert = function(self, item)
		if not self:within_bounds(item[1]) then return false end
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
	O_I.within_bounds = function(self, point)
		return	point.x >= self.x[1] and
						point.x <= self.x[2] and
						point.y >= self.y[1] and
						point.y <= self.y[2]
	end
	O_I.intersects = function(self, rect)
		if	self.x[1] <= rect.x[2] and
				self.x[2] >= rect.x[1] and
				self.y[1] <= rect.y[2] and
				self.y[2] >= rect.y[1] then
			return true
		end
		
		return false
	end
	O_I.range_query = function(self, range)
		local points = {}

		if not self:intersects(range) then return points end

		for i,v in ipairs(self.items) do
			if M.point_in_rectangle(range, v[1]) then
				table.insert(points, v)
			end
		end

		if not self.NE then return points end

		for _,v in ipairs(self.NE:range_query(range)) do table.insert(points, v) end
		for _,v in ipairs(self.NW:range_query(range)) do table.insert(points, v) end
		for _,v in ipairs(self.SW:range_query(range)) do table.insert(points, v) end
		for _,v in ipairs(self.SE:range_query(range)) do table.insert(points, v) end

		return points
	end

O_M.__index = O_I
setmetatable(M, M_M)

return M






