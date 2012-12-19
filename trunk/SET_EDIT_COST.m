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



% Sets the edit costs for elementary operations.
%
% Note: The default cost values are set in INIT.
%
% param1: cost for node deletion / creation
% param2: cost for edge deletion / creation
% param3: cost function for node displacement
% param4: {node cost function parameters}
% param5: cost function for change in edge length
% param6: {edge cost function parameters}
%
function SET_EDIT_COST(nodeAddDelete, edgeAddDelete, nodeMovement, nodeMovementParameters, edgeLength, edgeLengthParameters)
  assert(class(nodeMovement) == "function_handle");
  assert(class(nodeMovementParameters) == "cell");
  assert(class(edgeLength) == "function_handle");
  assert(class(edgeLengthParameters) == "cell" );
  
  global COSTS;
  COSTS{1} = nodeAddDelete;
  COSTS{2} = edgeAddDelete;
  COSTS{3} = nodeMovement;
  COSTS{4} = nodeMovementParameters;
  COSTS{5} = edgeLength;
  COSTS{6} = edgeLengthParameters;
  
endfunction