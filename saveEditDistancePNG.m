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



% Saves the graph as a PNG. Nodes are colored according to local edit distance.
%
% Note: Requires graphviz (neato), only 2D
%
% param1: graph index
% param2: filename
% param3: node attributed edit cost
% param3: maxCost (if maxCost <= 0, local edit distance is scaled in reference to largest value)
%
function saveEditDistancePNG(graphIndex, filename, nodeAttributedCost, maxCost)
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.")  
  
  load(strcat(GRAPHDIR,int2str(graphIndex),".ggr"));
  [n,e,p,d] = getGraphStats(graphIndex);
  assert(d == 2, "Function requires nodes with 2D-cooordinates.");
  
  assert(!strcmp(class(nodeAttributedCost), "cell"), "(n,1)-array of node attributed costs for ONE graph required here.")
  assert(length(nodeAttributedCost) == n, "Node attributed cost vector does not match to graph.");
  
  canvasSize = 20; % inches
  nodeSize = canvasSize / 50;
  edgeWidth = 4;
  % scale coordinates
  m = max(max(coordinates));
  coordinates = coordinates/m*canvasSize;
  % colors
  colorscheme = "spectral10";
  nColors = 10;
  if(maxCost > 0)
    nodeAttributedCost = nodeAttributedCost / maxCost;
    nodeAttributedCost = min(1, nodeAttributedCost);
  else
    maxCost = max(nodeAttributedCost);
    nodeAttributedCost = nodeAttributedCost / maxCost;
  endif
  nodeColors = nColors - round(nodeAttributedCost * nColors);
  nodeColors = max(1, nodeColors);
  
  f = fopen("graph_to_PNG_tmp", "w");
  
  % write header
  fprintf(f,"GRAPH %d { \n size=%f; \n", graphIndex, canvasSize);
  
  % write nodes
  for i=1:n
    x = coordinates(i,1);
    y = coordinates(i,2);
    nodeColor = nodeColors(i);
    fprintf(f, "%d [pos=\"%f,%f!\", shape=point, height=%f, width=%f, style=filled, colorscheme=%s, color=%d];\n" , i, x, y, nodeSize, nodeSize, colorscheme, nodeColor);
  endfor
  
  % write edges
  for i=1:n
    entries = adjacencyList{i};
    entries(find(entries < i)) = [];
    for j=1:length(entries)
      entry = entries(j);
      % determine edge color
      edgeColor = round((nodeAttributedCost(i) + nodeAttributedCost(entry)) / 2 * nColors);
      edgeColor = nColors - edgeColor;
      edgeColor = max(1, edgeColor);
      fprintf(f, "%d -- %d [penwidth = %f, colorscheme = %s, color = %d]", i, entry, edgeWidth, colorscheme, edgeColor);
    endfor
  endfor
  
  fprintf(f,"} \n");
  fclose(f);
  
  % Create PNG with neato
  command = strcat("neato -Tpng -o",filename," graph_to_PNG_tmp");
  [status, output] = system(command);
  assert(status == 0, "Call to neato failed. Graphviz installed ?");
  
  unlink("graph_to_PNG_tmp");
  
endfunction