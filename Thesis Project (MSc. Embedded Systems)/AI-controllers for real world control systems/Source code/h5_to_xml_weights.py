import xml.etree.ElementTree as ET
import numpy as np
import keras
from keras.models import load_model

source = "HWTrain500.h5"
target = "CPTraining_MV.xml"
# reference = "saved_net_24_16_3.xml"     # (4,24,16,3) configuration
reference = "saved_net_24_16.xml"     # (4,24,16,2) configuration
# reference = "saved_net_12_16_4_reference.xml"     # (12,16,4) configuration

model = load_model(source)
layers = 3
w = []
b = []
for layer in range(layers): # code to print the weights and biases of each layer orderly
    weights = np.array(model.layers[layer].get_weights()[0])
    weights = np.round(np.float64(weights),8)
    weights = np.transpose(weights)
    weights = weights.reshape(-1)
    w.append(weights)

    biases = np.array(model.layers[layer].get_weights()[1])
    biases = np.round(np.float64(biases),8)
    biases = np.transpose(biases)
    biases = biases.reshape(-1)
    b.append(biases)
    print('Layer ',layer+1,' weights ',np.shape(w[layer]),':\n', w[layer].tolist())
    print('Layer ',layer+1,' biases ',np.shape(b[layer]),':\n', b[layer].tolist())

tree = ET.parse(reference)
root = tree.getroot()

# This loop pastes the .h5 file weights orderly into the .xml file at correct places.
for child in root.findall('Network'):      #Network
    for subchild in child.findall('Connections'):  # Connections
        for subsubchild in subchild.findall('FullConnection'):  # FullConnection
            for subnode in subsubchild.findall('inmod'):  # FullConnection    
                if subnode.get('val') == 'bias1':
                    # print(subnode.get('val'))
                    for node in subsubchild.findall('Parameters'):
                        # print(node.text)
                        node.text = str(b[0].tolist())     # Replace
                        # print(node.text)
                elif subnode.get('val') == 'bias2':
                    # print(subnode.get('val'))
                    for node in subsubchild.findall('Parameters'):
                        # print(node.text)
                        node.text = str(b[1].tolist())     # Replace
                        # print(node.text)
                elif subnode.get('val') == 'bias3':
                    # print(subnode.get('val'))
                    for node in subsubchild.findall('Parameters'):
                        # print(node.text)
                        node.text = str(b[2].tolist())     # Replace
                        # print(node.text)
                elif subnode.get('val') == 'in':
                    # print(subnode.get('val'))
                    for node in subsubchild.findall('Parameters'):
                        # print(node.text)
                        node.text = str(w[0].tolist())     # Replace
                        # print(node.text)
                elif subnode.get('val') == 'hidden1':
                    # print(subnode.get('val'))
                    for node in subsubchild.findall('Parameters'):
                        # print(node.text)
                        node.text = str(w[1].tolist())     # Replace
                        # print(node.text)
                elif subnode.get('val') == 'hidden2':
                    # print(subnode.get('val'))
                    for node in subsubchild.findall('Parameters'):
                        # print(node.text)
                        node.text = str(w[2].tolist())     # Replace
                        # print(node.text)
tree.write(target)        # store weights into this .xml file 
print('\033[92m'+'Successfully written to '+str(target)+" from "+str(source)+'\033[0m')

# import pybrain
# from pybrain.structure import FeedForwardNetwork
# from pybrain.tools.shortcuts import buildNetwork
# from pybrain.tools.customxml.networkwriter import NetworkWriter
# from pybrain.tools.customxml.networkreader import NetworkReader
# from pybrain.structure.modules.neuronlayer import NeuronLayer
# from pybrain.structure import LinearLayer, FullConnection, ReluLayer, BiasUnit
# import time
# from time import time
# import numpy as np

# brain = FeedForwardNetwork()

# inputLayer = LinearLayer(4, name = 'in')
# bias1 = BiasUnit(name = 'bias1')
# hiddenLayer1 = ReluLayer(24, name = 'hidden1') #deep layer 1
# bias2 = BiasUnit(name = 'bias2')
# hiddenLayer2 = ReluLayer(16, name = 'hidden2') #deep layer 2
# bias3 = BiasUnit(name = 'bias3')
# outLayer = LinearLayer(2, name = 'out')


# brain.addInputModule(inputLayer)
# brain.addModule(bias1)
# brain.addModule(hiddenLayer1)
# brain.addModule(bias2)
# brain.addModule(hiddenLayer2)
# brain.addModule(bias3)
# brain.addOutputModule(outLayer)

# in_to_hidden1 = FullConnection(inputLayer, hiddenLayer1)
# hidden1_to_hidden2 = FullConnection(hiddenLayer1, hiddenLayer2)
# hidden_to_out = FullConnection(hiddenLayer2, outLayer)
# bias1_to_hidden1 = FullConnection(bias1, hiddenLayer1)
# bias2_to_hidden2 = FullConnection(bias2, hiddenLayer2)
# bias3_to_out = FullConnection(bias3, outLayer)

# brain.addConnection(in_to_hidden1)
# brain.addConnection(bias1_to_hidden1)
# brain.addConnection(hidden1_to_hidden2)
# brain.addConnection(bias2_to_hidden2)
# brain.addConnection(hidden_to_out)
# brain.addConnection(bias3_to_out)

# brain.sortModules()
# x = 'dataset_'
# i = 1;
# # NetworkWriter.writeToFile(brain, 'saved_net_24_24.xml')
# # brain = NetworkReader.readFrom('saved_net_24_24.xml') 
# # NetworkWriter.writeToFile(brain, x+str(i)+'.xml')
# brain = NetworkReader.readFrom(x+str(i)+'.xml') 
# print('DONE')

