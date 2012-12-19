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



% Determines the IDs of identical nodes in a descendant graph
%
% param1: original graph
% param2: descendant graph
% retVal: dictionary of node IDs (entry is -1, if node is deleted)
% 
function dictionary = traceNodeIDs(original, descendant)
  assert(original <= descendant);
  n = getGraphStats(original);
  oldIDs = [1:n]';
  dictionary = [oldIDs, oldIDs];
  ancestry = getAncestors(descendant);
  ancestry = [ancestry, descendant];
  while(ancestry(1) != original)
    ancestry(1) = [];
  endwhile
  ancestry(1) = [];
  for i = 1:length(ancestry)
    idx = ancestry(i);
    deltas = loadCreationLog(idx).deltas;
    if(!length(deltas))
      continue;
    endif
    if(strcmpi(deltas{1}, "node") && strcmpi(deltas{2}, "delete"))
      deleteIdxs = deltas{3};
      deleteIdxs(find(deleteIdxs > n)) = [];
      nDelete = length(deleteIdxs);
      n -= nDelete;
      deleteIdxs = sort(deleteIdxs, "descend");
      for j = 1:length(deleteIdxs)
	deletedNode = deleteIdxs(j);
	dictionary(find(oldIDs > deletedNode),2) -= 1;
      endfor
      dictionary(deleteIdxs,2) = -1;
    endif
  endfor
  dictionary(find(dictionary(:,2) < 0),2)=-1;
endfunction
