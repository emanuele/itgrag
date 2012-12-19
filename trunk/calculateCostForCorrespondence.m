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



% Calculates the edit cost for a given correspondence of nodes.
%
% param1: correspondence
% param2: coordinates 1
% param3: adjacency list 1
% param2: coordinates 2
% param3: adjacency list 2
% retVal1: edit cost
% retVal2: node attributed edit cost
%
function [cost, nodeAttributedCost] = calculateCostForCorrespondence(correspondence, coordinates1, adjL1, coordinates2, adjL2)
  global COSTS;
  
  % debug
  %correspondence
  
  n1 = length(adjL1);
  n2 = length(adjL2);
  
  nodeAttributedCost1 = zeros(n1,1);
  nodeAttributedCost2 = zeros(n2,1);
    
  % determine node classes
  remove = correspondence(:,1)(find(correspondence(:,2) == -1));
  keepOld = correspondence(:,1)(find(correspondence(:,2) != -1));
  keepNew = correspondence(:,2)(find(correspondence(:,2) != -1));
  idx = [1:n2];
  idx(keepNew) = [];
  add = idx;
  
  remove = sort(remove);
  keepOld = sort(keepOld);
  keepNew = sort(keepNew);
  add = sort(add);
  
  global COSTS;
  nodeCost = COSTS{1};
  edgeCost = COSTS{2};
  nodeMoveFunction = COSTS{3};
  nodeMoveParameters = COSTS{4};
  edgeStretchFunction = COSTS{5};
  edgeStretchParameters = COSTS{6};
  
  % iterate over remove 
  for i = 1:length(remove)
    id = remove(i);
    nodeAttributedCost1(id) += nodeCost;
    entries = adjL1{id};
    for j=1:length(entries) % edges that are deleted together with node
      entry = entries(j);
      nodeAttributedCost1(id) += 0.5*edgeCost;
      nodeAttributedCost1(entry) += 0.5*edgeCost;
      entries2 = adjL1{entry};
      entries2(find(entries2 == id)) = [];
      adjL1{entry} = entries2;
    endfor
  endfor
    
  % iterate over keep 
  for i = 1:length(keepOld)
    idOld = keepOld(i);
    idNew = keepNew(i);
    displacement = norm(coordinates1(idOld,:)-coordinates2(idNew,:),2);
    nodeAttributedCost1(idOld) += nodeMoveFunction(displacement, nodeMoveParameters);      
    entriesOld = adjL1{idOld};
    entriesNew = adjL2{idNew};
    for j = 1:length(entriesOld)
      entryOld = entriesOld(j);
      entryNew = correspondence(entryOld,2);
      if(length(find(entriesNew == entryNew))) % existing edge is not deleted
	oldLength = norm(coordinates1(idOld,:) - coordinates1(entryOld,:),2);
	newLength = norm(coordinates2(idNew,:) - coordinates2(entryNew,:),2);
	edgeStretchCost = edgeStretchFunction(abs(oldLength - newLength), edgeStretchParameters);
	nodeAttributedCost1(idOld) += 0.5*edgeStretchCost;
	nodeAttributedCost1(entryOld) += 0.5*edgeStretchCost;
	entriesNew(find(entriesNew == entryNew)) = [];
      else % existing edge is deleted
	nodeAttributedCost1(idOld) += 0.5*edgeCost;
	nodeAttributedCost1(entryOld)  += 0.5*edgeCost;
      endif
      % delete entries of adjacent nodes, such that each edge is only treated once
      entriesTmp = adjL1{entryOld};
      entriesTmp(find(entriesTmp == idOld)) = [];
      adjL1{entryOld} = entriesTmp;
      entriesTmp = adjL2{entryNew};
      entriesTmp(find(entriesTmp == idNew)) = [];
      adjL2{entryNew} = entriesTmp;
    endfor
    
    %nodeAttributedCost1
    %entriesNew

    % new edge between keep nodes
    for j = 1:length(entriesNew)
      entry = entriesNew(j);
      if(length(find(keepNew == entry)))
	entryOld = correspondence(find(correspondence(:,2) == entry),1);
	nodeAttributedCost1(idOld) += 0.5*edgeCost;
	nodeAttributedCost1(entryOld) += 0.5*edgeCost;
	entriesTmp = adjL2{entry};
	entriesTmp(find(entriesTmp == idNew)) = [];
	adjL2{entry} = entriesTmp;
      endif
    endfor
  endfor
    
  % debug
  %add 
  
  % iterate over add
  for i = 1:length(add)
    id = add(i);
    nodeAttributedCost2(id) += nodeCost;
    entries = adjL2{id};
    for j = 1:length(entries)
      entry = entries(j);
      if(length(find(add == entry))) % edge between add nodes
	nodeAttributedCost2(id) += 0.5*edgeCost;
	nodeAttributedCost2(entry) += 0.5*edgeCost;
	entriesTmp = adjL2{entry};
	entriesTmp(find(entriesTmp == id)) = [];
	adjL2{entry} = entriesTmp;
      else % edge between keep and add node
	entryOld = correspondence(find(correspondence(:,2) == entry),1);
	nodeAttributedCost1(entryOld) += 0.5*edgeCost;
	nodeAttributedCost2(id) += 0.5*edgeCost;	
      endif
    endfor
  endfor
  
  cost = sum(nodeAttributedCost1) + sum(nodeAttributedCost2);
  nodeAttributedCost = {nodeAttributedCost1, nodeAttributedCost2};
  
  % debug
  %disp("-------");
endfunction