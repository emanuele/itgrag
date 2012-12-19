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



% Determines the edit distance with the specified method.
%
% param1: graphIndex1
% param2: graphIndex2
% param3: edit distance algorithm (function handle)
% param4: {edit distance algorihtm parameters}
% retVal1: edit cost
% retVal2: node attributed edit cost
%
function [cost, nodeAttributedCost] = getEditDistance(graphIndex1, graphIndex2, editDistanceAlgorithm, parameters)
  assert(class(editDistanceAlgorithm) == 'function_handle');
  assert(class(parameters) == 'cell');
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex1 <= idx, "Invalid graph index.");
  assert(graphIndex2 <= idx, "Invalid graph index.");
  
  [cost, nodeAttributedCost] = editDistanceAlgorithm(graphIndex1, graphIndex2, parameters);

endfunction