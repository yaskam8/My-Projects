"""This code could get a successful NFQ network for a [5,5,1] configuration on OpenAi's Cartpole-v1 with Ev3 Parameters (including Delay=40ms!).
The successful agent was found at episode 39 itself! With an averge score of 500 for 100 episodes.
Note: The weight initialization is different from default in keras. It uses RandomUniform = [-0.05, 0.05] and biases = 0
X+ = |x|< 0.05 & |theta| < 0.01         cost = 0
else = |theta| > 0.01 & |theta| < 0.2   cost = 0.01
X- = elsewhere                          cost = 1

The solution was also obtained for a smaller network: [5, 3, 1] in 39 episodes as well as for [5,5,1] in 39 episodes
"""

import gym
import numpy as np
import time
import math
from keras.initializers import RandomUniform
from keras.models import Sequential, load_model
from keras.layers.core import Dense, Activation, Flatten, Dropout
from keras.layers.convolutional import Convolution2D
from keras.optimizers import RMSprop
from keras.callbacks import RemoteMonitor
from keras.callbacks import ModelCheckpoint
from collections import deque
from keras.callbacks import EarlyStopping
import pandas as pd
from matplotlib import pyplot
from scipy import stats
from collections import deque
import os
from tqdm import tqdm
from prettytable import PrettyTable
from CartPole_myversion_for_NFQ import CartPoleEnv
PATH = os.getcwd()
ENV_NAME = CartPoleEnv() 

