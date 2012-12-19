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



% Deletes nodes from an adjacency list and redetermines the node indices.
%
% param1: adjacency list
% param2: indexes of nodes to delete
% returnVal1: new adjacency list
%
function newAdjacencyList = deleteFromAdjacencyList(adjacencyList, idx)
  n=size(adjacencyList)(1,1);
  if(length(idx)>=n)
    newAdjacencyList=cell(0,0);
  else
  % create dictionary from old to new indices (-1: delete) 
  newIndices=[1:n];
  for i=1:n
    if(length(find(idx==i)))
      newIndices(i)=-1;
    else
      newIndices(i)=i-length(find(idx<i));
    endif
  endfor
  % delete nodes
  idx=sort(idx,"descend");
  for i=1:length(idx)
    adjacencyList(idx(i))=[];
  endfor
  % update indices
  nNew=size(adjacencyList)(1,1);
  for i=1:nNew
    entries=adjacencyList{i};
    for j=1:length(entries)
      entries(j)=newIndices(entries(j));
    endfor
    entries(find(entries==-1))=[];
    adjacencyList{i}=entries;
  endfor
  newAdjacencyList=adjacencyList;
  endif
endfunction
