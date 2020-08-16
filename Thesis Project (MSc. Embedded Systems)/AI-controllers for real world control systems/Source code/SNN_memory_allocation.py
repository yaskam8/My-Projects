import tracemalloc
total_mem = 0

import winsound as win

win.Beep(1000, 1000)
win.Beep(2000, 1000)
win.Beep(3000, 1000)
quit()

###########################################################
tracemalloc.start()
import numpy as np
np.seterr(divide='ignore', invalid='ignore')

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nImporting Numpy:\nCurrent memory usage: {current / 10**3}KB; Peak was {peak / 10**3}KB")


tracemalloc.start()

W_in =  np.array([  [ 0.49769148 ,-0.39565456, -1.0245117 , -0.95091075],
                    [ 0.1492962  ,-0.58698267,  0.09589989, -0.51850975],
                    [ 0.8256361  ,-2.3372893 , -0.08185427, -2.4135733 ],
                    [ 0.92475915 ,-1.0290308 ,  0.636336  , -1.5293345 ]])

B_in = np.array( [0.4530926,  0.71787626, 0.5692956,  0.46604502])

W_out = np.array(  [[-1.3989748,  1.1025736],
                    [ 1.2433444, -2.9087892],
                    [-1.5018557,  1.7126988],
                    [ 1.218404 , -0.5891591]] )

B_out = np.array([-0.2192497,   0.15517464])

# internal state
hidden_mem = np.random.rand(4).reshape(1,4)*.3
hidden_spike = np.zeros(4).reshape(1,4)

output_mem = np.random.rand(2).reshape(1,2)*.3
output_spike = np.zeros(2).reshape(1,2)

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nSetting parameters:\nCurrent memory usage: {current / 10**3}KB; Peak was {peak / 10**3}KB")

tracemalloc.start()

def forward(X, W_in, B_in, W_out, B_out):
        global hidden_mem, hidden_spike, output_mem, output_spike
        #forward propagation through our network
        act1 = np.dot(X, W_in) + B_in
        # print('act1:',act1)
        hidden_mem,hidden_spike = LIF(act1[0],hidden_mem,hidden_spike)
        act2 = np.dot(hidden_spike, W_out) + B_out
        output_mem,output_spike = LIF(act2,output_mem,output_spike)
        act = softmax(output_mem)
        # return np.array(list(map(softmax,o2)))
        return act

def LIF(x,mem,spike,tau_m=7,R = 3,theta=.5):
    # print(R,x)
    d_mem = -(mem) + R*x
    mem = mem + d_mem/tau_m
    spike = (mem>theta)*1.
    mem = mem*(1-spike)
    return mem,spike

def softmax(x):
    """Compute softmax values for each sets of scores in x."""
    return np.exp(x) / np.sum(np.exp(x), axis=1)     

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

        out = (forward(state.reshape(1,4), W_in, B_in, W_out, B_out)) # Calculating Action

        action = np.argmax(out)     # Choose Action
        # print(out, action)
        state = state_list[i+1]

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()
total_mem += current
print(f"\nFeedforwarding:\nCurrent memory usage is {current / 10**3}KB; Peak was {peak / 10**3}KB")

print('\n\n \x1b[1;32;40m Total memory consumption of  SNN \x1b[0m: ',total_mem/ 10**3,' KB')
############################################################




