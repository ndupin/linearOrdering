import os
import sys
import numpy as np
import time
import random

def generation_naive(nbIter,N):

	w = np.zeros((N, N))
	filename = 'aleaSum100-' + str(N) +'-ex'
	filename = filename + str(nbIter) + '.dat'

	for i in range (0, N):
		for j in range (0, N):
			if (i == j):
				w[i][j] = 0

			elif (i < j) :
				x = random.uniform(0, 1)
				w[i][j] = int(100 * x)

			else :
				w[i][j] = 100 - w[j][i]

	print (w)

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
for it in range (1, nbEx+1):
	generation_naive(it,N)