class NFQ:
    def __init__(self,  #/TODO: Correct!
                 state_dim,
                 nb_actions,
                 mlp_layers=[20, 20],
                 discount_factor=0.95,
                 lr=0.01,
                 max_iters=40000):
        self.k = 0  # Keep track of the number of iterations
        self.discount_factor = discount_factor
        self.nb_actions = nb_actions
        self.state_dim = state_dim
        self.lr = lr   
        self.memory = deque(maxlen=10000)
        self.Q = self._init_MLP(mlp_layers=mlp_layers)

        self._loss_history = np.zeros((max_iters))
        self._loss_history_test = np.zeros((max_iters))

    def _init_MLP(self, mlp_layers):    #/TODO: Correct!
        """Initialize the MLP that corresponds to the Q function.
        Parameters
        ----------
        state_dim : The state dimensionality
        nb_actions : The number of possible actions
        mlp_layers : A list consisting of an integer number of neurons for each
                     hidden layer. Default = [20, 20]
        """
        model = Sequential()
        weight_init = RandomUniform(minval=-0.05, maxval=0.05, seed=None)
        for i in range(len(mlp_layers)):
            if i == 0:
                model.add(Dense(mlp_layers[i],
                        input_dim=self.state_dim[1] + 1,
                        kernel_initializer=weight_init,
                        bias_initializer='zeros',
                        activation='sigmoid'))
            else:
                model.add(Dense(mlp_layers[i],
                        kernel_initializer=weight_init,
                        bias_initializer='zeros',
                        activation='sigmoid'))
        model.add(Dense(1, 
                        kernel_initializer=weight_init,
                        bias_initializer='zeros',
                        activation='sigmoid'))
        rmsprop = RMSprop(lr = self.lr)
        model.compile(loss='mean_squared_error', optimizer=rmsprop)
        # simple early stopping
        self.es = EarlyStopping(monitor='val_loss', mode='min', verbose=1, patience=100)
        return model     
    
    def _Q_value(self, s, a): # s & a should be an numpy array! Output: Q-val   /TODO: Correct!
        """Calculate the Q-value of a state, action pair
        """        
        X = np.hstack((s, a))        
        X = X.reshape(1, -1)
         # Perform a forward pass of the Q-network
        output = self.Q.predict(X)[0][0]
        return output

    def fit_vectorized(self, D_s, D_a, D_r, D_s_prime,  #/TODO: Correct!
                       K=1,
                       epochs=1,
                       full_batch_sgd=True,
                       validation=True):
        """Run an iteration of the RC-NFQ algorithm and update the Q function.
        The implementation is vectorized for improved performance.
        The function requires a set of interactions with the environment. 
        They consist of experience tuples of the form (s, a, r, s_prime),
        stored in 4 parallel arrays.
        Parameters
        ----------
        D_s : A list of states s for each experience tuple
        D_a: A list of actions a for each experience tuple
        D_r : A list of rewards r for each experience tuple
        D_s_prime : A list of states s_prime for each experience tuple
        num_iters : The number of epochs to run per batch. Default = 1.
        full_batch_sgd : Boolean. Determines whether RMSprop will use 
                         full-batch or mini-batch updating. Default = True.
        validation : Boolean. If True, a validation set will be used consisting
                     of the last 10% of the experience tuples, and the validation 
                     loss will be monitored. Default = True.
        """
        train_loss = np.array([])
        test_loss = np.array([])
        train_curr_loss = 100
        test_curr_loss = 100
        for self.k in range (K):

            if validation:
                # Split the data into 90% training / 80% validation sets
                n = int(0.80 * np.asarray(D_s).shape[0])

                D_s_train = D_s[0:n]
                D_a_train = D_a[0:n]
                D_r_train = D_r[0:n]
                D_s_prime_train = D_s_prime[0:n]

                D_s_test = D_s[n:]
                D_a_test = D_a[n:]
                D_r_test = D_r[n:]
                D_s_prime_test = D_s_prime[n:]

            else:
                D_s_train, D_a_train, D_r_train, D_s_prime_train = D_s, D_a, D_r, D_s_prime

            # P contains the pattern set of inputs and targets
            P_input_values_train, P_target_values_train \
                = self._generate_pattern_set(D_s_train, D_a_train, D_r_train, D_s_prime_train)

            P_input_values_test, P_target_values_test \
                = self._generate_pattern_set(D_s_test, D_a_test, D_r_test, D_s_prime_test)

        
            if full_batch_sgd:
                if validation:
                    hist = self.Q.fit(P_input_values_train,
                                        P_target_values_train,
                                        epochs=epochs,
                                        batch_size=P_target_values_train.shape[0],
                                        verbose = 0,
                                        validation_data=(P_input_values_test,
                                                        P_target_values_test))
                                        # callbacks=[self.es])
                    # self.Q.save("NFQ(gymCP_v1)5-3-1hw_specs_3actions.h5")
                    self.Q.save("NFQ_test.h5")
                    # print("Saved Model to file NFQ(rough).h5!!")
                else:
                    hist = self.Q.fit(P_input_values_train,
                                        P_target_values_train,
                                        epochs=epochs,
                                        batch_size=P_target_values_train.shape[0],
                                        callbacks=[ModelCheckpoint])
            else:
                hist = self.Q.fit(P_input_values,
                                    P_target_values,
                                    epochs=epochs,
                                    validation_data=(P_input_values_test,
                                                    P_target_values_test),
                                    callbacks=[ModelCheckpoint])

            self._loss_history[self.k] = hist.history['loss'][0]
            self._last_loss_history = np.dot(hist.history['loss'],100)
            test_loss = np.hstack((test_loss, self._last_loss_history))


            if validation:
                self._loss_history_test[self.k] = hist.history['val_loss'][0]
                self._last_loss_history_test = np.dot(hist.history['val_loss'],100)
                train_loss = np.hstack((train_loss, self._last_loss_history_test))

            # if self._last_loss_history_test < test_curr_loss:
            #     test_curr_loss = self._last_loss_history_test
            # else:
            #     break      

            self.k += 1
        
        # print("Training loss: ", train_loss[-1])
        # print("Test loss: ", test_loss[-1])

        # plot training history
        # pyplot.plot(train_loss, 'r', label='train loss')
        # pyplot.plot(test_loss, 'b', label='test loss')
        # pyplot.xlabel('Epochs')
        # pyplot.ylabel('Percentage %')
        # pyplot.legend()
        # pyplot.show()

    def _generate_pattern_set(self, D_s, D_a, D_r, D_s_prime):  #/TODO: Correct!
        """Generate pattern set. Vectorized version for improved performance.
        A pattern set consists of a set of input and target tuples, where
        the inputs contain states and actions that occurred in the
        environment, and the targets are calculated based on the Bellman
        equation using the reward from the environment and the Q-value
        estimate for the successor state using the current Q function.
        Parameters
        ----------
        D_s : A list of states s for each experience tuple
        D_a: A list of actions a for each experience tuple
        D_r : A list of rewards r for each experience tuple
        D_s_prime : A list of states s_prime for each experience tuple
        """
        # Perform a forward pass through the Q-value network as a batch with
        # all the samples from D at the same time for efficiency
        
        # P contains the pattern set of inputs and targets
        P_input_values = np.column_stack((D_s, D_a))     

        target_network = self.Q

        # P_target_values = D_r + self.discount_factor * \
        #     float(self._greedy_action_value(s=D_s_prime))

        greedy_Q_vals = self._greedy_action_value(s=D_s_prime)
        P_target_values = np.array(list(map(self.target_calculator, D_r, greedy_Q_vals)))
       
        return P_input_values, P_target_values

    def target_calculator(self, D_r, greedy_Q_vals):    #/TODO: Correct!
        if D_r == 0:
            return 0
        elif D_r == 1:
            return 1
        else:
            return D_r + self.discount_factor * greedy_Q_vals

    def _greedy_action_value(self, s): # s = numpy array. Output: Greedy action     #/TODO: Correct!
        """Returns the min Q-val given the state input
        """
        Q_value = np.zeros(self.nb_actions)
        greedy_action = np.zeros(len(s))
        
        for j in range(len(s)):
            for a in np.arange(self.nb_actions):
                Q_value[a] = self._Q_value(s[j], a)
            greedy_action[j] = np.min(Q_value)

        return greedy_action.tolist()

    def remember(self, observation, action, reward, next_observation):
        if len(self.memory) > self.memory.maxlen:
            print("Memory Full! Poppoing initial transitions..")
            self.memory.popleft()
        self.memory.append((observation, action, reward, next_observation))

    def memory_to_lists(self):
        """Returns list of state, action , reward, next_state from memory
        """
        D_s = []
        D_a = []
        D_r = []
        D_s_prime = []

        temp_memory = self.memory
        np.random.shuffle(temp_memory)

        for element in range(len(temp_memory)):
            D_s.append(temp_memory[element][0])
            D_a.append(temp_memory[element][1])
            D_s_prime.append(temp_memory[element][3])

            if abs(D_s_prime[-1][0]) <= 0.05 and abs(D_s_prime[-1][2]) <= 0.01:  # X+  0.05 & 0.01
                reward = 0.0 
            elif abs(D_s_prime[-1][2]) > 0.01 and abs(D_s_prime[-1][2]) < 0.2:  # else  0.01 & 0.02
                reward = 0.01
            else:                                                      # X-
                reward = 1.0

            D_r.append(reward)  

        return D_s, D_a, D_r, D_s_prime

    

