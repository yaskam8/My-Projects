import gym
import numpy as np
import torch
import matplotlib.pyplot as plt
import time
from gym.wrappers import Monitor
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import math
import copy
from tempfile import TemporaryFile

env_name = "CartPole-v1"
time_steps = 550

import math
import gym
from gym import spaces, logger
from gym.utils import seeding
import numpy as np
import os
PATH = os.getcwd()
import sys
import glob
import csv
import winsound
from time import sleep
from prettytable import PrettyTable

class CartPoleEnv(gym.Env):
    """
    Description:
        A pole is attached by an un-actuated joint to a cart, which moves along a frictionless track. The pendulum starts upright, and the goal is to prevent it from falling over by increasing and reducing the cart's velocity.
    Source:
        This environment corresponds to the version of the cart-pole problem described by Barto, Sutton, and Anderson
    Observation: 
        Type: Box(4)
        Num	Observation                 Min         Max
        0	Cart Position             -4.8            4.8
        1	Cart Velocity             -Inf            Inf
        2	Pole Angle                 -24 deg        24 deg
        3	Pole Velocity At Tip      -Inf            Inf
        
    Actions:
        Type: Discrete(2)
        Num	Action
        0	Push cart to the left
        1	Push cart to the right
        
        Note: The amount the velocity that is reduced or increased is not fixed; it depends on the angle the pole is pointing. This is because the center of gravity of the pole increases the amount of energy needed to move the cart underneath it
    Reward:
        Reward is 1 for every step taken, including the termination step
    Starting State:
        All observations are assigned a uniform random value in [-0.05..0.05]
    Episode Termination:
        Pole Angle is more than 12 degrees
        Cart Position is more than 2.4 (center of the cart reaches the edge of the display)
        Episode length is greater than 200
        Solved Requirements
        Considered solved when the average reward is greater than or equal to 195.0 over 100 consecutive trials.
    """
    
    metadata = {
        'render.modes': ['human', 'rgb_array'],
        'video.frames_per_second' : 50
    }

    def __init__(self):
        self.gravity = 9.8
        self.masscart = 1.93		#1.93
        self.masspole = 0.05 #0.05
        self.total_mass = (self.masspole + self.masscart)
        self.length = 0.5		# actually half the pole's length
        self.polemass_length = (self.masspole * self.length)
        self.force_mag = 14.286		#14.286256 N by cartpole 14
        self.tau = 0.022		# seconds between state updates 0.11
        self.kinematics_integrator = 'euler'

        # Angle at which to fail the episode
        self.theta_threshold_radians = 30 * 2 * math.pi / 360 #25
        self.x_threshold = 2.4	#1

        # Angle limit set to 2 * theta_threshold_radians so failing observation is still within bounds
        high = np.array([
            self.x_threshold * 2,
            np.finfo(np.float32).max,
            self.theta_threshold_radians * 2,
            np.finfo(np.float32).max])
        
        self.action_space = spaces.Discrete(2)
        self.observation_space = spaces.Box(-high, high, dtype=np.float32)
        self.seed()
        self.viewer = None
        self.state = None
        self.steps_beyond_done = None
        self.steps = 0
    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]

    def step(self, action):
        assert self.action_space.contains(action), "%r (%s) invalid"%(action, type(action))
        state = self.state
        x, x_dot, theta, theta_dot = state
        force = self.force_mag if action==1 else -self.force_mag
        costheta = math.cos(theta)
        sintheta = math.sin(theta)
        temp = (force + self.polemass_length * theta_dot * theta_dot * sintheta) / self.total_mass
        thetaacc = (self.gravity * sintheta - costheta* temp) / (self.length * (4.0/3.0 - self.masspole * costheta * costheta / self.total_mass))
        xacc  = temp - self.polemass_length * thetaacc * costheta / self.total_mass
        if self.kinematics_integrator == 'euler':
            x  = x + self.tau * x_dot
            x_dot = x_dot + self.tau * xacc
            theta = theta + self.tau * theta_dot
            theta_dot = theta_dot + self.tau * thetaacc
        else: # semi-implicit euler
            x_dot = x_dot + self.tau * xacc
            x  = x + self.tau * x_dot
            theta_dot = theta_dot + self.tau * thetaacc
            theta = theta + self.tau * theta_dot
        self.state = (x,x_dot,theta,theta_dot)
        done =  x < -self.x_threshold \
                or x > self.x_threshold \
                or theta < -self.theta_threshold_radians \
                or theta > self.theta_threshold_radians \
                or self.steps > 500
        done = bool(done)
        self.steps += 1
        # limit = 200

        if not done:
            reward = 1.0
        elif self.steps_beyond_done is None:
            # Pole just fell!
            self.steps_beyond_done = 0
            reward = 1.0
        else:
            if self.steps_beyond_done == 0:
                logger.warn("You are calling 'step()' even though this environment has already returned done = True. You should always call 'reset()' once you receive 'done = True' -- any further steps are undefined behavior.")
            self.steps_beyond_done += 1
            reward = 0.0

        return np.array(self.state), reward, done, {}

    def reset(self):
        self.state = self.np_random.uniform(low=-0.05, high=0.05, size=(4,))
        self.steps_beyond_done = None
        self.steps = 0
        return np.array(self.state)

    def render(self, mode='human'):
        screen_width = 600
        screen_height = 400

        world_width = self.x_threshold*2
        scale = screen_width/world_width
        carty = 100 # TOP OF CART
        polewidth = 10.0
        polelen = scale * (2 * self.length)
        cartwidth = 50.0
        cartheight = 30.0

        if self.viewer is None:
            from gym.envs.classic_control import rendering
            self.viewer = rendering.Viewer(screen_width, screen_height)
            l,r,t,b = -cartwidth/2, cartwidth/2, cartheight/2, -cartheight/2
            axleoffset =cartheight/4.0
            cart = rendering.FilledPolygon([(l,b), (l,t), (r,t), (r,b)])
            self.carttrans = rendering.Transform()
            cart.add_attr(self.carttrans)
            self.viewer.add_geom(cart)
            l,r,t,b = -polewidth/2,polewidth/2,polelen-polewidth/2,-polewidth/2
            pole = rendering.FilledPolygon([(l,b), (l,t), (r,t), (r,b)])
            pole.set_color(.8,.6,.4)
            self.poletrans = rendering.Transform(translation=(0, axleoffset))
            pole.add_attr(self.poletrans)
            pole.add_attr(self.carttrans)
            self.viewer.add_geom(pole)
            self.axle = rendering.make_circle(polewidth/2)
            self.axle.add_attr(self.poletrans)
            self.axle.add_attr(self.carttrans)
            self.axle.set_color(.5,.5,.8)
            self.viewer.add_geom(self.axle)
            self.track = rendering.Line((0,carty), (screen_width,carty))
            self.track.set_color(0,0,0)
            self.viewer.add_geom(self.track)
            self._pole_geom = pole
        if self.state is None: return None
        # Edit the pole polygon vertex
        pole = self._pole_geom
        l,r,t,b = -polewidth/2,polewidth/2,polelen-polewidth/2,-polewidth/2
        pole.v = [(l,b), (l,t), (r,t), (r,b)]

        x = self.state
        cartx = x[0]*scale+screen_width/2.0 # MIDDLE OF CART
        self.carttrans.set_translation(cartx, carty)
        self.poletrans.set_rotation(-x[2])

        return self.viewer.render(return_rgb_array = mode=='rgb_array')
    def close(self):
        if self.viewer:
            self.viewer.close()
            self.viewer = None

