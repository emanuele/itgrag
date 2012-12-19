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



% Stub for testing calculateCostForCorrespondences
%
% param1: graph index 1
% param2: graph index 2
% retVal1: cost
% retVal2: node attributed cost
%
function [cost, nodeAttributedCost] = testCalculateCost(idx1, idx2)
  correspondences = traceNodeIDs(idx1, idx2);
  coordinates1 = loadCoordinates(idx1);
  adjL1 = loadAdjacencyList(idx1);
  coordinates2 = loadCoordinates(idx2);
  adjL2 = loadAdjacencyList(idx2);
  [cost, nodeAttributedCost] = calculateCostForCorrespondence(correspondences, coordinates1, adjL1, coordinates2, adjL2);
endfunction


