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



% Connects all nodes with a mutual euclidean distance below a specified threshold.
%
% IMPLEMENTS nodeConnectionFunction
%
% Note: Uses a brute force search. Use 'connectThresholdGrid' for larger graphs. 
% 
% param1: (n,d)-matrix with point coocrdinates
% param2: {threshold}
% returnVal: adjacency list 
%
function adjacencyList = connectThreshold(pointCoordinates, parameters)
  % check parameters
  assert(isa(parameters,'cell'));
  assert(size(parameters) == [1,1]);
  distanceThreshold = parameters{1};
  assert(distanceThreshold >= 0);
  [n,d] = size(pointCoordinates);
  
  adjacencyList = cell(n,1);
  
  % brute force search
  for i = 1:n
    for j = i+1:n
      dist = norm(pointCoordinates(i,:) - pointCoordinates(j,:), 2);
      if(dist <= distanceThreshold)
	adjacencyList{i} = [adjacencyList{i}, j];
	adjacencyList{j} = [adjacencyList{j}, i];
      end
    end
  end
  
end