class CartPoleAI(nn.Module):

        def __init__(self):
            super().__init__()
            self.fc = nn.Sequential(
                        nn.Linear(4,4, bias=True),
                        nn.ReLU(),
                        nn.Linear(4,2, bias=True),
                        nn.Softmax(dim=1)
                        )

                
        def forward(self, inputs):
            x = self.fc(inputs)
            return x



def init_weights(m):
    
        # nn.Conv2d weights are of shape [16, 1, 3, 3] i.e. # number of filters, 1, stride, stride
        # nn.Conv2d bias is of shape [16] i.e. # number of filters
        
        # nn.Linear weights are of shape [32, 24336] i.e. # number of input features, number of output features
        # nn.Linear bias is of shape [32] i.e. # number of output features
        
        if ((type(m) == nn.Linear) | (type(m) == nn.Conv2d)):
            torch.nn.init.xavier_uniform(m.weight)
            m.bias.data.fill_(0.00)
                
def return_random_agents(num_agents):
    
    input_weight = []
    input_bias = []

    out_weight = []
    out_bias = []

    agents = []

    parent_models = ['119outfile.npy',          # DNN GA Agents
                     '137outfile.npy',
                     '143outfile.npy',
                     '146outfile.npy',
                     '147outfile.npy',
                     '200outfile.npy',
                     '307outfile.npy',
                     '308outfile.npy',
                     '310outfile.npy',
                     '311outfile.npy',
                     '327outfile.npy',
                     '378outfile.npy',
                     '380outfile.npy',
                     '383outfile.npy',
                     '384outfile.npy',
                     '385outfile.npy',
                     '388outfile.npy',
                     '389outfile.npy',
                     '390outfile.npy',
                     '391outfile.npy']
    
    # parent_models = ['180_agent.npy',            # SNN GA Agents
    #                  '181_agent.npy',
    #                  '182_agent.npy',
    #                  '183_agent.npy',
    #                  '184_agent.npy',
    #                  '187_agent.npy',
    #                  '188_agent.npy',
    #                  '196_agent.npy',
    #                  '202_agent.npy',
    #                  '204_agent.npy',
    #                  '206_agent.npy',
    #                  '208_agent.npy',
    #                  '209_agent.npy',
    #                  '213_agent.npy',
    #                  '214_agent.npy',
    #                  '215_agent.npy',
    #                  '217_agent.npy',
    #                  '218_agent.npy',
    #                  '298_agent.npy',
    #                  '499_agent.npy']
    
    TempPATH = os.getcwd()+'\\GA trained parents\\'     # DNN GA Agents
    # TempPATH = os.getcwd()+'\\lif_npy_agents\\'       # SNN GA Agents

    for parent in parent_models:
        config_file = np.load(TempPATH + parent,allow_pickle=True)
        in_w = np.array(config_file[0])

        in_b = np.array(config_file[1])

        out_w = np.array(config_file[2])

        out_b = np.array(config_file[3])

        agents.append([in_w, in_b, out_w, out_b])
        
    return agents



    # agents = []
    # for _ in range(num_agents):
        
    #     agent = CartPoleAI()
        
    #     for param in agent.parameters():
    #         param.requires_grad = False
            
    #     init_weights(agent)
    #     agents.append(agent)
        
        
    # return agents
    