episodes = 500
max_episode_steps = 500

def train():
    # env = ENV_NAME
    env = gym.make("CartPole-v1")

    env.masscart = 1.93		#1.93
    env.masspole = 0.05 #0.05
    env.total_mass = (env.masspole + env.masscart)
    env.length = 0.5		# actually half the pole's length
    env.polemass_length = (env.masspole * env.length)
    env.force_mag = 14		#14.286256 N by cartpole 14
    env.tau = 0.04		# seconds between state updates 0.06
    env.kinematics_integrator = 'euler'

    # Angle at which to fail the episode
    env.theta_threshold_radians = 35 * 2 * math.pi / 360 #25
    env.x_threshold = 2.4	#1

    agent = NFQ((1,4), 3, mlp_layers=[5], lr=0.01)
    nb_actions = 3
    scores = [0]  # A list of all game scores
    D_s = []


    for episode in range(episodes):
        state = env.reset()
        # state[0] = np.random.uniform(low=-2.3, high=2.3)
        # state[2] = np.random.uniform(low=0, high=2)

        for iteration in range(max_episode_steps):
            # env.render()
            # Query the model and get Q-values for possible actions
            Q_value = np.zeros(nb_actions)
            for a in np.arange(nb_actions):
                Q_value[a] = agent._Q_value(state, a)
            action = np.argmin(Q_value)

            # Take the selected action and observe next state
            if action == 0:   # [0,14,-14]
                env.force_mag = 0
                next_state, reward, done, _ = env.step(0)
            elif action == 1:   # [0,14,-14]
                env.force_mag = 14
                next_state, reward, done, _ = env.step(0)
            elif action == 2:   # [0,14,-14]
                env.force_mag = 14
                next_state, reward, done, _ = env.step(1)
            # next_state, reward, done, _ = env.step(action)
            if done:
                scores.append(iteration + 1)  # Append final score
                # Print end-of-game information
                print("Episode {:03d} , score = {:03d}".format(episode, iteration))

                # Add the observation to replay memory
                agent.remember(state, action, reward, next_state)

                D_s, D_a, D_r, D_s_prime = agent.memory_to_lists()
                agent.fit_vectorized(D_s, D_a, D_r, D_s_prime,
                       K = 1, epochs=300,
                       full_batch_sgd=True,
                       validation=True)
                # if episode > 300 or iteration >= 499:    
                if iteration >= 499:    
                    success = test()
                    if success:
                        print("\x1b[1;31;40m"+"Training Complete!" + "\x1b[0m")
                        # Plot the Performance
                        pyplot.plot(scores)
                        pyplot.title('Training Phase')
                        pyplot.ylabel('Steps')
                        pyplot.xlabel('Episodes')
                        pyplot.savefig('NFQ(gymCP_v1)5-5-1hw_specs_3actions_training.png', bbox_inches='tight')
                        pyplot.show()
                        return
                break
            
            # Add the observation to replay memory
            agent.remember(state, action, reward, next_state)
            state = next_state
    

