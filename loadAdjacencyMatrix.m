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



% Returns the adjacency matrix.
%
% param1: graph index
% returnVal: adjacencyMatrix
function adjacencyMatrix = loadAdjacencyMatrix(graphIndex)
  adjacencyList = loadAdjacencyList(graphIndex);
  n = size(adjacencyList)(1,1);
  if(n<=10000)
    adjacencyMatrix = zeros(n);
  else
    error("Adjacency matrix too large for Octave's index type.");
  endif  
  for i=1:n
    for j=i+1:n
      entry=0;
      if(length(find(adjacencyList{i}==j)))
	entry=1;
      endif
      adjacencyMatrix(i,j)=entry;
      adjacencyMatrix(j,i)=entry;
    endfor
  endfor

endfunction