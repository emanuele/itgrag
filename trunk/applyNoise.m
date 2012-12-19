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



% Displace nodes randomly.
%
% param1: graph index
% param2: partition index
% param3: minimum displacement in one dimension
% param4: maximum displacement in one dimension
% returnVal: new graph index
%
function newGraphIndex = applyNoise(graphIndex, partition, minDisplacement, maxDisplacement);
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
    
  [localNodes, localAdjL] = getLocalAdjacencyList(graphIndex, partition); 
  n = length(localNodes);
  [numNodes, numEdges, numPartitions, numDimensions] = getGraphStats(graphIndex);
  
  displacements = unifrnd(minDisplacement, maxDisplacement, n, numDimensions);
  signs=unifrnd(-1,1,n,numDimensions);
  signs(find(signs==0))=1;
  displacements=displacements.*sign(signs);
  
  % displace nodes
  if(n)  
    newGraphIndex = distortGraph(graphIndex, @displaceNodes, {localNodes, displacements});
  else
    newGraphIndex = graphIndex;
  endif
endfunction