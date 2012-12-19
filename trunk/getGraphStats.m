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



% Returns number of nodes and edges.
%
% param1: graph index
% retVal1: number of nodes
% retVal2: number of edges
% retVal3: number of partitions
% retVal4: dimension of node coordinates
%
function [numNodes, numEdges, numPartitions, dimension] = getGraphStats(graphIndex)
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
  
  load(strcat(GRAPHDIR,int2str(graphIndex),".ggr"));
  numNodes = length(adjacencyList);
  numEdges = getNumEdges(adjacencyList);
  load(strcat(GRAPHDIR,int2str(graphIndex),".clo"),"partitions");
  numPartitions = max(partitions);
  dimension = size(coordinates)(1,2);
endfunction