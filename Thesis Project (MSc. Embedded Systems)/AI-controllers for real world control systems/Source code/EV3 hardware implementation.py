#!/usr/bin/env python3

from ev3dev.ev3 import *
import time
from time import sleep,time,clock 
from statistics import mean
import os
from ev3dev2.motor import LargeMotor, MediumMotor, OUTPUT_A, OUTPUT_B, OUTPUT_C, OUTPUT_D, SpeedPercent, MoveTank
from ev3dev2.sensor.lego import GyroSensor, UltrasonicSensor 
from ev3dev2.sensor import INPUT_1, INPUT_2, INPUT_3, INPUT_4
from ev3dev2.sound import Sound
# from ev3dev2.led import Leds
import numpy as np
import math
from scipy import stats

config_file = np.load('outfile.npy',allow_pickle=True) 

class Neural_Network(object):
    def __init__(self):      
        #parameters
        self.inputSize = 4
        self.hiddenSize = 4
        self.outputSize = 2
        self.W = []
        self.B = []
        self.tau_m = []
        self.R = []
        # Weights & Biases
        self.W.append(np.random.randn(self.inputSize, self.hiddenSize))    # Initializing W[0]
        self.W.append(np.random.randn(self.hiddenSize, self.outputSize) )  # Initializing W[1]
        self.B.append(np.random.randn(self.hiddenSize))                    # Initializing B[0]
        self.B.append(np.random.randn(self.outputSize))                     # Initializing B[1]
        
        # internal state
        self.hidden_mem = np.random.rand(self.hiddenSize).reshape(1,4)*.3
        self.hidden_spike = np.zeros(self.hiddenSize).reshape(1,4)

        self.output_mem = np.random.rand(self.outputSize).reshape(1,2)*.3
        self.output_spike = np.zeros(self.outputSize).reshape(1,2)
        
        # config_file = np.load('./lif_npy_agents/180_agent.npy',allow_pickle=True)
        
        self.W[0] = config_file[0].T     # Copying W[0] from saved file
        self.B[0] = config_file[1].reshape(-1)      # Copying B[0] from saved file
        self.W[1] = config_file[2].T     # Copying W[1] from saved file
        self.B[1] = config_file[3].reshape(-1)      # Copying B[1] from saved file

        
        for j in range(2):      # Printing loaded weights and biases
            print("W[j]:",np.shape(self.W[j]),"  \n",self.W[j])
            print("B[j]:",np.shape(self.B[j]),"  \n",self.B[j])

    def forward(self, X):
        #forward propagation through our network
        self.act1 = np.dot(X, self.W[0]) + self.B[0]
        # print('act1:',self.act1)
        self.hidden_mem,self.hidden_spike = self.LIF(self.act1[0],self.hidden_mem,self.hidden_spike)
        self.act2 = np.dot(self.hidden_spike, self.W[1]) + self.B[1]
        self.output_mem,self.output_spike = self.LIF(self.act2,self.output_mem,self.output_spike)
        self.act = self.softmax(self.output_mem)
        # return np.array(list(map(self.softmax,self.o2)))
        return self.act

    def LIF(self,x,mem,spike,tau_m=7,R = 3,theta=.5):
        # print(R,x)
        d_mem = -(mem) + R*x
        mem = mem + d_mem/tau_m
        spike = (mem>theta)*1.
        mem = mem*(1-spike)
        return mem,spike

    def softmax(self,x):
        """Compute softmax values for each sets of scores in x."""
        return np.exp(x) / np.sum(np.exp(x), axis=1) 

