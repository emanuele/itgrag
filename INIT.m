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



% Sets up path to graph directory.
% Creates meta file with index 0, if graph direcctory is empty.

basepath = mfilename("fullpath");
l = length(basepath);
basepath = substr(basepath, 1, l-4);
global GRAPHDIR;
GRAPHDIR = strcat(basepath,"graphs/");

% If you have a custom directory, delete the five lines above and use:
% global GRAPHDIR = "/your/path/"

if(! isdir(GRAPHDIR))
  status = mkdir(GRAPHDIR);
  assert(status == 1, "Failed creating graph directory.");
endif

% Create meta file with graph index 1, if it does not already exist.
[info, err, msg]=stat(strcat(GRAPHDIR, "meta"));
if(err == -1)
  idx = 0;
  save(strcat(GRAPHDIR, "meta"), "idx");
endif

% set default cost values for elementary edit operations
global COSTS;
COSTS = {2, 1, @linearThresholded, {1,0}, @linearThresholded, {1,1}};