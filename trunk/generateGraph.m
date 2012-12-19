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



% Generates a graph without nodes and edges.
%
% param1: coordinates
% param2: adjacency list
% returnVal: index of new graph 
%
function newGraphIndex = generateGraph(coordinates, adjacencyList)

  % load current index
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  idx+=1;

  % check parameters
  assert(size(coordinates)(1,1) == length(adjacencyList), "Coordinates and adjacency list size do not match.");
  checkAdjacencyListConsistency(adjacencyList);
  n = length(adjacencyList);
  
  % save graph 
  save(strcat(GRAPHDIR,int2str(idx),".ggr"),"coordinates","adjacencyList");
  
  % save creation log
  meta = {"generateGraph"};
  parents = [];
  deltas = {};
  partitions = ones(n,1);
  save(strcat(GRAPHDIR,int2str(idx),".clo"),"meta", "parents", "deltas", "partitions");
  
  % save incremented index
  save(strcat(GRAPHDIR,"meta"),"idx");
  
  % return index of new graph
  newGraphIndex = idx;
  
endfunction