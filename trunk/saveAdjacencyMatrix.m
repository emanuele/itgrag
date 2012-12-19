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



% Saves adjacency matrix as plain text file.
%
% param1: graph index
% param2: file name
%
function saveAdjacencyMatrix(graphIndex, file)
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  if(graphIndex > idx)
    error("Invalid graph index.");
  endif
  
  load(strcat(GRAPHDIR,int2str(graphIndex),".ggr"),"adjacencyList");
  n = size(adjacencyList)(1,1);
  
  filehandle = fopen(file, "w");
  
  for i=1:n
    for j=1:n
      entry=0;
      if(length(find(adjacencyList{i}==j)))
	entry=1;
      endif
      fprintf(filehandle,"%d ",entry);
    endfor
    if (i<n)
      fprintf(filehandle,"\n");
    endif
  endfor
  
  fclose(filehandle);
  
endfunction