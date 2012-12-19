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



% Create new graph by distorting existing graph.
%
% Note: If the distortion function adds nodes, the partitioning is reset.
%
% param1: function handle to distortion function 
% param2: distortion function parameters
% param3: index of graph that is distorted
% returnVal: index of distorted graph 
%
function newGraphIndex = distortGraph(graphIndex, distortionFunction, distortionFunctionParameters)
  % check parameters
  assert(class(distortionFunction) == 'function_handle');
  assert(class(distortionFunctionParameters) == 'cell');
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
  
  % distort graph
  coordinates = loadCoordinates(graphIndex);
  adjacencyList = loadAdjacencyList(graphIndex);
  [coordinates, adjacencyList, deltas] = distortionFunction(coordinates, adjacencyList, distortionFunctionParameters);

  % increment graph index
  load(strcat(GRAPHDIR,"meta"),"idx");
  idx+=1;
  
  % save graph
  save(strcat(GRAPHDIR,int2str(idx),".ggr"),"coordinates","adjacencyList");
  
  % save creation log
  meta={"distortGraph", func2str(distortionFunction), distortionFunctionParameters};
  parents = graphIndex;
  
  load(strcat(GRAPHDIR,int2str(graphIndex),".clo"), "partitions");
  n = length(adjacencyList);
  % reset partitioning, if nodes were added 
  if(strcmpi(deltas{1}, "node") && strcmpi(deltas{2}, "add"))
    partitions = ones(n, 1);
  endif
  % update partitioning if nodes are deleted
  if(strcmpi(deltas{1}, "node") && strcmpi(deltas{2}, "delete"))
    deleteIdxs = deltas{3};
    partitions(deleteIdxs) = [];
  endif
  
  save(strcat(GRAPHDIR,int2str(idx),".clo"),"meta","parents","deltas","partitions");
  
  % save incremented index
  save(strcat(GRAPHDIR,"meta"),"idx");
  
  % return index of new graph
  newGraphIndex = idx;
endfunction