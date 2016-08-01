#ifndef __BINARYTREE_H_INCLUDED__
#define __BINARYTREE_H_INCLUDED__

template <class T>
class BinaryTree {
	public:
		BinaryTree(T);
		
		bool insert(T);
		bool remove(T);

		T get_min();
		T get_max();
	private:
		T item;
		BinaryTree<T>* left_child;
		BinaryTree<T>* right_child;
};

#include "BinaryTree.cpp"

#endif