# def dataset():
    # D_s         = []     
    # D_a         = []
    # D_r         = []
    # D_s_prime   = []
    # df = pd.read_csv('Transitions_Cartpole_v1-2.csv', header = None)
    # ds = df.sample(frac=1)
    # ds = ds.head(12000)
    # ds.to_csv('Shuffledfile.csv', index = False, header = None)

    # my_csv = np.loadtxt(PATH+'\Shuffledfile.csv',delimiter=",")

    # for row in my_csv:
    #     state           = np.array(row[0:4])
    #     action          = int(row[4])
    #     # reward          = int(row[5])                
    #     next_state      = np.array(row[6:10])

    #     if abs(next_state[0]) <= 2 and abs(next_state[2]) <= 0.01:  # X+
    #         reward = 0.0
    #     elif abs(next_state[2]) > 0.01 and abs(next_state[2]) < 0.20:  # else
    #         reward = 0.001
    #     else:                                                      # X-
    #         reward = 1.0


    #     D_s.append((state))
    #     D_a.append((action))
    #     D_r.append((reward))
    #     D_s_prime.append((next_state))

    # D_r_np = np.array(D_r).flatten()
    # # print(D_r_np)
    # # print("X-",len(np.where(D_r_np==1.)[0]),"X+",len(np.where(D_r_np==0.)[0]),"Safe",len(np.where(D_r_np==.001)[0])) 
    # # quit()
    # # Standardizing data by calculating the z-scores
    # D_s_std         =  stats.zscore(D_s)

    # return D_s, D_a, D_r, D_s_prime, D_s_std.tolist()

def pred(s, a, Q): # s & a should be an numpy array! Output: Q-val
        """Calculate the Q-value of a state, action pair
        """        
        X = np.hstack((s, a))        
        X = X.reshape(1, -1)
         # Perform a forward pass of the Q-network
        output = Q.predict(X)[0][0]
        return output

def test():
    """Checks if the network is trained successfully of not for 50 episodes of 500 steps
    """
    env = gym.make("CartPole-v1")
    # env = ENV_NAME

    env.masscart = 1.93		#1.93
    env.masspole = 0.05 #0.05
    env.total_mass = (env.masspole + env.masscart)
    env.length = 0.5		# actually half the pole's length
    env.polemass_length = (env.masspole * env.length)
    env.force_mag = 14		#14.286256 N by cartpole 14
    env.tau = 0.04		# seconds between state updates 0.06
    env.kinematics_integrator = 'euler'

    # Angle at which to fail the episode
    env.theta_threshold_radians = 35 * 2 * math.pi / 360 #25
    env.x_threshold = 2.4	#1

    print('\x1b[5;30;42m'+"Testing..."+'\033[0m')
    # load model 
    # DQN = load_model("NFQ(gymCP_v1)5-3-1hw_specs_3actions.h5")
    DQN = load_model("NFQ_test.h5")

    scores = []

    # Playing 50 games
    for _ in range(50):
        obs = env.reset()
        # obs[1] = 0.0
        # obs[3] = 0.0
        episode_reward = 0
        while True:
            # env.render()
            # q_values = agent.get_q(obs)
            # action = np.argmax(q_values)
            # state_std = stats.zscore(obs)
            state_std  = obs
            state_std0 = np.hstack((state_std, 0)).reshape(-1,1)
            state_std0 = state_std0.reshape(1,-1)
            state_std1 = np.hstack((state_std, 1)).reshape(-1,1)
            state_std1 = state_std1.reshape(1,-1)
            state_std2 = np.hstack((state_std, 2)).reshape(-1,1)
            state_std2 = state_std2.reshape(1,-1)
            # print(np.shape(state_std0))
            # action = 0 if DQN.predict(state_std0) < DQN.predict(state_std1) else 1 

            predictions = []
            predictions.append(DQN.predict(state_std0))
            predictions.append(DQN.predict(state_std1))
            predictions.append(DQN.predict(state_std2))
            # Query the model and get Q-values for possible actions
            action = np.argmin(predictions)   

            if action == 0:   # [0,14,-14]
                env.force_mag = 0
                obs, reward, done, _ = env.step(0)
            elif action == 1:   # [0,14,-14]
                env.force_mag = 14
                obs, reward, done, _ = env.step(0)
            elif action == 2:   # [0,14,-14]
                env.force_mag = 14
                obs, reward, done, _ = env.step(1)
            # obs, reward, done, _ = env.step(action)
            episode_reward += reward
            if done:
                break
        scores.append(episode_reward)
    print("Avg. Test Score: ",np.mean(scores))
    if np.mean(scores) >= 499:
        print("\x1b[1;31;40m"+"Agent has learnt the task!!  Exiting.." + "\x1b[0m")
        return 1
    else:
        return 0

