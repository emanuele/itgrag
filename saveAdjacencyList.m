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



% Saves adjacency list in a plain text file.
%
% Format: nodeID neighbour1 neighbour2 ...
% Example:
% 1 4 
% 2
% 3 4
% 4 1 3
% ...
%
% param1: graph index
% param2: file name
%
function saveAdjacencyList(graphIndex, file)

  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.")  
  
  load(strcat(GRAPHDIR,int2str(graphIndex),".ggr"),"adjacencyList");
  n = size(adjacencyList)(1,1);
  filehandle = fopen(file, "w");
  for i=1:n
    fprintf(filehandle,"%d ",i);
    l = length(adjacencyList{i});
    for j=1:l
      if(j<l)
	fprintf(filehandle, "%d ", adjacencyList{i}(j));
      else
	fprintf(filehandle, "%d", adjacencyList{i}(j));
      endif
    endfor
    if (i<n)
      fprintf(filehandle,"\n");
    endif
  endfor
  fclose(filehandle);
  
endfunction