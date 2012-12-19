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



% Partitions a graph and returns its index.
%
% Note: Graph must not contain isolated nodes.
%
% param1: index of graph to be partitioned
% param2: function handle to partitioning function
% param3: {partitioning parameters}
% returnVal1: index of partitioned graph 
% returnVal2: number of partitions
%
function [newGraphIndex, numPartitions] = partitionGraph(graphIndex, partitioningFunction, partitioningParameters)
  % check parameters
  assert(class(partitioningFunction) == 'function_handle');
  assert(class(partitioningParameters) == 'cell');
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
  
  if(length(getIsolatedNodes(graphIndex)))
     error("Graph must not contain isolated nodes for partitioning.")
  endif

  % load graph
  coordinates = loadCoordinates(graphIndex);
  adjacencyList = loadAdjacencyList(graphIndex);
 
  % partition graph
  partitions = partitioningFunction(coordinates, adjacencyList, partitioningParameters);
  partitions = relabelPartitions(partitions);
  numPartitions = max(partitions);
  
  % save graph
  idx+=1;
  save(strcat(GRAPHDIR,int2str(idx),".ggr"),"coordinates","adjacencyList");
  
  % save creation log
  meta={"partitionGraph", func2str(partitioningFunction), partitioningParameters};
  parents = graphIndex;
  deltas = {};
  save(strcat(GRAPHDIR,int2str(idx),".clo"),"meta","parents","deltas","partitions");

  % save incremented index
  save(strcat(GRAPHDIR,"meta"),"idx");
  
  % return index of new graph
  newGraphIndex = idx;
  
endfunction