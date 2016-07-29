#!/usr/bin/node

class BinaryHeap {
	constructor (max = true) {
		this.heap = [];
		this.max = max;
	}
	get size () {return this.heap.length;}
	get isEmpty () {return this.heap.length === 0;}
	peak () {
		if (this.heap.length > 0)
			return this.heap[0];
		else
			return null;
	}
	push (item) {
		this.heap.push(item);
		if (this.heap.length > 1) {
			this.bubble_up();
		}
	}
	pop () {
		if (this.heap.length > 0) {
			let temp = this.heap[0];

			if (this.heap.length > 1) {
				this.heap[0] = this.heap.pop();
				this.bubble_down();
			}
			else
				this.heap.pop();

			return temp;
		}
		return null;
	}
	bubble_up () {
		let heap = this.heap;
		let cursor = heap.length - 1;
		let parent = Math.floor((cursor - 1) / 2);
		let compare = (this.max) ? ((x,y) => x > y) : ((x,y) => x < y);

		while (parent >= 0) {
			if (compare(heap[cursor], heap[parent])) {
				[heap[cursor], heap[parent]] = [heap[parent], heap[cursor]];
				cursor = parent;
				parent = Math.floor((parent - 1) / 2);
			}
			else {
				break;
			}
		}
	}
	bubble_down () {
		let heap = this.heap;
		let [parent, left, right] = [0, 1, 2];
		let compare = (this.max) ? ((x,y) => x > y) : ((x,y) => x < y);

		while ((2*parent + 1) < heap.length) {
			if (right < heap.length) {
				if (compare(heap[left], heap[right])) {
					[heap[parent], heap[left]] = [heap[left], heap[parent]];
					parent = left;
				} else {
					[heap[parent], heap[right]] = [heap[right], heap[parent]];
					parent = right;
				}
			} else {
				[heap[parent], heap[left]] = [heap[left], heap[parent]];
				break;
			}
			left = 2*parent + 1;
			right = 2*parent + 2;
		}
	}
}





/*|=====================|*\
|=|		Testing						|=|
\*|=====================|*/


heap = new BinaryHeap(false);
console.log(heap.size);
console.log(heap.isEmpty);
console.log(heap.peak());

for (let i = 0; i < 15; i++) {
	heap.push(i);
}
console.log(...heap.heap);

while (!heap.isEmpty) {
	console.log(heap.heap);
	console.log(heap.pop());
	console.log(heap.heap);
}

for (let i = 0; i < 10; i++) {
	heap.push(Math.floor(Math.random() * 250) + 500);
}

let ordered = [];
while (!heap.isEmpty) {
	ordered.push(heap.pop());
}
console.log(...ordered);









