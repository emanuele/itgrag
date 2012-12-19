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



% Reads adjacency matrix from file.
%
% Note: No self loops allowed.
%
% param1: filename
% retVal: adjacency list
%
function adjL = readAdjacencyMatrix(filename)
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
    entries(length(entries))=[];
    intEntries=[];
    for j=1:length(entries)
      intEntries = [intEntries, str2num(entries{j})];
    endfor
    neighbours = find(intEntries);
    if(length(neighbours))
      adjL{i,1} = neighbours;
    else
      adjL{i,1}=[];
    endif
    i += 1;
  endwhile
  fclose(f);
  checkAdjacencyListConsistency(adjL);
endfunction