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



% Returns closest ancestors of two graphs.
%
% Note: Throws an error, if graphs have no common ancestor.
%
% param1: graph index 1
% param2: graph index 2
% retVal: graph indexes of ancestors
%
function closestAncestor = getClosestAncestor(graphIndex1, graphIndex2)
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex1 <= idx, "Invalid graph index.");
  assert(graphIndex2 <= idx, "Invalid graph index.");

  closestAncestor = 0;
  
  genealogy1 = [getAncestors(graphIndex1), graphIndex1];
  genealogy2 = [getAncestors(graphIndex2), graphIndex2];
  
  if(max(genealogy1) > max(genealogy2))
    tmp = genealogy1;
    genealogy1 = genealogy2;
    genealogy2 = tmp;
  endif
  
  genealogy1 = sort(genealogy1,"descend");
  
  for i=1:length(genealogy1)
    if(length(find(genealogy2 == genealogy1(i))))
      closestAncestor = genealogy1(i);
      break;
    endif
  endfor
  
  assert(closestAncestor != 0,"Graphs are not related.");
  
endfunction;