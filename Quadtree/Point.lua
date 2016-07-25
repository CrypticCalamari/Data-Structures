--[[/////////////////////////////////////
//			Class: Metatable					//
/////////////////////////////////////--]]
local M_M = {
	__call = function(class, ...)
		return class.new(...)
	end
}
local M = {}
setmetatable(M, M_M)
--[[/////////////////////////////////////
//			Object: Metatable					//
/////////////////////////////////////--]]
local O_I = {
	copy = function(self)
		return M(unpack(self.point))
	end,
	diffCopy = function(self, i, v)
		p = {unpack(self.point)}
		p[i] = v
		return M(unpack(p))
	end,
	--[[ NOTE:	temporarily commenting out these two functions until there is a 
					use case for them. Previous use case subsumed by __newindex
	offset = function(self, i, o)
		p = {unpack(self.point)}
		p[i] = p[i] + o
		return M(unpack(p))
	end,]]
	push = function(self, new_dim)
		table.insert(self.point, new_dim)
	end,
	pushFront = function(self, new_dim)
		table.insert(self.point, 1, new_dim)
	end,
	pop = function(self)
		return table.remove(self.point)
	end
}
local O_M = {
	__call = function(o)
		local i = 0
		local n = #o.point
		return function()
			i = i + 1
			if i <= n then return i,o.point[i] end
		end
	end,
	__index = function(o, i)
		return O_I[i] or o.point[i]
	end,
	__newindex = function(o, k, v)
		if k > 0 and k <= #o.point then
			o.point[k] = v
		else
			error("Don't use M's newindex like that. TODO: Handle this better.")
		end
	end,
	__len = function(o)
		return #o.point
	end,
	__ne = function(left, right)
		if #left.point ~= #right.point then
			return true
		end
		for i,v in ipairs(left.point) do
			if v ~= right.point[i] then
				return true
			end
		end
		return false
	end,
	__eq = function(left, right)
		if #left.point ~= #right.point then
			return false
		end
		for i,v in ipairs(left.point) do
			if v ~= right.point[i] then
				return false
			end
		end
		return true
	end,
	__tostring = function(o)
		local t = {}
		table.insert(t, "{")

		for i,v in ipairs(o.point) do
			table.insert(t, tostring(v))

			if i < #o.point then
				table.insert(t, ",")
			end
		end

		table.insert(t, "}")
		return table.concat(t)
	end
}
--[[/////////////////////////////////////
//			Class: Table						//
/////////////////////////////////////--]]
	M.new = function(...)
		local self = {}

		self.point = {...}

		setmetatable(self, O_M)
		return self
	end
--[[/////////////////////////////////////
//			Class: Other						//
/////////////////////////////////////--]]
return M





