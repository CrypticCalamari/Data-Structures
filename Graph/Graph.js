class Node {
	constructor (id, name) {
		this.id = id;
		this.name = name;
	}
}
class Edge {
	constructor (begin, end, weight) {
		this.begin = begin;
		this.end = end;
		this.weight = weight;
	}
}
class Graph {
	constructor () {
		this.nodes = new Map();
		this.edges = [];
	}
	add_node (id, name) {
		let node = new Node (id, name);
		this.nodes.set (id, node);
	}
	remove_node (id) {
		this.nodes.remove (id);
	}
	add_edge (begin, end, weight) {
		let edge = new Edge (begin, end, weight);
		this.edges.push (edge);
	}
}






