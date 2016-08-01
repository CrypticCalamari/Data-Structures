#ifndef __BINARYTREE_CPP_INCLUDED__
#define __BINARYTREE_CPP_INCLUDED__

#include "BinaryTree.h"

template <class T>
BinaryTree<T>::BinaryTree(T item) {
	this->item = item;
	this->left_child = 0;
	this->right_child = 0;
}

template <class T>
bool BinaryTree<T>::insert(T item) {
	if (item <= this->item) {
		if (this->left_child != 0) {
			this->left_child->insert(item);
			return true;
		} else {
			this->left_child = new BinaryTree(item);
			return true;
		}
	} else {
		if (this->right_child != 0) {
			this->right_child->insert(item);
			return true;
		} else {
			this->right_child = new BinaryTree(item);
			return true;
		}
	}

	return false;
}

template <class T>
bool BinaryTree<T>::remove(T item) {
	BinaryTree<T>* parent = this;
	BinaryTree<T>* found = 0;

	if (found) {
		
	}

	return false;
}

#endif


