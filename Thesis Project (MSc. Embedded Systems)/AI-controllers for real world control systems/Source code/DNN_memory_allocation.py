import tracemalloc
total_mem = 0

###########################################################
tracemalloc.start()
import numpy as np
np.seterr(divide='ignore', invalid='ignore')
current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nImporting Numpy:\nCurrent memory usage: {current / 10**3}KB; Peak was {peak / 10**3}KB")


tracemalloc.start()


W_in =  np.array([  [ 0.11461077, -0.3697621 ,  0.10400589, -0.11454074],
                [-0.18839985,  0.31337667, -0.60840565, -0.5349919 ],
                [ 0.29665115,  0.19026154, -0.6677806 , -1.1758463 ],
                [-0.7560361 , -0.6992475 , -0.6915339 , -2.4271305 ]   ])

B_in = np.array([-0.383155,    0.18754806,  0.20664616,  0.81599957])


W_out = np.array( [ [ 0.15373227,  0.5074667 ],
                    [ 0.61700517,  0.12173132],
                    [ 0.22322866, -0.85645324],
                    [ 1.4515272 , -1.8626738 ] ] )

B_out = np.array( [-0.986495,   1.9170963])

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nSetting parameters:\nCurrent memory usage: {current / 10**3}KB; Peak was {peak / 10**3}KB")

tracemalloc.start()

def forward(X, W_in, B_in, W_out, B_out):
    #forward propagation through our network
    o1 = relu(np.dot(X, W_in) + B_in)
    o2 = softmax(np.dot(o1, W_out) + B_out)
    # return np.array(list(map(softmax,o2)))
    return o2

def relu(s):
    # activation function
    s[s <= 0] = 0
    return s

def softmax(x):
    """Compute softmax values for each sets of scores in x."""
    return np.exp(x) / np.sum(np.exp(x), axis=0) 

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nDeclaring functions:\nCurrent memory usage: {current / 10**3}KB; Peak was {peak / 10**3}KB")

tracemalloc.start()

steps = 1
np.random.seed(0)

# List of all states that will be inputted to network
state_list = list(np.random.uniform(low = -0.5, high = 0.5, size = (4,)) for i in range(steps+1))

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nSetting up states:\nCurrent memory usage: {current / 10**3}KB; Peak was {peak / 10**3}KB")

tracemalloc.start()

for episode in range(1):

    state = state_list[0]

    for i in range (steps):

        out = (forward(state.reshape(4,), W_in, B_in, W_out, B_out)) # Calculating Action

        action = np.argmax(out)     # Choose Action
        
        state = state_list[i+1]

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nFeedforwarding:\nCurrent memory usage is {current / 10**3}KB; Peak was {peak / 10**3}KB")

print('\n\n \x1b[1;32;40m Total memory consumption of  DNN \x1b[0m: ',total_mem/ 10**3,' KB')
############################################################




