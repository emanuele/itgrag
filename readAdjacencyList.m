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



% Reads adjacency list from file.
%
% Expected format: nodeID neighbour1 neighbour2 ...
% Example:
% 1 4 
% 2
% 3 4
% 4 1 3
% ...
%
% Note: No self loops allowed.
%
% param1: filename
% retVal: adjacency list
%
function adjL = readAdjacencyList(filename)
  f = fopen(filename, "r");
  assert(f != -1, "File could not be opened.");
  i = 1;
  adjL = {};
  while(!feof(f))
    line = fgetl(f);
    if(line == -1)
      break;
    endif
    entries =  strsplit(line," ");
    if(length(entries) >= 2)
      neighbours = [];
      for j = 2:length(entries)
	neighbours = [neighbours, str2num(entries{j})];
      endfor
      adjL{i,1} = neighbours;
    else
      adjL{i,1}=[];
    endif
    i += 1;
  endwhile
  fclose(f);
  checkAdjacencyListConsistency(adjL);
endfunction