def run_agents(agents): # This is where the agent is run for 1 episode in the env
    
    reward_agents = []
    
    csv_data = []
    outfile = TemporaryFile()
    global file_no
    # my_file_no = file_no
    
    for i in range(4):
        csv_data.append(agents[i])   

    to_array = np.array(csv_data)
    # Save Numpy array to csv
    # np.save("outfile.npy", to_array)
    # np.save(PATH+'\\HW trained GA agents\\'+str(int(file_no/3))+'_outfile.npy', to_array)
    
    print('\x1b[1;34;40m'+"Successfully written to outfile.npy" +'\x1b[0m')
    winsound.Beep(2500, 50)

    for agent_run_trial in range(1): # run each agent n number of times and take avg. score
        while True:
            print("\rWaiting for new file..", end="")
            # sleep(0.25)
            sys.stdout.flush()
            sleep(0.25)
            if os.path.isfile(PATH+'\hw_training_dataset_GA'+'\Ep_'+str(file_no)+'.csv'):
                print()
                break
        
        # file_name = len(glob.glob(PATH+'\hw_training_dataset_GA\*.csv' )) - 1
        file_name = file_no

        file = open(PATH+'\hw_training_dataset_GA'+'\Ep_'+str(file_name)+'.csv')
        reader = csv.reader(file)
        episode_score = len(list(reader))
        if episode_score == 0:
            while episode_score == 0:
                file = open(PATH+'\hw_training_dataset_GA'+'\Ep_'+str(file_name)+'.csv')
                reader = csv.reader(file)
                episode_score = len(list(reader))

        print('Ep_'+str(file_name)+'.csv'+'\x1b[1;36;40m'+"  Score: "+'\x1b[0m', episode_score)
        file_no += 1
        agent_run_trial += 1
        
    return episode_score
    
    
    
    # env = CartPoleEnv()#gym.make(env_name)
    
    # for agent in agents:
    #     agent.eval() # notify all layers to work in eval mode instead of training mode. i.e. no backprop
    
    #     observation = env.reset()
        
    #     r=0
    #     s=0
        
    #     for _ in range(time_steps):
            
    #         inp = torch.tensor(observation).type('torch.FloatTensor').view(1,-1)
    #         output_probabilities = agent(inp).detach().numpy()[0]
    #         action = np.random.choice(range(game_actions), 1, p=output_probabilities).item()
    #         new_observation, reward, done, info = env.step(action)
    #         r=r+reward
            
    #         s=s+1
    #         observation = new_observation

    #         if(done):
    #             break

    #     reward_agents.append(r)        
    #     #reward_agents.append(s)
        
    
    # return reward_agents

