import os
import sys
import numpy as np
import time
import random


def update_dist(perm, dist, N):
	for i in range(N):
		for j in range(i+1,N):
			dist[perm[i]][perm[j]] += 1
	return dist

def generation_shuffles(nbIter,N,nbShuffles):

	w = np.zeros((N, N))
	filename = 'aleaShuffles-' + str(N) + '-' + str(nbShuffles)  +'-ex'
	filename = filename + str(nbIter) + '.dat'

	r = np.arange(0, N, 1)
	for i in range(nbShuffles):
		random.shuffle(r)
		w=update_dist(r, w, N)

	with open(filename, 'w', newline='') as f:
		f.write ('nbGenes = ')
		f.write (str(N))
		f.write(';\n')

		f.write ('preference = [')
		for i in range (N) :
			f.write ('[')
			for j in range (N):
				f.write(str(int(w[i][j])))
				f.write(" ") 
			f.write (']\n')
		f.write ('];\n')

N = int(sys.argv[1])
nbEx=30
nbShuffles = int(min(N/2,20))
for it in range (1, nbEx+1):
	generation_shuffles(it,N,nbShuffles)
