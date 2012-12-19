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



% Generates a new graph and returns its index.
%
% param1: function handle to point distribution function
% param2: {point distribution parameters}
% param3: function handle to node connection function
% param4: {node connection parameters}
% returnVal: index of new graph 
%
function newGraphIndex = generateRandomGraph(pointDistributionFunction, pointDistributionParameters, nodeConnectionFunction, nodeConnectionParameters)
  % check parameters
  assert(class(pointDistributionFunction) == 'function_handle');
  assert(class(pointDistributionParameters) == 'cell');
  assert(class(nodeConnectionFunction) == 'function_handle');
  assert(class(nodeConnectionParameters) == 'cell');
  
  % generate graph
  coordinates = pointDistributionFunction(pointDistributionParameters);
  adjacencyList = nodeConnectionFunction(coordinates, nodeConnectionParameters);
  n = length(adjacencyList);
 
  % load current index
  global GRAPHDIR;
  
  load(strcat(GRAPHDIR,"meta"),"idx");
  idx+=1;
  
  % save graph
  save(strcat(GRAPHDIR,int2str(idx),".ggr"),"coordinates","adjacencyList");
  
  % save creation log
  meta={"generateRandomGraph", func2str(pointDistributionFunction), pointDistributionParameters, func2str(nodeConnectionFunction), nodeConnectionParameters};
  parents = [];
  deltas = {};
  partitions = ones(n,1);
  
  save(strcat(GRAPHDIR,int2str(idx),".clo"),"meta","parents", "deltas", "partitions");
  
  % save incremented index
  save(strcat(GRAPHDIR,"meta"),"idx");
  
  % return index of new graph
  newGraphIndex = idx;
  
end