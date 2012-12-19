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



% Creates a local adjacency list for a partition without edges crossing the partition boundaries.
%
% param1: graph index
% param2: partition index
% retVal1: nodes in partition
% retVal2: local adjacency list
%
function [localNodes, localAdjL] = getLocalAdjacencyList(graphIndex, partition)
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
  
  eligibleNodes = getNodesInPartition(graphIndex, partition);
  localNodes = eligibleNodes;
  n = length(eligibleNodes);
  assert(n > 0,"No nodes in partition.");
  
  % create local adjacency list
  localAdjL = loadAdjacencyList(graphIndex);
  localAdjL = localAdjL(eligibleNodes);
  for i = 1:n
    entries = localAdjL{i};
    deleteIdx = [];
    for j = 1:length(entries)
      if(!length(find(eligibleNodes == entries(j))))
	deleteIdx = [deleteIdx, j];
      endif
    endfor
    entries(deleteIdx) = [];
    localAdjL{i} = entries;
  endfor

endfunction