class Neural_Network1(object):
    def __init__(self):      
        #parameters
        self.inputSize = 4
        self.hiddenSize1 = 4
        self.outputSize = 2
        self.W = []
        self.B = []
        self.tau_m = []
        self.R = []
        # Weights & Biases
        self.W.append(np.random.randn(self.inputSize, self.hiddenSize1))    # Initializing W[0]
        self.W.append(np.random.randn(self.hiddenSize1, self.outputSize) )  # Initializing W[1]
        self.B.append(np.random.randn(self.hiddenSize1))                    # Initializing B[0]
        self.B.append(np.random.randn(self.outputSize))                     # Initializing B[1]
        self.tau_m.append(np.random.randn(self.hiddenSize1))                     # Initializing tau_m[0]
        self.tau_m.append(np.random.randn(self.outputSize))                     # Initializing tau_m[1]
        self.R.append(np.random.randn(self.hiddenSize1))                     # Initializing R[0]
        self.R.append(np.random.randn(self.outputSize))                     # Initializing R[1]
        
        # internal state
        self.hidden_mem = np.random.rand(self.hiddenSize1)*.3
        self.hidden_spike = np.zeros(self.hiddenSize1)

        self.output_mem = np.random.rand(self.outputSize)*.3
        self.output_spike = np.zeros(self.outputSize)
        
        # config_file = np.load('./lif_npy_agents/26_agent.npy',allow_pickle=True)
        self.tau_m[0] = config_file[0]
        self.tau_m[1] = config_file[1]
        self.R[0] = config_file[2]
        self.R[1] = config_file[3]
        
        self.W[0] = config_file[4].T      # Copying W[0] from saved file
        self.B[0] = config_file[5].reshape(-1)      # Copying B[0] from saved file
        self.W[1] = config_file[6].T      # Copying W[1] from saved file
        self.B[1] = config_file[7].reshape(-1)      # Copying B[1] from saved file

        
        for j in range(2):      # Printing loaded weights and biases
            print("W[j]:",np.shape(self.W[j]),"  \n",self.W[j])
            print("B[j]:",np.shape(self.B[j]),"  \n",self.B[j])

    def forward(self, X):
        #forward propagation through our network
        self.o1 = np.dot(X, self.W[0]) + self.B[0]
        # print('o1:',self.o1)
        self.hidden_mem,self.hidden_spike = self.LIF(self.o1,self.hidden_mem,self.hidden_spike,self.tau_m[0],self.R[0])
        self.o2 = np.dot(self.hidden_spike, self.W[1]) + self.B[1]
        self.output_mem,self.output_spike = self.LIF(self.o2,self.output_mem,self.output_spike,self.tau_m[1],self.R[1])
        self.act = self.softmax(self.output_mem)
        # return np.array(list(map(self.softmax,self.o2)))
        return self.act

    def LIF(self,x,mem,spike,tau_m=7,R = 3,theta=.5):
        d_mem = -(mem) + R*x
        mem = mem + d_mem/tau_m
        spike = (mem>theta)*1.
        mem = mem*(1-spike)
        return mem,spike

    def softmax(self,x):
        """Compute softmax values for each sets of scores in x."""
        return np.exp(x) / np.sum(np.exp(x), axis=1) 

class Neural_Network2(object):
    def __init__(self):      
        #parameters
        self.inputSize = 4
        self.hiddenSize = 4
        self.outputSize = 2
        self.W = []
        self.B = []
        self.tau_m = []
        self.R = []
        # Weights & Biases
        self.W.append(np.random.randn(self.inputSize, self.hiddenSize))    # Initializing W[0]
        self.W.append(np.random.randn(self.hiddenSize, self.outputSize) )  # Initializing W[1]
        self.B.append(np.random.randn(self.hiddenSize))                    # Initializing B[0]
        self.B.append(np.random.randn(self.outputSize))                     # Initializing B[1]
        
        # internal state
        self.hidden_mem = np.random.rand(self.hiddenSize).reshape(1,4)*.3
        self.hidden_spike = np.zeros(self.hiddenSize).reshape(1,4)

        self.output_mem = np.random.rand(self.outputSize).reshape(1,2)*.3
        self.output_spike = np.zeros(self.outputSize).reshape(1,2)
        
        # config_file = np.load('./lif_npy_agents/180_agent.npy',allow_pickle=True)
        
        self.W[0] = config_file[0].T     # Copying W[0] from saved file
        self.B[0] = config_file[1].reshape(-1)      # Copying B[0] from saved file
        self.W[1] = config_file[2].T     # Copying W[1] from saved file
        self.B[1] = config_file[3].reshape(-1)      # Copying B[1] from saved file

        
        for j in range(2):      # Printing loaded weights and biases
            print("W[j]:",np.shape(self.W[j]),"  \n",self.W[j])
            print("B[j]:",np.shape(self.B[j]),"  \n",self.B[j])

    def forward(self, X):
        #forward propagation through our network
        self.act1 = np.dot(X, self.W[0]) + self.B[0]
        # print('act1:',self.act1)
        self.hidden_mem,self.hidden_spike = self.LIF(self.act1[0],self.hidden_mem,self.hidden_spike)
        self.act2 = np.dot(self.hidden_spike, self.W[1]) + self.B[1]
        self.output_mem,self.output_spike = self.LIF(self.act2,self.output_mem,self.output_spike)
        self.act = self.softmax(self.output_mem)
        return (self.act)

    def LIF(self,x,mem,spike,tau_m=7,R = 3,theta=.5):
        # print(R,x)
        d_mem = -(mem) + R*x
        mem = mem + d_mem/tau_m
        spike = (mem>theta)*1.
        mem = mem*(1-spike)
        return mem,spike

    def softmax(self,x):
        """Compute softmax values for each sets of scores in x."""
        return np.exp(x) / np.sum(np.exp(x), axis=1) 


