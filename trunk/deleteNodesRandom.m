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



% Remove random nodes from existing graph.
%
% param1: graph index
% param2: partition index
% param3: numNodes
% returnVal: new graph index
%
function newGraphIndex = deleteNodesRandom(graphIndex, partition, numNodes);
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
    
  [localNodes, localAdjL] = getLocalAdjacencyList(graphIndex, partition); 
  n = length(localNodes);
  nDelete = min(numNodes, n);
  
  draw = localNodes;
  
  % draw random nodes
  nodes = [];
  for i=1:nDelete
    idx = unidrnd(length(draw));
    node = draw(idx);
    draw(idx) = [];
    nodes = [nodes, node];    
  endfor
  
  % delete nodes
  if(nDelete)
    newGraphIndex = distortGraph(graphIndex, @deleteNodes, {nodes});
  else
    newGraphIndex = graphIndex;
  endif
endfunction