#!/usr/bin/python3

import random

class Heap:
	def __init__(self):
		self.heap = []
	
	def size(self):			return len(self.heap)
	def isEmpty(self):	return not len(self.heap)
	def peak(self):
		if len(self.heap) != 0:
			return self.heap[0]
	def push(self, key, value):
		self.heap.append({'key':key, 'value':value})
		Heap.bubbleup(self.heap)
	def pop(self):
		a, end = self.heap, len(self.heap) - 1
		a[0], a[end] = a[end], a[0]

		Heap.bubbledown(a, 0, end - 1)

		return a.pop()
	@staticmethod
	def bubbleup(a):
		child = len(a) - 1
		parent = (child - 1) // 2

		while parent >= 0:
			if a[parent]['key'] < a[child]['key']:
				a[parent], a[child] = a[child], a[parent]
				child = parent
				parent = (child - 1) // 2
			else:
				return
	@staticmethod
	def bubbledown(a, begin, end):
		root = begin
		child = root * 2 + 1

		while child <= end:
			if (child + 1 <= end) and (a[child]['key'] < a[child + 1]['key']):
				child += 1

			if a[root]['key'] < a[child]['key']:
				a[root], a[child] = a[child], a[root]
				root = child
				child = root * 2 + 1
			else:
				return
	@staticmethod
	def heapify(a):
		end = len(a) - 1
		begin = (end - 1) // 2

		while begin >= 0:
			Heap.bubbledown(a, begin, end)
			begin -= 1

		return a
	@staticmethod
	def sort(a):
		end = len(a) - 1

		Heap.heapify(a)

		while end > 0:
			a[0], a[end] = a[end], a[0]
			end -= 1
			Heap.bubbledown(a, 0, end)

		return a

"""////////////////////////////////////////////////////////////////////////////
/*|=====================|*\
|=|		Testing						|=|
\*|=====================|*/
////////////////////////////////////////////////////////////////////////////"""

test = Heap()
test.push(1,10)

print(test.peak())

for i in range(20):
	r = random.randint(0, 100)
	test.push(r, r*10)

print(test.peak())

t = []
while not test.isEmpty():
	t.append(test.pop()['key'])

print(t)












