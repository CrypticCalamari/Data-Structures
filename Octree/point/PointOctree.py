#!/usr/bin/python3

from collections import namedtuple

###############################################################################
####	Point		#################################################################
###############################################################################
class Point(namedtuple("Point", ['x', 'y', 'z'])):
	def __lt__(self, other):
		return (self.x < other.x and
						self.y < other.y and
						self.z < other.z)
	def __gt__(self, other):
		return (self.x > other.x and
						self.y > other.y and
						self.z > other.z)
	def __add__(self, other):
		return Point(self.x + other.x, self.y + other.y, self.z + other.z)
	def __truediv__(self, num):
		return Point(self.x / num, self.y / num, self.z / num)
	def __floordiv__(self, num):
		return Point(self.x // num, self.y // num, self.z // num)
###############################################################################
####	Bound		#################################################################
###############################################################################
class Bound(namedtuple("Bound", ["point", "extent"])):
	def	contains(self, point):
		return self.point <= point <= self.point + self.extent
	def intersects(self, bound):
		return (self.point <= bound.point + bound.extent and
						bound.point <= self.point + self.extent)

###############################################################################
####	Exceptions	#############################################################
###############################################################################
class MaxDepthException(BaseException):
	pass

###############################################################################
####	Octree	#################################################################
###############################################################################
class Octree:
	MAX_DEPTH = 20
	MAX_ITEMS = 4
	def __init__(self, bound, depth=0):
		self.bound = bound
		self.depth = depth
		self.size = 0
		self.items = set()
		self.children = []
	def split(self):
		if self.depth == Octree.MAX_DEPTH:
			raise MaxDepthException()
		if len(self.children):
			return
		b = self.bound
		p = b.point
		e = b.extent / 2
		p2 = b.point + e
		self.children.extend((
			Octree(b._replace(extent=e), self.depth + 1),
			Octree(b._replace(point=p._replace(x=p2.x), extent=e), self.depth + 1),
			Octree(b._replace(point=p._replace(y=p2.y), extent=e), self.depth + 1),
			Octree(b._replace(point=p._replace(z=p2.z), extent=e), self.depth + 1),
			Octree(b._replace(point=p._replace(x=p2.x, y=p2.y), extent=e), self.depth + 1),
			Octree(b._replace(point=p._replace(x=p2.x, z=p2.z), extent=e), self.depth + 1),
			Octree(b._replace(point=p._replace(y=p2.y, z=p2.z), extent=e), self.depth + 1),
			Octree(b._replace(point=p2, extent=e), self.depth + 1)))
	def insert(self, point, value):
		if not self.bound.contains(point):
			return False

		if len(self.items) < Octree.MAX_ITEMS:
			self.items.add((point, value))
			return True

		self.split()

		for c in self.children:
			if c.insert(point, value):
				return True

		return False
			
	def range_query(self, bound):
		found = []
		stack = []
		stack.append(self)
		
		while len(stack):
			cursor = stack.pop()

			for i in cursor.items:
				if bound.contains(i[0]):
					found.append(i)

			for c in cursor.children:
				if bound.intersects(c):
					stack.append(c)

		return found

###############################################################################
####	Testing	#################################################################
###############################################################################
p1 = Point(1,2,3)
p2 = Point(3,2,1)
print(p1.x)
print(p1[2])
print(p1 + p2)

b1 = Bound(Point(0,0,0),				Point(100,100,100))
b2 = Bound(Point(50,50,50),			Point(10,10,10))
b3 = Bound(Point(110,110,110),	Point(1,1,1))

print(b1.intersects(b2))
print(b1.intersects(b3))

o = Octree(Bound(Point(0,0,0), Point(128,128,128)))
o.split()
print(o.children[0].bound)
print(o.children[1].bound)
print(o.children[2].bound)
print(o.children[3].bound)
print(o.children[4].bound)
print(o.children[5].bound)
print(o.children[6].bound)
print(o.children[7].bound)

o.insert(Point(2,50,100), "Test")
o.insert(Point(100,50,100), "Test")
o.insert(Point(10,50,100), "Test")
o.insert(Point(65,50,100), "Test")
o.insert(Point(2,67,100), "Test")











