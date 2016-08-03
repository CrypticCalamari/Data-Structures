#!/usr/bin/python3

class Point:
	def __init__(self, x, y):
		self.x = x
		self.y = y

class Bound:
	def __init__(self, x, y, w, h):
		self.x = x
		self.y = y
		self.w = w
		self.h = h
	def contains(self, point):
		return ((point.x > self.x) and
						(point.y > self.y) and
						(point.x < self.x + self.w) and
						(point.y < self.y + self.h))
	def intersects(self, bound):
		return ((self.x < bound.x + bound.w) and
						(self.y < bound.y + bound.h) and
						(bound.x < self.x + self.w) and
						(bound.y < self.y + self.h))

class Quadtree:
	MAXDEPTH = 20
	MAXITEMS = 4
	NE = 0
	NW = 1
	SW = 2
	SE = 3
	def __init__(self, bound, depth):
		self.bound		= bound
		self.depth		= depth
		self.items		= []
		self.children = None
	def insert(self, point, value):
		if not self.bound.contains(point): return False

		if len(self.items) < Quadtree.MAXITEMS:
			self.items.append({'point':point, 'value':value})
			return True

		if not self.children:
			self.split()

		for c in self.children:
			if c.insert(point, value):
				return True
		return False
	def split(self):
		if self.depth == Quadtree.MAXDEPTH: return False

		c = [0,1,2,3]
		b = self.bound
		hw, hh = b.w/2,  b.h/2

		c[0] = Quadtree(Bound(b.x + hw, b.y,			hw, hh), depth + 1)
		c[1] = Quadtree(Bound(b.x,			b.y,			hw, hh), depth + 1)
		c[2] = Quadtree(Bound(b.x, 			b.y + hh, hw, hh), depth + 1)
		c[3] = Quadtree(Bound(b.x + hw, b.y + hh,	hw, hh), depth + 1)

		self.children = c
		return True




