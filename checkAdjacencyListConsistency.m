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



% Throws an error if adjacency list is inconsistent.
%
% param1: adjacency list
%
function checkAdjacencyListConsistency(adjL)
  n=size(adjL)(1,1);
  maxElement=0;
  for i=1:n
    entries = adjL{i};
    maxElement = max(maxElement, max(entries));
  endfor
  assert(maxElement <= n, "Adjacency list inconsistent.");
  for i=1:n
    entries = adjL{i};
    assert(length(find(entries == i)) == 0, "Adjacency list inconsistent.");
    for j=1:length(entries)
      targetNode=entries(j);
      targetEntries = adjL{targetNode};
      assert(length(find(targetEntries == i)) == 1, "Adjacency list inconsistent.");
    endfor
  endfor
endfunction