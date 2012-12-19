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



% Add random edges to existing graph.
%
% param1: graph index
% param2: partition index
% param3: numEdges
% returnVal: new graph index
%
function newGraphIndex = addEdgesRandom(graphIndex, partition, numEdges);
  global GRAPHDIR;
  load(strcat(GRAPHDIR,"meta"),"idx");
  assert(graphIndex <= idx, "Invalid graph index.");
    
  [localNodes, localAdjL] = getLocalAdjacencyList(graphIndex, partition); 
  n = length(localNodes);
  nAdd = min(numEdges, n*(n-1)/2 - getNumEdges(localAdjL));
  
  % determine potential source and target nodes for edges to be added
  potSourceNodes = [];
  potEdges = [];
  potTargetNodes = {};
  counter = 1;
  for i = 1:n
    entries = localAdjL{i};
    node = localNodes(i);
    % determine eligible target nodes
    tn = localNodes;
    idxs = [];
    for j=1:length(entries)
      idxs = [idxs, find(tn == entries(j))];
    endfor
    tn(idxs)=[];
    tn(find(tn <= node))=[];
    nPotEdges = length(tn);
    if(nPotEdges)
      potTargetNodes{counter} = tn;
      counter++;
      potSourceNodes = [potSourceNodes, node];
      potEdges = [potEdges, nPotEdges];
    endif
  endfor
  
  drawSourceNode = [];
  for i=1:length(potSourceNodes)
    k = ones(1,potEdges(i));
    k(:) = potSourceNodes(i);
    drawSourceNode = [drawSourceNode, k];
  endfor
   
  % draw source and target nodes
  edges = [];
  for i=1:nAdd
    % draw source node
    idx1 = unidrnd(length(drawSourceNode));
    sourceNode = drawSourceNode(idx1);
    drawSourceNode(idx1)=[];
    sourceNodeIndex = find(potSourceNodes == sourceNode);
    
    % draw target node
    targetNodes = potTargetNodes{sourceNodeIndex};
    idx2 = unidrnd(length(targetNodes));
    targetNode = targetNodes(idx2);
    targetNodes(idx2)=[];
    potTargetNodes{sourceNodeIndex} = targetNodes;
    
    edges = [edges; sourceNode, targetNode];    
  endfor
  
  % delete Edges
  if(nAdd)
    newGraphIndex = distortGraph(graphIndex, @addEdges, {edges});
  else
    newGraphIndex = graphIndex;
  endif
endfunction