#    Itgrag - Distort Geometric Graphs
#    Copyright (C) 2012  Philipp Harth (phil.harth@gmail.com)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


##############################################################################
%		SET UP ITGRAG
##############################################################################

% Always run INIT first in your script ! 
INIT


##############################################################################
%		GENERATE RANDOM GRAPH
##############################################################################

% Select a point distribution function
pointFunctionHandle = @uniformRandom;
pointFunctionParameters = {100, 2}; % [number of points, dimension]

% Select a node connection function
connectionFunctionHandle = @connectThreshold;
connectionFunctionParameters = {0.2}; % [distance threshold]

% Call generic generation function
g1 = generateRandomGraph(pointFunctionHandle, pointFunctionParameters, connectionFunctionHandle, connectionFunctionParameters);

% The properties of the new graph
[numNodes, numEdges, numPartitions, numDimensions] = getGraphStats(g1);

% Create PNG image of graph (requires graphviz)
# savePNG(g1, "demoGraph_1.png", 0);

% Graph is stored internally. To save it to file use:
saveCoordinates(g1, "demoGraph_1_Coord");
saveAdjacencyMatrix(g1, "demoGraph_1_AdjM");

% For other I/O functions, refer to README.pdf

##############################################################################
%		GENERATE GRAPH FROM EXISTING COORDINATES
##############################################################################

% read coordinates and adjacency matrix
coordinates = readCoordinates("demoGraph_1_Coord");
adjacencyList = readAdjacencyMatrix("demoGraph_1_AdjM");

g2 = generateGraph(coordinates, adjacencyList);


##############################################################################
%		DISTORT GRAPH
##############################################################################

% If your graph is unpartitioned, all nodes are in "partition 1".
% Apply structural noise to "partition 1":

% Delete 5 nodes randomly
g3 = deleteNodesRandom(g1, 1, 5);
% Delete 10 edges randomly
g3 = deleteEdgesRandom(g3, 1, 10);
% Add 10 edges randomly
g3 = addEdgesRandom(g3, 1, 10);

% Apply geometric noise:
g3 = applyNoise(g3, 1, 0.01, 0.03);

% Determine the edit distance between g1 and its distorted version g3
editCostAlgorithm = @editDistanceViaItgragDeltas;
[cost, nodeAttributedEditCost] = getEditDistance(g1, g3, editCostAlgorithm, {});

% Create PNG image of distortions (requires graphviz)
localDistortion =  nodeAttributedEditCost{1};
# saveEditDistancePNG(g1, "demoGraph_1_distorted.png", localDistortion, 0)

##############################################################################
%		PARTITION GRAPH AND DISTORT LOCALLY
##############################################################################
		## requires METIS to be installed ! ##

% Delete isolated nodes
isolatedNodes = getIsolatedNodes(g1);
if(length(isolatedNodes))
  g4 = distortGraph(g1, @deleteNodes, {isolatedNodes});
else
  g4 = g1;
endif

% Partition graph (requires METIS)
partitioningFunction =  @partitionMETIS;
partitioningParameters = {2};
# g5 = partitionGraph(g4, partitioningFunction, partitioningParameters);

% Apply geometric noise only to partition 2
# g5 = applyNoise(g5, 2, 0.01, 0.03);


##############################################################################
%		CLEAR INTERNAL STORAGE
##############################################################################

CLEAR;