DQN = Neural_Network()

print('\033[92m'+'Numpy file loaded successfully!!!'+'\033[0m')

def init(component,comp):
    if comp == 'drive':
        component.off(brake = False)  
        # audio.speak('Drive initialized',volume=20)
    if comp == 'grabber':   
        component.off(brake = False) 
        # audio.speak('Grabber initialized',volume=20)
    if comp == 'jack':      
        component.off(brake = False) 
        # audio.speak('Jack initialized',volume=20)
    if comp == 'G':
        component.mode='GYRO-RATE'
        component.mode='GYRO-ANG'
        sleep(0.05)
        component.mode='GYRO-RATE'
        component.mode='GYRO-ANG'
        # component.mode='GYRO-G&A'
        audio.play_tone(2000, 0.1, volume=30, play_type=0) 
    if comp == 'U':
        component.mode='US-DIST-CM'
        reference_dist  = component.value()/1000 # in meters when /1000
        # audio.speak('Ultrasonic sensor initialized',volume=20)
        return reference_dist



# Cartpole forward prediction parameters
gravity = 9.8
masscart = 1.93		#1.93
masspole = 0.05 #0.05
total_mass = (masspole + masscart)
length = 0.5		# actually half the pole's length
polemass_length = (masspole * length)
force_mag = 14.0		#14.286256 N by cartpole 14
tau = 0.045 	# seconds between state updates 0.03 using matrix numpy calc.
 

# Defining sensors and motors 
drive = LargeMotor(OUTPUT_A)
grabber = LargeMotor(OUTPUT_B)
jack = MediumMotor(OUTPUT_D)
G = GyroSensor(INPUT_3)
U = UltrasonicSensor(INPUT_1)
audio = Sound()
  
Grabber_angle = 1000 
Jack_angle = 3.9
speed = -100 
balance_ang_limit = 35 * math.pi / 180  # allowed balancing angle limit in degrees each side
balance_x_limit = 1.2    # allowed horizontal movement of cart in x10 cms each side
readings = 500
episodes = 2

summary = []       # To store the Balance time and average loop latency