def final_test():
    env = gym.make("CartPole-v1")
    env._max_episode_steps = 3000

    env.masscart = 1.93		#1.93
    env.masspole = 0.05 #0.05
    env.total_mass = (env.masspole + env.masscart)
    env.length = 0.5		# actually half the pole's length
    env.polemass_length = (env.masspole * env.length)
    env.force_mag = 14		#14.286256 N by cartpole 14
    env.tau = 0.04		# seconds between state updates 0.06
    env.kinematics_integrator = 'euler'

    # Angle at which to fail the episode
    env.theta_threshold_radians = 35 * 2 * math.pi / 360 #25
    env.x_threshold = 2.4	#1

    # env = ENV_NAME
    print('\x1b[5;30;42m'+"Running Final Test for 10 episodes of each of max 3000 steps"+'\033[0m')
    # load model 
    DQN = load_model("NFQ(gymCP_v1)5-3-1hw_specs_3actions.h5")

    scores = []

    # Playing 100 games
    for _ in range(10):
        obs = env.reset()
        obs[1] = 0.0
        obs[3] = 0.0
        episode_reward = 0
        while True:
            # env.render()
            # q_values = agent.get_q(obs)
            # action = np.argmax(q_values)
            # state_std = stats.zscore(obs)
            state_std  = obs
            state_std0 = np.hstack((state_std, 0)).reshape(-1,1)
            state_std0 = state_std0.reshape(1,-1)
            state_std1 = np.hstack((state_std, 1)).reshape(-1,1)
            state_std1 = state_std1.reshape(1,-1)
            state_std2 = np.hstack((state_std, 2)).reshape(-1,1)
            state_std2 = state_std2.reshape(1,-1)
            # print(np.shape(state_std0))
            # action = 0 if DQN.predict(state_std0) < DQN.predict(state_std1) else 1 

            predictions = []
            predictions.append(DQN.predict(state_std0))
            predictions.append(DQN.predict(state_std1))
            predictions.append(DQN.predict(state_std2))
            # Query the model and get Q-values for possible actions
            action = np.argmin(predictions) 

            if action == 0:   # [0,14,-14]
                env.force_mag = 0
                obs, reward, done, _ = env.step(0)
            elif action == 1:   # [0,14,-14]
                env.force_mag = 14
                obs, reward, done, _ = env.step(0)
            elif action == 2:   # [0,14,-14]
                env.force_mag = 14
                obs, reward, done, _ = env.step(1)
            # obs, reward, done, _ = env.step(action)
            episode_reward += reward
            if done:
                break
        scores.append(episode_reward)
    print("Avg. Test Score: ",np.mean(scores))


    # Plot the Performance
    pyplot.plot(np.dot(scores,env.tau))
    pyplot.title('Testing Phase')
    pyplot.ylabel('Balance time (s)')
    pyplot.xlabel('Episodes')
    pyplot.savefig('NFQ(gymCP_v1)5-5-1hw_specs_3actions.png', bbox_inches='tight')
    pyplot.show()


if __name__ == "__main__":   
    # a,b,c,d = dataset()
    train()
    # final_test()
    print("Done!")

