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



% Partitions graph with METIS. 
%
% IMPLEMENTS partitioning function
%
% Note: METIS must be installed. Graph must not contain isolated nodes.
% Refer to: http://glaros.dtc.umn.edu/gkhome/views/metis
%
% param1: node coordinates
% param2: adjacency list
% param3: {desired number of partitions}
% retVal1: partitions 
%
function partitions = partitionMETIS(coordinates, adjacencyList, parameters)
  % check parameters
  assert(isa(parameters,"cell"));
  assert(size(parameters) == [1,1]);
  numPart = parameters{1};
  
  % save adjacency list to file in METIS format
  saveAdjacencyListMETIS(adjacencyList,"tmp.graph");
  
  % call METIS
  command = sprintf("gpmetis tmp.graph %d", numPart);
  [status, output] = system(command);
  if(status != 0)
    error("System call to gpmetis failed.");
  endif
  
  % recover partitions
  partFileName = strcat("tmp.graph.part.",int2str(numPart));
  load("-ascii", partFileName);
  partitions = tmp_graph_part;
  partitions += 1;
  
  % delete tmp-files
  command = "rm tmp.graph tmp.graph.part.*";
  [status, output] = system(command);
  if(status != 0)
    error("System call to remove tmp-files failed.");
  endif
  
endfunction