try:
    for episode in range(501):
        record_latency = [] # container -- [iteration, loop_t, N_t, A_t, G_t, Us_t, S_t, Ns_t, App_t]
        print('######## Episode : ',episode,' ########')
        audio.play_tone(4000, 0.1, volume=1, play_type=0)
    
        init(drive,'drive')
        init(grabber,'grabber')
        init(jack,'jack')
        reference_dist = init(U,'U') 
        record_transitions = []                  # container -- [state, action, reward, state_next, terminal, run]
        
        # audio.speak('Initialized',volume=50)                                                                                                                              
        audio.play_tone(3000, 0.05, volume=1, play_type=0) 
      
    
        # Close and open the grabber  
        grabber.on_for_degrees(-70,Grabber_angle ,brake = True, block = True)
        
        sleep(1)
        jack.on_for_rotations(-100,Jack_angle,brake = True)
        sleep(3)
        
        grabber.on_for_degrees(5,Grabber_angle*0.2,brake = False)
        grabber.on_for_degrees(70,Grabber_angle*0.4 ,brake = False)
        grabber.on_for_degrees(70,Grabber_angle*0.4 ,brake = True, block = False)
    
        sleep(1)  
        init(G,'G')
        print("Gyro angle: ",G.angle)
        while (G.angle != 0): 
            init(G,'G')                             # setting the Gyro sensor to zero i.e. resetting it
            print("Gyro angle: ",G.angle)  
    
        gyro_angle  = G.angle * math.pi/180 
        prev_angle = gyro_angle
        x = reference_dist - (U.value()/1000)
        prev_x = x
        state = np.array([x, 0.0, gyro_angle, 0.0]) # [x, x_dot, theta, theta_dot]

        action_old = 1
  
        jack.on_for_rotations(100,Jack_angle,brake = True, block = False) #releasing the fine tuner


        global_start = time()
        sampling_log_time=time()
        sampling_log_time1=time()
        done = False
        reward = 1
        
        for i in range (readings):
            starttime=time()

            out = (DQN.forward(state.reshape(1,4))[0]) # Calculating Action
            action = np.argmax(out) # Calculating Action
            
            nettime = time()-starttime

            t1 = time()
            if abs(state[2])>balance_ang_limit or abs(state[0]) > balance_x_limit:  #angle keep 40 and x limit as 30
                # audio.speak('Episode ended',volume=20) 
                reward = -1
                done = True
                #break             
            elif action == 0: # [-14,+14]
                drive.on(-speed, brake = False, block = False)
                #drive.on_for_seconds(speed, 1)
                #drive.stop(stop_action = 'coast') 
                # reward = 1   
                # done = False
            # elif action == 1: # [-14,+14]
            #     drive.off(brake = False)
                #drive.on_for_seconds(-speed, 1)
                #drive.stop(stop_action = 'coast')
                # reward = 1   
                # done = False  
            elif action == 1: # [-14,+14]
                drive.on(speed, brake = False, block = False)
                #drive.on_for_seconds(-speed, 1)
                #drive.stop(stop_action = 'coast')
                # reward = 1   
                # done = False  
            ta = time() - t1

            t2 = time()

            gyro_angle  = G.angle * math.pi/180
            if gyro_angle >= prev_angle:
                gyro_rate  = abs(gyro_angle - prev_angle)/(time()- sampling_log_time1)
            else:
                gyro_rate  = -abs(gyro_angle - prev_angle)/(time()- sampling_log_time1)
            prev_angle = gyro_angle
            sampling_log_time1=time()

            t3 = time()

            x = reference_dist - (U.value()/1000)
            if x >= prev_x:
                x_dot = abs(x - prev_x) /(time()- sampling_log_time)
            else:
                x_dot = -abs(x - prev_x) /(time()- sampling_log_time)
            prev_x = x
            sampling_log_time=time()

            t4 = time()

            next_state = np.array([x, x_dot, gyro_angle, gyro_rate])  # [x, x_dot, theta, theta_dot]

            t5 = time()

            record_transitions.append([state[0],state[1],state[2],state[3], action, reward, next_state[0],next_state[1],next_state[2],next_state[3], done, i, action_old, out[0], out[1]])
            
            t6 = time()

            state = next_state
            action_old = action

            endtime=time() 

            record_latency.append([i+1,endtime - starttime, nettime, ta, t3 - t2, t4 - t3, t4 - t2, t5-t4,t6-t5])      
            if done == True:
                Balanced_time = time() - global_start
                break    
    
        drive.off(brake = False) 
    
        # Converting List to array
        array_record_transitions = np.array(record_transitions)
        # Save Numpy array to csv
        np.savetxt('Ep_'+str(episode)+'.csv', array_record_transitions, delimiter=',', fmt=['%1.8f','%1.8f','%1.8f','%1.8f','%d','%d','%1.8f','%1.8f','%1.8f','%1.8f','%d','%d','%d','%1.8f','%1.8f']) 
    
    
        log = np.array(record_latency)
        print("Average loop Latency\t:\t",np.average(log[:,1]))
        # print("Varience loop Latency\t:\t",np.var(log[:,1], dtype=np.float64))
        print("Average Network calculation Latency\t:\t",np.average(log[:,2]))
        # print("Varience Network calculation Latency\t:\t",np.var(log[:,2], dtype=np.float64))
        print("Average Actuation time Ta\t\t:\t",np.average(log[:,3]))
        # print("Varience Actuation time Ta\t:\t",np.var(log[:,3], dtype=np.float64))
        print("Average Gyro time Tg\t\t\t:\t",np.average(log[:,4]))
        # print("Varience Gyro time Tg\t:\t",np.var(log[:,4], dtype=np.float64))
        print("Average US time Tu\t\t\t:\t",np.average(log[:,5]))
        # print("Varience US time Tu\t:\t",np.var(log[:,5], dtype=np.float64))
        print("Average Sensing time Ts\t\t\t:\t",np.average(log[:,6]))
        # print("Varience Sensing time Ts\t:\t",np.var(log[:,6], dtype=np.float64))
        print("Average Next state calc\t\t\t:\t",np.average(log[:,7]))
        # print("Varience Sensing time Ts\t:\t",np.var(log[:,6], dtype=np.float64))
        print("Average appending time\t\t\t:\t",np.average(log[:,8]))
        # print("Varience Sensing time Ts\t:\t",np.var(log[:,6], dtype=np.float64))
        # print("Average Fwd Pred. time\t\t\t:\t",np.average(log[:,9]))
        # print("Varience Sensing time Ts\t:\t",np.var(log[:,6], dtype=np.float64))

        print("Balance time\t:\t",Balanced_time)

        summary.append([Balanced_time,np.average(log[:,1])*1000]) 
        
        sleep(2)
        #audio.speak('Resetting',volume=20)
        print('Distance from centre')
        while not ((U.value()/1000 <= (reference_dist + 0.001)) and (U.value()/1000 >= (reference_dist - 0.001))): 
            if (U.value()/1000) > reference_dist+0.030:
                drive.on(-30, brake = False, block = False)
                sleep(0.01)
            elif (U.value()/1000) > reference_dist:
                drive.on(-2, brake = False, block = False)
                sleep(0.01)
            elif (U.value()/1000) < reference_dist-0.030:
                drive.on(30, brake = False, block = False)
                sleep(0.01)
            else:
                drive.on(2, brake = False, block = False)
                sleep(0.01)    
    #        print(reference_dist - (U.value()/100))    # track how far is the cart from centre
    
        init(drive,'drive')
        init(grabber,'grabber')
        init(jack,'jack')

        # internal state
        DQN.hidden_mem = np.random.rand(DQN.hiddenSize).reshape(1,4)*.3
        DQN.hidden_spike = np.zeros(DQN.hiddenSize).reshape(1,4)

        DQN.output_mem = np.random.rand(DQN.outputSize).reshape(1,2)*.3
        DQN.output_spike = np.zeros(DQN.outputSize).reshape(1,2)


