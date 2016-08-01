#!/usr/bin/node

class Point {
	static equals (p1, p2) {
		if (p1.length !== p2.length)
			return false;
		for (let i = 0; i < p1.length; i++)
			if (p1[i] !== p2[i])
				return false;

		return true;
	}
	static random(s, range) {
		if (s < 1)
			return null;

		let point = [];
		while (s--)
			point.push(Math.random() * (range[1] - range[2] + 1) + range[0]);

		return point;
	}
}
class Range {
	static contains (range, point) {
		for (let i = 0; i < point.length; i++) {
			if (point[i] < range.point[i])
				return false;
			if (point[i] > range.point[i] + range.extent[i])
				return false;
		}
		return true;
	}
	static intersects (r1, r2) {
		for (let i = 0; i < point.length; i++)
			if ((r1.point[i] > r2.point[i] + r2.extent[i]) || (r1.point[i] + r1.extent[i] < r2.point[i]))
				return false;

		return true;
	}
}
class Node {
	constructor (point, thing) {
		this.point = point;
		this.thing = thing;
		this.left	 = null;
		this.right = null;
	}
}
class KDTree {
	constructor () {
		this.depth = depth;
		this.root = null;
	}
	insert (point, thing) {
		if (point.length !== this.point.length)
			return false;
		
		let d = this.depth % point.length;
		let cursor = this;

		while (true) {
			if (point[d] <= cursor.point[d]) {
				if (cursor.left) {
					cursor = cursor.left;
				} else {
					cursor.left = new KDTree(point, thing, cursor.depth + 1);
					return true;
				}
			} else {
				if (cursor.right) {
					cursor = cursor.right
				} else {
					cursor.right = new KDTree(point, thing, cursor.depth + 1);
					return true;
				}
			}
		}
		return false;
	}
	remove () {
		
	}
	range_query (range) {
		let found = [];
		let cursor = this;

		
	}
	breadth_op (f) {
		let q = [];
		let cursor = this;

		while (cursor) {
			if (cursor.left)
				q.push(cursor.left);
			if (cursor.right)
				q.push(cursor.right);

			f(cursor);
			cursor = q.shift();
		}
	}
}










let r = () => Math.random() * 100;
let tree = new KDTree([r(), r(), r()], "FIRST!");
tree.insert([r(),r(),r()], "SECOND!");

let array = [];
for (let i = 0; i < 10000; i++) {
	let p = [r(), r(), r()];
	array.push(p);
	tree.insert([r(), r(), r()], p.toString());
}

tree.breadth_op( x => console.log(x.depth, x.point) );



