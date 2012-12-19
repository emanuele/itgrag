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



% Turns an adjacency list into an array of source and target nodes.
%
% param1: adjacency list
% retVal: (n,2)-array of edge ids
%
function edgeIDs = getEdgeIDsFromAdjacencyList(adjL)
  n = length(adjL);
  edgeIDs = [];
  for i = 1:n
    targetIdxs = find(adjL{i} > i);
    l = length(targetIdxs);
    if(l)
     newEdgeIDs = zeros(l, 1);
     newEdgeIDs(:,1) = i;
     targetNodes = adjL{i}(targetIdxs);
     edgeIDs = [edgeIDs; newEdgeIDs, targetNodes'];
    endif
  endfor
endfunction