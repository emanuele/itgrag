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



% Adds edges to graph.
%
% IMPLEMENTS: distortion function
%
% param1: coordinates
% param2: adjacency list
% param3: parameters: {[source nodes, target nodes]}
% retVal1: coordinates
% retVal2: adjacency list
% retVal3: deltas
%
function [coordinates, adjacencyList, deltas] = addEdges(coord, adjL, parameters)
  % check parameters
  assert(isa(parameters,'cell'));
  assert(size(parameters) == [1,1]);
  edges = parameters{1};
  n = size(edges)(1,1);
  assert(n > 0);
  
  coordinates = coord;
  adjacencyList = adjL;
  for i=1:n
    % check if edge not already exists
    sourceNode = edges(i,1);
    targetNode = edges(i,2);
    if(length(find(adjacencyList{sourceNode} == targetNode)))
      error("Edge %d %d already exists.", sourceNode, targetNode);
    endif
    % create edge
    adjEntries=adjacencyList{sourceNode};
    adjEntries=[adjEntries,targetNode];
    adjacencyList{sourceNode}=adjEntries;
    adjEntries=adjacencyList{targetNode};
    adjEntries=[adjEntries,sourceNode];
    adjacencyList{targetNode}=adjEntries;    
  endfor
  
  deltas = {"edge", "add", edges};

endfunction