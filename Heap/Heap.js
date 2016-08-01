#!/usr/bin/node

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
class Heap {
	constructor (heap = []) {
		this.heap = heap;

		if (this.heap.length)
			Heap.heapify(this.heap);
	}
	get size () {return this.heap.length;}
	get isEmpty () {return !!this.size;}
	peak () {return this.heap[0];}
	push (key, value) {
		this.heap.push([key, value]);

		Heap.bubble_up(this.heap);
	}
	pop () {
		let [a, end] = [this.heap, this.size - 1];
		[a[0], a[end]] = [a[end], a[0]];

		Heap.bubble_down(a, 0, end - 1);

		return a.pop();
	}
	static bubble_up (a) {
		let child = a.length - 1;
		let parent = Math.floor((child-1) / 2);

		while (parent >= 0) {
			if (a[parent][0] < a[child][0]) {
				[a[parent], a[child]] = [a[child], a[parent]];
				child = parent;
				parent = child
			} else {
				return;
			}
		}
	}
	static bubble_down (a, begin, end) {
		let root = begin;
		let child = root * 2 + 1;

		while (child <= end) {
			if (child + 1 <= end && a[child][0] < a[child + 1][0])
				child += 1;
			if (a[root][0] < a[child][0]) {
				[a[root], a[child]] = [a[child], a[root]];
				root = child;
				child = root * 2 + 1;
			} else {
				return;
			}
		}
	}
	static heapify (a) { // max
		let end = a.length - 1;
		let begin = Math.floor((end - 1) / 2);

		while (begin >= 0) {
			Heap.bubble_down(a, begin, end);
			begin--;
		}
	}
	static sort (a) {
		let end = a.length - 1;

		Heap.heapify(a);

		while (end) {
			[a[0], a[end]] = [a[end], a[0]];
			end--;
			Heap.bubble_down(a, 0, end);
		}

		return a;
	}
}

///////////////////////////////////////////////////////////////////////////////
/*|=====================|*\
|=|		Testing						|=|
\*|=====================|*/
///////////////////////////////////////////////////////////////////////////////
let heap = new Heap([ [5,5], [10,10], [1,1], [2,2], [8,8], [9,9], [4,4], [3,3], [6,6], [0,0] ]);
let a = [];
console.log(...heap.heap);
while (heap.size) {
	a.push(heap.pop());
}
console.log(...a);
a = [ [5,5], [10,10], [1,1], [2,2], [8,8], [9,9], [4,4], [3,3], [6,6], [0,0] ];
console.log(...a);
console.log(...Heap.sort(a));






