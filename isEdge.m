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



% Checks if edge is present.
%
% param1: adjacencyList
% param2: source node
% param3: target node
% retVal: 1 if edge exists, 0 otherwise
%
function exists = isEdge(adjL, a, b)
  n = length(adjL);
  assert((a > 0) & (a <= n));
  assert((b > 0) & (b <= n));
  
  exists = length(find(adjL{a} == b));

endfunction