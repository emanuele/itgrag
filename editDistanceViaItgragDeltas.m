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



% Determines the edit distance via the known delta operations performed by Itgrag.
%
% param1: graph index 1
% param2: graph index 2
% param3: {}
% retVal1: edit cost
% retVal2: node attributed edit cost
%
function [cost, nodeAttributedCost] = editDistanceViaItgragDeltas(graphIndex1, graphIndex2, parameters)
  
  coordinates1 = loadCoordinates(graphIndex1);
  adjL1 = loadAdjacencyList(graphIndex1);
  coordinates2 = loadCoordinates(graphIndex2);
  adjL2 = loadAdjacencyList(graphIndex2);
  
  commonAncestor = getClosestAncestor(graphIndex1, graphIndex2);
  
  coordinates3 = loadCoordinates(commonAncestor);
  adjL3 = loadAdjacencyList(commonAncestor);
  
  correspondenceAncestorTo1 = traceNodeIDs(commonAncestor, graphIndex1);
  correspondenceAncestorTo2 = traceNodeIDs(commonAncestor, graphIndex2);

  n = length(adjL1);
  correspondence = zeros(n,2);
  correspondence(:,1) = [1:n];
  correspondence(:,2) = -1;
  
  c = [];
  for i =1:size(correspondenceAncestorTo1)(1,1)
    a = correspondenceAncestorTo1(i,2);
    b = correspondenceAncestorTo2(i,2);
    if(a != -1 && b != -1)
      c = [c; a, b];
    endif
  endfor
  
  correspondence(c(:,1),2) = c(:,2);
  
  [cost, nodeAttributedCost] = calculateCostForCorrespondence(correspondence, coordinates1, adjL1, coordinates2, adjL2);
endfunction