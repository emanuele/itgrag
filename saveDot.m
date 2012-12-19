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



% Saves graph as dot format
%
% Author: Ayser Armiti
%
% http://en.wikipedia.org/wiki/DOT_language
% param1: graph index
% param2: file name
function saveDot(graphIndex, file)
  global GRAPHDIR;

  load(strcat(GRAPHDIR,"meta"),"idx");
  if(graphIndex > idx)
    error("Invalid graph index.");
  endif
  
  load(strcat(GRAPHDIR,int2str(graphIndex),".ggr"),"coordinates","adjacencyList");
  n = size(adjacencyList)(1,1);
  
  filehandle = fopen(file, "w");
  % print graph name
  fprintf(filehandle,strcat("graph \"",file,"\" {\n"));
  % print nodeID x y z
  numOfEdges = 0 ;
  for i=1:n
    fprintf(filehandle," %d [x=\"%f\",y=\"%f\"];\n",i,coordinates(i,1), coordinates(i,2));
    numOfEdges += length(adjacencyList{i}) ;
  endfor

   %print EDGES
   counter = 1;
   for i=1:n
    for j=1:length(adjacencyList{i})
      if(i <= adjacencyList{i}(j))
      	fprintf(filehandle," %d -- %d ;\n", i, adjacencyList{i}(j));
    	endif
      counter++;
    endfor
  endfor
   fprintf(filehandle,"}\n");
  fclose(filehandle);
  
endfunction
