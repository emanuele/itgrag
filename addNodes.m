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



% Adds nodes to a graph.
%
% IMPLEMENTS: distortion function
%
% Note: adding nodes resets the partitioning
%
% param1: coordinates
% param2: adjacency list
% param3: parameters: {node coordinates}
% retVal1: coordinates
% retVal2: adjacency list
% retVal3: deltas
%
function [coordinates, adjacencyList, deltas] = addNodes(coord, adjL, parameters)
  % check parameters
  assert(isa(parameters,'cell'));
  assert(size(parameters) == [1,1]);
  newCoordinates = parameters{1};
  n = size(newCoordinates)(1,1);
  d = size(newCoordinates)(1,2);
  assert(n > 0);
  
  % add nodes
  coordinates = [coord; newCoordinates];
  adjacencyList = adjL;
  adjacencyList{length(adjL) + n,1}=[];
  
  deltas = {"node", "add", newCoordinates};
  
endfunction