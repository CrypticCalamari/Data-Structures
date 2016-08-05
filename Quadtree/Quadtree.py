#!/usr/bin/python3

import random

class Point:
	def __init__(self, x, y):
		self.x = x
		self.y = y
	def __str__(self):
		return "(" + str(self.x) + "," + str(self.y) + ")"
	def __repr__(self):
		return "(" + str(self.x) + ", " + str(self.y) + ")"

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
	def __init__(self, bound, depth=0):
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
	def rangequery(self, bound):
		cursor = self
		stack = []
		found = []
		stack.append(self)
		
		while len(stack):
			cursor = stack.pop()
			for i in cursor.items:
				if bound.contains(i['point']):
					found.append(i['point'])
				if cursor.children:
					for c in cursor.children:
						stack.append(c)
		return found
	def split(self):
		if self.depth == Quadtree.MAXDEPTH: return False

		c = [0,1,2,3]
		b = self.bound
		hw, hh = b.w/2,  b.h/2

		c[0] = Quadtree(Bound(b.x + hw, b.y,			hw, hh), self.depth + 1)
		c[1] = Quadtree(Bound(b.x,			b.y,			hw, hh), self.depth + 1)
		c[2] = Quadtree(Bound(b.x, 			b.y + hh, hw, hh), self.depth + 1)
		c[3] = Quadtree(Bound(b.x + hw, b.y + hh,	hw, hh), self.depth + 1)

		self.children = c
		return True




""" Testing """
test = Quadtree(Bound(0,0,128,256))
a = []

for i in range(20):
	a.append(Point(random.randint(0,128), random.randint(0,256)))
	test.insert(a[i], "test")

print(a)
print()
print(test.rangequery(Bound(0,0,64,64)))








