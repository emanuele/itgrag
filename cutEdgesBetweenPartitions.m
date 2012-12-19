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



% Cuts the edges between partitions.
%
% param1: adjacency list of partitioned graph
% param2: partitions (cell array with each cell having the node indices of the respective partition)
% retVal: adjacency list with removed edges
function newAdjacencyList = cutEdgesBetweenPartitions(adjacencyList, partitions)
  n=size(adjacencyList)(1,1);
  numPart = size(partitions)(1,1);
  newAdjacencyList = cell(n,1);
  for i=1:n
    % find partition of node i
    p=-1;
    for j=1:numPart
      if(length(find(partitions{j}==i)))
	p=j;
	break;
      endif
    endfor
    if(p==-1)
      error("Adjacency list not consistent with partitions.");
    endif
    % delete edges to nodes outside this partition
    exTargetNodes = adjacencyList{i};
    allowedTargetNodes = partitions{p};
    newTargetNodes = [];
    for j=1:length(exTargetNodes)
      node = exTargetNodes(j);
      if(length(find(allowedTargetNodes == node)))
	newTargetNodes = [newTargetNodes, node];
      endif
    endfor
    newAdjacencyList{i}=newTargetNodes;
  endfor
endfunction