def return_average_score(agent, runs):
    score = 0.
    for i in range(runs):
        score += run_agents(agent)
    return score/runs

def run_agents_n_times(agents, runs):
    avg_score = []
    child = 0
    for agent in agents:
        print('Child : ',child)
        avg_score.append(return_average_score(agent,runs))
        child += 1
    return avg_score


def mutate(agent):

    child_agent = copy.deepcopy(agent)
    # child_agent = agent
    
    mutation_power = 0.05 #hyper-parameter, set from https://arxiv.org/pdf/1712.06567.pdf


    for i in range(len(child_agent)):
        if len(child_agent[i].shape) == 2:  # weight

            for j in range(child_agent[i].shape[0]):
                for k in range(child_agent[i].shape[1]):
                    child_agent[i][j][k] += mutation_power * np.random.randn() 


        elif len(child_agent[i].shape) == 1:    # bias  

            for j in range(len(child_agent[i])):
                child_agent[i][j] += mutation_power * np.random.randn()

        
    # for param in child_agent.parameters():
    
    #     if(len(param.shape)==4): #weights of Conv2D

    #         for i0 in range(param.shape[0]):
    #             for i1 in range(param.shape[1]):
    #                 for i2 in range(param.shape[2]):
    #                     for i3 in range(param.shape[3]):
                            
    #                         param[i0][i1][i2][i3]+= mutation_power * np.random.randn()

    #     elif(len(param.shape)==2): #weights of linear layer
    #         for i0 in range(param.shape[0]):
    #             for i1 in range(param.shape[1]):
                    
    #                 param[i0][i1]+= mutation_power * np.random.randn()            
                        

    #     elif(len(param.shape)==1): #biases of linear layer or conv layer
    #         for i0 in range(param.shape[0]):
                
    #             param[i0]+=mutation_power * np.random.randn()            

    return child_agent

def return_children(agents, sorted_parent_indexes, elite_index):
    
    children_agents = []
    
    #first take selected parents from sorted_parent_indexes and generate N-1 children
    for i in range(len(agents)-1):
        
        selected_agent_index = sorted_parent_indexes[np.random.randint(len(sorted_parent_indexes))]
        children_agents.append(mutate(agents[selected_agent_index]))

    #now add one elite
    elite_child = add_elite(agents, sorted_parent_indexes, elite_index)
    children_agents.append(elite_child)
    elite_index=len(children_agents)-1 #it is the last one
    
    return children_agents, elite_index

