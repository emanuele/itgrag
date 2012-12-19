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



% Reads a graph in dot format (with limitations).
%
% Note: Only scans for x,y-attributes in undirected graph.
%	Requires nodes to be labelled 1..n.
%
% param1: file name
% retVal1: coordinates
% retVal2: adjacency list
%
function [coordinates, adjL] = readDot(filename)
  f = fopen(filename, "r");
  assert(f != -1, "File could not be opened.");
  
  nodeIDs = [];
  coordinates = [];
  % scan for nodes
  while(!feof(f))
    line = fgetl(f);
    line = untabify(line);
    line = strrep(line," ","");
    line = strrep(line,"\"","");
    s = regexp(line, '.*(y=.*x=|x=.*y=).*');
    if(length(s)) % line specifies a node
      [newNode,s] = strread(line,"%d[%s");
      nodeIDs = [nodeIDs; newNode];
      line = strrep(line,"[",",");
      line = strrep(line,"]",",");
      %line
      [s, e, te, m, t, nm] = regexp(line, ',x=.*,');
      strX = strsplit(m{1},",");
      x = strread(strX{2},"x=%f");
      [s, e, te, m, t, nm] = regexp(line, ',y=.*,');
      strY = strsplit(m{1},",");
      y = strread(strY{2},"y=%f"); 
      coordinates = [coordinates; x, y];
    endif
  endwhile
  
  n = max(nodeIDs);
  assert(n == length(nodeIDs), "Nodes mus be labelled from 1 to n");
  
  % sort nodeIDs (as they might be specified in arbitrary order in the dot file)
  [nodeIDs, idx] = sort(nodeIDs);
  coordinates = coordinates(idx,:);
  
  % scan edges
  frewind(f);
  edges = [];
  while(!feof(f))
    line = fgetl(f);
    line = untabify(line);
    line = strrep(line," ","");
    line = strrep(line,"\"","");
    s = regexp(line, '.*--.*');
    if(length(s)) % line specifies an edge
      [s, e, te, m, t, nm] = regexp(line, '\d+--\d+');
      [a,b] = strread(m{1},"%d--%d");
      edges = [edges; a b];
    endif
  endwhile
  fclose(f);

  % build adjacency list  
  assert(max(max(edges)) <= n);
  adjL = cell(n,1);
  for i=1:size(edges)(1,1)
    a = edges(i,1);
    b = edges(i,2);
    entries = adjL{a};
    entries = [entries, b];
    adjL{a} = entries;
    entries = adjL{b};
    entries = [entries, a];
    adjL{b} = entries;
  endfor
  checkAdjacencyListConsistency(adjL);
  
endfunction