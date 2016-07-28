#!/usr/bin/node

class BinaryTree {
	constructor (item) {
		this.item = item;
		this.left = undefined;
		this.right = undefined;
	}
	insert (item) {
		if (item < this.item) {
			if (this.left !== undefined) {
				this.left.insert(item);
			} else {
				this.left = new BinaryTree(item);
			}
		}
		if (item > this.item) {
			if (this.right !== undefined) {
				this.right.insert(item);
			} else {
				this.right = new BinaryTree(item);
			}
		}
	}
	contains (item) {
		if (this.item === item) {
			return true;
		}
		if (item < this.item) {
			if (this.left !== undefined) {
				return this.left.contains(item);
			}
		} else {
			if (this.right !== undefined) {
				return this.right.contains(item);
			}
		}
		return false;
	}
	range_query (range) {
		let found = [];
		if (this.item >= range[0] && this.item <= range[1]) {
			found.push(this.item);
		}
		if (this.left !== undefined) {
			if (this.item >= range[0]) {
				found.push(...this.left.range_query(range));
			}
		}
		if (this.right !== undefined) {
			if (this.item <= range[1]) {
				found.push(...this.right.range_query(range));
			}
		}
		return found;
	}
}
let randInt = function(min, max) {
	return Math.floor(Math.random() * (max - min + 1)) + min;
}
let b = new BinaryTree(randInt(0,1000));
for (let i = 0; i < 100; i++) {
	b.insert(randInt(0,1000));
}
let count = 0;
for (let i = 0; i < 1000; i++) {
	if (b.contains(i)) {
		count++;
		console.log(`${i}: `, b.contains(i));
	}
}
let d = b.range_query([0,1000]);
console.log(...d);
console.log(`count: ${count}`);
console.log(`length: ${d.length}`);






