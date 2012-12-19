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



% Returns adjacency list
%
% param1: graphIndex
% returnVal: adjacency list (cell array of dimension (n,1), with each cell containing a vector with the indices of adjacent points)
function adjList = loadAdjacencyList(graphIndex)
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  if(graphIndex > idx)
    error("Invalid graph index.");
  endif
  load(strcat(GRAPHDIR,int2str(graphIndex),".ggr"),"adjacencyList");
  adjList = adjacencyList;
endfunction
  