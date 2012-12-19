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



% Relabels partitions to create consecutive numbering.
%
% param1: partitions
% retVal: relabeled partitions
%
function relabeled = relabelPartitions(partitions)
  relabeled = partitions;
  partitions = sort(partitions);
  nDistinct = 1;
  for i= 2:length(partitions)
    if(partitions(i-1) != partitions(i))
      nDistinct +=1;
    endif
  endfor
  for i=1:nDistinct
    m = max(relabeled);
    relabeled(find(relabeled == m)) = -i;
  endfor
  relabeled *= -1;
endfunction