#!/usr/bin/python3

class AABB:
	def __init__(self, point, extent):
		self.point = point
		self.extent = extent

	@staticmethod
	def contains(aabb, point):
		if len(aabb.point) != len(point): return False
		for i in range(len(point)):
			if (point[i] > aabb.point[i] and
					point[i] < aabb.point[i] + aabb.extent[i]):
				return True
		return False
	@staticmethod
	def intersects(r1, r2):
		for i in range(len(r1)):
			if ((r1.point[i] > r2.point[i] + r2.extent[i]) or
					(r2.point[i] > r1.point[i] + r1.extent[i])):
				return False
		return True
