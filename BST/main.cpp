#include <stdlib.h>
#include <time.h>
#include <iostream>

#include "BinaryTree.h"

int main (int argc, char* argv[]) {
	BinaryTree<int>* tree = new BinaryTree<int>(20);

	srand(time(0));
	for (int i = 0; i < 20; i++)
		tree->insert(rand() % 21 - 10);

	return 0;
}
