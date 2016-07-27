#!/usr/bin/lua

local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local O_M = {}
local O_I = {}
local M = {}
	M.new = function(item)
		local self = setmetatable({}, O_M)
		self.item = item
		self.left = nil
		self.right = nil
		return self
	end

O_I.insert = function(self, item)
	if item < self.item then
		if self.left then
			self.left:insert(item)
		else
			self.left = M(item)
		end
	else
		if self.right then
			self.right:insert(item)
		else
			self.right = M(item)
		end
	end
end
O_I.contains = function(self, item)
	if self.item == item then return true end

	if item < self.item then
		if self.left then
			return self.left:contains(item)
		else return false end
	else
		if self.right then
			return self.right:contains(item)
		else return false end
	end
end
O_I.range_query = function(self, range)
	local found = {}
	if	self.item < range[1] or
			self.item > range[2] then
		return found
	end

	table.insert(found, self.item)
	if self.left then
		for _,i in ipairs(self.left:range_query(range)) do table.insert(found, i) end
	end
	if self.right then
		for _,i in ipairs(self.right:range_query(range)) do table.insert(found, i) end
	end

	return found
end

O_M.__index = O_I
setmetatable(M, M_M)

test = M(5)
for i = 1,10 do
	test:insert(math.random(100))
end

t = test:range_query({0,50})
for _,v in ipairs(t) do print(v) end
print(test:contains(5))

return M
