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



% Takes a set of fixed coordinates as point distribution
%
% IMPLEMENTS pointDistributionFunction
%
% param1: coordinates: cell with (n,d)-array
% retVal: point distribution
%
function coordinates = fixedCoordinates(parameters)
  % check parameters
  assert(isa(parameters,'cell'));
  assert(size(parameters) == [1,1]);
  
  coordinates = parameters{1};
endfunction