#        if episode%1 == 0:      # Manually start after how many episodes
#            while (U.value()!=2550):
#                sleep(0.01) 

        if (episode+1) % 3 == 0:
            
            update_time = os.path.getmtime('outfile.npy')
            while True:
                if os.path.getmtime('outfile.npy') > update_time:
                    break
            sleep(0.5)
            config_file = np.load('outfile.npy',allow_pickle=True)

            # internal state
            DQN.hidden_mem = np.random.rand(DQN.hiddenSize).reshape(1,4)*.3
            DQN.hidden_spike = np.zeros(DQN.hiddenSize).reshape(1,4)

            DQN.output_mem = np.random.rand(DQN.outputSize).reshape(1,2)*.3
            DQN.output_spike = np.zeros(DQN.outputSize).reshape(1,2)
            
            DQN.W[0] = config_file[0].T     # Copying W[0] from saved file
            DQN.B[0] = config_file[1].reshape(-1)      # Copying B[0] from saved file
            DQN.W[1] = config_file[2].T     # Copying W[1] from saved file
            DQN.B[1] = config_file[3].reshape(-1)      # Copying B[1] from saved file
            
            for j in range(2):      # Printing loaded weights and biases
                print("W[j]:",np.shape(DQN.W[j]),"  \n",DQN.W[j])
                print("B[j]:",np.shape(DQN.B[j]),"  \n",DQN.B[j])

        audio.play_tone(4000, 0.05, volume=1, play_type=0) 
        
        print('\033[92m'+'Numpy file loaded successfully!!!'+'\033[0m')
except KeyboardInterrupt:
  init(drive,'drive')
  init(grabber,'grabber')
  init(jack,'jack')


############################################################





