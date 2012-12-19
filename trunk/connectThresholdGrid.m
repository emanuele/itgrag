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



% Connects all nodes with a mutual euclidean distance below a specified threshold.
%
% IMPLEMENTS nodeConnectionFunction
%
% Note: Requires 3-dimensional coordinates. Uses a uniform grid to speed up search.
%
% param1: (n,3)-matrix with point coordinates
% param2: {threshold}
% returnVal: adjacency list
%
function adjList = connectThresholdGrid(coord, parameters)
  % check coocrdinates
  assert(isa(parameters,'cell'));
  assert(size(parameters) == [1,1]);
  thresh = parameters{1};
  assert(thresh > 0);
  [n,d] = size(coord);
  assert(n >= 1);
  assert(d == 3);
  
  adjList=cell(n,1);
  
  % determine size of grid
  maxVal=max(max(coord));
  dGrid = thresh*1.01;
  nGrid = floor(maxVal/dGrid)+3;
  G=cell(nGrid,nGrid, nGrid);
  
  % fill grid
  for i=1:n
    p=coord(i,:);
    ix=floor(p(1)/dGrid)+2;
    iy=floor(p(2)/dGrid)+2;
    iz=floor(p(3)/dGrid)+2;
    G{ix,iy,iz}=[G{ix,iy,iz},i];
  end
  
  % determine number of points in grid cells
  pointsPerCell=cell(nGrid,nGrid,nGrid);
  for ix=2:nGrid-1
    for iy=2:nGrid-1
      for iz=2:nGrid-1
	entries=G{ix,iy,iz};
	pointsPerCell{ix,iy,iz} = length(entries);
      end
    end
  end
  
  % iterate over grid to build adjacency list
  for ix=2:nGrid-1
    for iy=2:nGrid-1
      for iz=2:nGrid-1
	lpoints = pointsPerCell{ix,iy,iz};
	if(!lpoints)
	  continue;
	endif
	
	points=G{ix,iy,iz};
	
	% same cell
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=i+1:lpoints
	    pi2=points(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	xi=ix+1;
	xd=ix-1;
	yi=iy+1;
	yd=iy-1;
	zi=iz+1;
	
	% +x
	points2=G{xi,iy,iz};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xi,iy,iz};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +y
	points2=G{ix,yi,iz};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{ix,yi,iz};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +z
	points2=G{ix,iy,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{ix,iy,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +x+y
	points2=G{xi,yi,iz};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xi,yi,iz};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +x-y
	points2=G{xi,yd,iz};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xi,yd,iz};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +x+y+z
	points2=G{xi,yi,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xi,yi,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% -x+y+z
	points2=G{xd,yi,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xd,yi,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +x-y+z
	points2=G{xi,yd,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xi,yd,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% -x-y+z
	points2=G{xd,yd,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xd,yd,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	 
	% -x+z
	points2=G{xd,iy,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xd,iy,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% +x+z
	points2=G{xi,iy,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{xi,iy,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	% -y+z
	points2=G{ix,yd,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{ix,yd,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	
	%  +y+z
	points2=G{ix,yi,zi};
	for i=1:lpoints
	  pi1=points(i);
	  p1=coord(pi1,:);
	  for j=1:pointsPerCell{ix,yi,zi};
	    pi2=points2(j);
	    p2=coord(pi2,:);
	    if(norm(p1-p2,2)<=thresh)
	      entr1 = adjList{pi1};
	      entr2 = adjList{pi2};
	      adjList{pi1}=[entr1,pi2];
	      adjList{pi2}=[entr2,pi1];
	    endif
	  endfor
	endfor
	 
      end % iz
    end % iy
  end % ix 
 
end