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



% Saves adjacency list in a format readable by METIS.
%
% param1: adjacency list
% param2: file name
%
function saveAdjacencyListMETIS(adjacencyList, file) 
  n = size(adjacencyList)(1,1);
  nEdg = getNumEdges(adjacencyList);
  
  filehandle = fopen(file, "w");
  
  % print header
  fprintf(filehandle,'%d %d \n',n, nEdg);
  for i=1:n
    for j=1:length(adjacencyList{i})
      fprintf(filehandle, "%d ", adjacencyList{i}(j));
    endfor
    if (i<n)
      fprintf(filehandle,"\n");
    endif
  endfor
  
  fclose(filehandle);
  
end