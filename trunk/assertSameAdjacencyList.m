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



% Checks if two adjacency lists are the same
%
% param1: adjacency list 1
% param2: adjacency list 2
%
function assertSameAdjacencyList(adjL1, adjL2)
 n1=size(adjL1)(1,1);
 n2=size(adjL2)(1,1);
 assert(n1 == n2);
 for i=1:n1
   entries1 = adjL1{i};
   entries2 = adjL2{i};
   assert(length(entries1) == length(entries2));
   entries1=sort(entries1);
   entries2=sort(entries2);
   for j=1:length(entries1)
     assert(entries1(j) == entries2(j));
   endfor
 endfor
endfunction