def add_elite(agents, sorted_parent_indexes, elite_index=None, only_consider_top_n=2):
    
    candidate_elite_index = sorted_parent_indexes[:only_consider_top_n]
    
    if(elite_index is not None):
        candidate_elite_index = np.append(candidate_elite_index,[elite_index])
        
    top_score = None
    top_elite_index = None
    
    for i in candidate_elite_index:
        score = return_average_score(agents[i],runs=3)
        print("Score for elite i ", i, " is ", score)
        
        if(top_score is None):
            top_score = score
            top_elite_index = i
        elif(score > top_score):
            top_score = score
            top_elite_index = i
            
    print("Elite selected with index ",top_elite_index, " and score", top_score)
    
    child_agent = agents[top_elite_index]
    return child_agent
    
game_actions = 2 #2 actions possible: left or right

#disable gradients as we will not use them
torch.set_grad_enabled(False)

# initialize N number of agents
num_agents = 20
agents = return_random_agents(num_agents) # produces n agents with [4,4,2] config.

# How many top agents to consider as parents
top_limit = 2

if env_name[-1] == '0':
    target_score = 200
elif env_name[-1] == '1':
    target_score = 500
# run evolution until X generations
generations = 10
file_no = 0

elite_index = None
records_score = []
t = PrettyTable()
t.field_names = ["Agent", "Score","Best", "Scorers"]

for generation in range(generations):


    # return rewards of agents
    rewards = run_agents_n_times(agents, 3) #return average of 3 runs
    
    sorted_rewards = np.argsort(rewards)[::-1]
    t.add_row(['\x1b[1;32;40m'+'Generation'+'\x1b[0m','\x1b[1;32;40m'+str(generation)+'\x1b[0m','\x1b[1;32;40m'+'Average'+'\x1b[0m','\x1b[1;32;40m'+str(round(np.mean(rewards),1))+'\x1b[0m'])
    for i in range (len(rewards)):
        t.add_row([i,round(rewards[i],1),sorted_rewards[i],round(rewards[sorted_rewards[i]],1)])
    print(t)

    # sort by rewards
    sorted_parent_indexes = np.argsort(rewards)[::-1][:top_limit] #reverses and gives top values (argsort sorts by ascending by default) https://stackoverflow.com/questions/16486252/is-it-possible-to-use-argsort-in-descending-order
    print("")
    print("")
    
    top_rewards = []
    for best_parent in sorted_parent_indexes:
        top_rewards.append(rewards[best_parent])
    
    print("Generation ", generation, " | Mean rewards: ", np.mean(rewards), " | Mean of top 5: ",np.mean(top_rewards[:5]))
    #print(rewards)
    print("Top ",top_limit," scorers", sorted_parent_indexes)
    print("Rewards for top: ",top_rewards)
    records_score.append([np.mean(rewards),np.mean(top_rewards[:5])])
    # if np.mean(top_rewards[:40])>=target_score and np.mean(rewards)>0.9*target_score:
    #     print('training is done')
    #     break
    # setup an empty list for containing children agents
    children_agents, elite_index = return_children(agents, sorted_parent_indexes, elite_index)


    # kill all agents, and replace them with their children
    agents = children_agents

records_np = np.array(records_score)
records_np.shape

plt.plot(records_np[:,0],label='avg')
plt.plot(records_np[:,1],label='top5 avg')
# plt.savefig('GA_new.png')
plt.legend()




# for ag in  sorted_parent_indexes:
#     agent= agents[ag]
#     layer_params = {}
#     w = []
#     b = []
#     csv_data = []
#     outfile = TemporaryFile()
#     layer_no = 0
#     for child in agent.fc.named_children():
#         layer_name = child[0]
#         # print('layer_no', layer_name)
#         for param in child[1].named_parameters():
#             # print(param)
#             if param[0] == 'weight':
#               weights = np.array(param[1]).T
#               # print('weights', weights, np.shape(weights))
#               w.append(weights)
#               csv_data.append(w[layer_no])
#             elif param[0] == 'bias':
#               biases = np.array(param[1])
#               # print('bias', biases, np.shape(biases))
#               b.append(biases)
#               csv_data.append(b[layer_no])
#               layer_no += 1

#     # print(csv_data)
#     to_array = np.array(csv_data)
#     save_name =str(ag)+ 'outfile.npy'
#     print('Saved weights of '+str(ag)+' to '+str(save_name))
#     np.save(save_name, to_array)