#!/usr/bin/node

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
class Node {
	constructor (key, value) {
		this.key	 = key;
		this.value = value;
		this.left  = null;
		this.right = null;
	}
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
class Tree {
	constructor () {
		this.root = null;
	}
	insert (key, value) {
		if (!this.root) {
			this.root = new Node(key, value);
			return true;
		}
		let cursor = this.root;
		while (cursor) {
			if (key === cursor.key) {
				cursor.value = value;
				return true;
			} else if (key < cursor.key) {
				if (!cursor.left) {
					cursor.left = new Node(key, value);
					return true;
				}	
				cursor = cursor.left;
			} else {
				if (!cursor.right) {
					cursor.right = new Node(key, value);
					return true;
				}
				cursor = cursor.right;
			}
		}
		return false;
	}
	contains (key) {
		let cursor = this.root;

		while (cursor) {
			if (key === cursor.key)
				return true;
			else if (key < cursor.key)
				cursor = cursor.left;
			else
				cursor = cursor.right;
		}
		return false;
	}
	find (key) {
		let cursor = this.root;

		while (cursor) {
			if (key === cursor.key)
				return cursor.value;
			else if (key < cursor.key)
				cursor = cursor.left;
			else
				cursor = cursor.right;
		}
		return null;
	}
	pre_order (visit) {
		let cursor = this.root;
		let stack = [];

		while (cursor) {
			visit(cursor);
			stack.push(cursor);
			cursor = cursor.left;
		}
		while (stack.length) {
			cursor = stack.pop();

			if (cursor.right) {
				cursor = cursor.right;

				while (cursor) {
					visit(cursor);
					stack.push(cursor);
					cursor = cursor.left;
				}
			}
		}
	}
	in_order (visit) {
		let cursor = this.root;
		let stack = [];

		while (cursor) {
			stack.push(cursor);
			cursor = cursor.left;
		}
		while (stack.length) {
			cursor = stack.pop();
			visit(cursor);

			if (cursor.right) {
				cursor = cursor.right;

				while (cursor) {
					stack.push(cursor);
					cursor = cursor.left;
				}
			}
		}
	}
	post_order (visit) {
		// Source: http://articles.leetcode.com/binary-tree-post-order-traversal/
		if (!this.root) {return;}
		let cursor = this.root;
		let previous = null;
		let stack = [];

		stack.push(cursor);
		while (stack.length) {
			cursor = stack[stack.length - 1];
			if (!previous || previous.left === cursor || previous.right === cursor) {
				if (cursor.left)
					stack.push(cursor.left);
				else if (cursor.right)
					stack.push(cursor.right);
			} else if (cursor.left === previous) {
				if (cursor.right)
					stack.push(cursor.right);
			} else {
				visit(cursor);
				stack.pop();
			}
			previous = cursor;
		}
	}
	breadth_order (visit) {
		if (!this.root) {return;}
		let cursor = this.root;
		let queue = [];

		queue.push(cursor);
		while (queue.length) {
			cursor = queue.shift();
			visit(cursor);
			if (cursor.left)
				queue.push(cursor.left);
			if (cursor.right)
				queue.push(cursor.right);
		}
	}
	depth_recurse_helper (cursor, pre_op, in_op, post_op) {
		if (!cursor) {return;}

		if (pre_op) {pre_op(cursor);}
		this.depth_recurse_helper(cursor.left, pre_op, in_op, post_op);
		if (in_op) {in_op(cursor);}
		this.depth_recurse_helper(cursor.right, pre_op, in_op, post_op);
		if (post_op) {post_op(cursor);}

		return;
	}
	depth_recurse (pre_op, in_op, post_op) {
		this.depth_recurse_helper(this.root, pre_op, in_op, post_op);
	}
}

///////////////////////////////////////////////////////////////////////////////
/*|=====================|*\
|=|		Testing						|=|
\*|=====================|*/
///////////////////////////////////////////////////////////////////////////////

let r = () => Math.floor(Math.random() * 100);
let tree = new Tree();

for (let i = 0; i < 100; i++) {
	let n = r();
	tree.insert(n, n);
}

let array = []
tree.in_order(x => array.push(x.value));
console.log(...array);

let prev = array[0];
for (let x of array) {
	if (prev > x)
		console.log("FAIL!")
	prev = x;
}

array = [];
tree.pre_order(x => array.push(x.value));
console.log(...array);

array = [];
tree.post_order(x => array.push(x.value));
console.log(...array);

console.log(tree.contains(array[5]));
console.log(tree.find(array[5]));

tree = new Tree();

for (let i = 0; i < 10000000; i++) {
	let n = r();
	tree.insert(n, n);
}

let [start, finish] = [0, 0];

start = process.hrtime();
tree.pre_order(x => x);
finish = process.hrtime(start);
console.log(start, finish);

start = process.hrtime();
tree.depth_recurse(null, null, null);
finish = process.hrtime(start);
console.log(start, finish);


