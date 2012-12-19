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



% Some testcases, execute with "test verification" 


% test connection functions
%
%!test 
%!
%! INIT;
%! CLEAR;
%! INIT;
%! load("testdata");
%! ADJL = adjL;
%! COORD = A;
%!
%! pdf = @fixedCoordinates;
%! pdp = {COORD};
%! pcf1 = @connectThreshold;
%! pcf2 = @connectThresholdGrid;
%! pcp = {0.3};
%! i1 = generateRandomGraph(pdf, pdp, pcf1, pcp);
%! i2 = generateRandomGraph(pdf, pdp, pcf2, pcp);
%! i3 = generateGraph(COORD, ADJL);
%! aL1 = loadAdjacencyList(i1);
%! aL2 = loadAdjacencyList(i2);
%! aL3 = loadAdjacencyList(i3);
%! checkAdjacencyListConsistency(aL1);
%! checkAdjacencyListConsistency(aL2);
%! assertSameAdjacencyList(aL1, aL2);
%! assertSameAdjacencyList(aL2, aL3);
%! assertSameAdjacencyList(aL3, ADJL);


% test I/O functions
%
%!test
%!
%! INIT;
%! CLEAR;
%! INIT;
%! load("testdata");
%! ADJL = adjL;
%! COORD = A;
%! G0 = generateGraph(COORD, ADJL);
%!
%! i=generateEmptyGraph();
%! saveCoordinates(i, "coord");
%! saveAdjacencyList(i, "adjL");
%! saveAdjacencyMatrix(i, "adjM");
%! c1 = readCoordinates("coord");
%! c2 = loadCoordinates(i);
%! assert(c1 == c2);
%! aL1 = readAdjacencyList("adjL");
%! aL2 = loadAdjacencyList(i);
%! assertSameAdjacencyList(aL1, aL2);
%! aL3 = readAdjacencyMatrix("adjM");
%! assertSameAdjacencyList(aL2, aL3);
%! M = loadAdjacencyMatrix(i);
%! for i=1:size(M)(1,1)
%!   entr1 = find(M(i,:));
%!   entr2 = aL2{i};
%!   entr2 = sort(entr2);
%!   if(length(entr1) | length(entr2))
%!     assert(entr1 == entr2);
%! endif
%! endfor
%! G0=1;
%! saveCoordinates(G0, "coord");
%! saveAdjacencyList(G0, "adjL");
%! saveAdjacencyMatrix(G0, "adjM");
%! c1 = readCoordinates("coord");
%! c2 = loadCoordinates(G0);
%! assert(c1, c2, 0.01);
%! aL1 = readAdjacencyList("adjL");
%! aL2 = loadAdjacencyList(G0);
%! assertSameAdjacencyList(aL1, aL2);
%! aL3 = readAdjacencyMatrix("adjM");
%! assertSameAdjacencyList(aL2, aL3);
%! M = loadAdjacencyMatrix(G0);
%! for i=1:size(M)(1,1)
%!   entr1 = find(M(i,:));
%!  entr2 = aL2{i};
%!   entr2 = sort(entr2);
%!   if(length(entr1) || length(entr2))
%!     assert(entr1 == entr2);
%!   endif
%! endfor
%! system("rm coord adjL adjM");

% test I/O for dot format
%
%!test
%!
%! INIT;
%! CLEAR;
%! INIT;
%! load("testdata");
%! ADJL = adjL;
%! COORD = A;
%! G0 = generateGraph(COORD, ADJL);
%! saveDot(G0,"graph_dot");
%! [coordinates, adjL] = readDot("graph_dot");
%! assert(COORD(:,1:2), coordinates, 0.001);
%! assertSameAdjacencyList(ADJL, adjL);
%! system("rm graph_dot");

% test add/delete nodes/edges functions
%
%!test
%!
%! INIT;
%! CLEAR;
%! INIT;
%! load("testdata");
%! ADJL = adjL;
%! COORD = A;
%! G0 = generateGraph(COORD, ADJL);
%!
%! j=distortGraph(G0, @addEdges, {[1,4]});
%! adjL = loadAdjacencyList(j);
%! assert(isEdge(adjL, 1 ,4) == 1);
%! checkAdjacencyListConsistency(adjL);
%!
%! i=distortGraph(j, @deleteEdges, {[1,4]});
%! adjL = loadAdjacencyList(i);
%! assert(isEdge(adjL, 1 ,4) == 0);
%! checkAdjacencyListConsistency(adjL);
%! assertSameAdjacencyList(adjL, ADJL);
%!
%! i=distortGraph(j, @deleteEdges, {[1,4; 1, 17]});
%! adjL = loadAdjacencyList(i);
%! assert(isEdge(adjL, 1 ,4) == 0);
%! assert(isEdge(adjL, 1, 17) == 0);
%! checkAdjacencyListConsistency(adjL);
%!
%! i=distortGraph(i, @addEdges, {[1,4; 1, 17]});
%! adjL = loadAdjacencyList(i);
%! assert(isEdge(adjL, 1 ,4) == 1);
%! assert(isEdge(adjL, 1, 17) == 1);
%! checkAdjacencyListConsistency(adjL);
%! 
%! i=distortGraph(i, @deleteNodes, {1});
%! adjL = loadAdjacencyList(i);
%! assert(length(adjL) == 99);
%! checkAdjacencyListConsistency(adjL);
%! 
%! i=distortGraph(i, @addNodes, {COORD(1,:)});
%! adjL = loadAdjacencyList(i);
%! assert(length(adjL) == 100);
%! checkAdjacencyListConsistency(adjL);


% test edit distance (direct ancestry)
%
%!test
%!
%! INIT;
%! CLEAR; 
%! INIT;
%! i1 = generateEmptyGraph;
%! i2 = distortGraph(i1, @addNodes, {zeros(1,2)});
%! i3 = distortGraph(i2, @addNodes, {[1,0]});
%! i4 = distortGraph(i3, @addEdges, {[1,2]});
%! i5 = distortGraph(i4, @deleteNodes, {1});
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i1,i1);
%! assert(cost == 0);
%! assert(size(nodeAttributedCost{1}) == [0,1]);
%! assert(size(nodeAttributedCost{2}) == [0,1]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i1, i2);
%! assert(cost == 2);
%! assert(size(nodeAttributedCost{1}) == [0,1]);
%! assert(nodeAttributedCost{2} == [2]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i1, i3);
%! assert(cost == 4);
%! assert(size(nodeAttributedCost{1}) == [0,1]);
%! assert(nodeAttributedCost{2} == [2;2]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i1, i4);
%! assert(cost == 5);
%! assert(size(nodeAttributedCost{1}) == [0,1]);
%! assert(nodeAttributedCost{2} == [2.5;2.5]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i1, i5);
%! assert(cost == 2);
%! assert(size(nodeAttributedCost{1}) == [0,1]);
%! assert(nodeAttributedCost{2} == [2]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i2, i3);
%! assert(cost == 2);
%! assert(nodeAttributedCost{1} == [0]);
%! assert(nodeAttributedCost{2} == [0;2]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i2, i4);
%! assert(cost == 3);
%! assert(nodeAttributedCost{1} == [0.5]);
%! assert(nodeAttributedCost{2} == [0;2.5]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i2, i5);
%! assert(cost == 4);
%! assert(nodeAttributedCost{1} == [2]);
%! assert(nodeAttributedCost{2} == [2]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i3, i4);
%! assert(cost == 1);
%! assert(nodeAttributedCost{1} == [0.5;0.5]);
%! assert(nodeAttributedCost{2} == [0;0]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i3, i5);
%! assert(cost == 2);
%! assert(nodeAttributedCost{1} == [2;0]);
%! assert(nodeAttributedCost{2} == [0]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i4, i5);
%! assert(cost == 3);
%! assert(nodeAttributedCost{1} == [2.5;0.5]);
%! assert(nodeAttributedCost{2} == [0]);
%! 
%! [cost, nodeAttributedCost] = testCalculateCost(i4,i4);
%! assert(cost == 0);
%! assert(nodeAttributedCost{1} == [0;0]);
%! assert(nodeAttributedCost{2} == [0;0]);


% test edit distance (splitted ancestry, node displacement)
%
%!test
%!
%! INIT;
%! CLEAR;
%! INIT;
%!
%! coordinates = [-1 1; 0 1; 0 0; -1 -1; 0 -1];
%! adjL = {[3 4]; []; [1 4 5]; [1 3]; [3]};
%! i1 = generateGraph(coordinates, adjL);
%! i2 = distortGraph(i1, @addEdges, {[2 3]});
%! i3 = distortGraph(i2, @deleteNodes, {[1 4]});
%! i4 = distortGraph(i2, @addNodes, {[1 0; 2 0]});
%! i5 = distortGraph(i4, @addEdges, {[3 6; 6 7]});
%! i6 = distortGraph(i5, @displaceNodes, {3, [-1 0]});
%!
%! % no cost for node movement (threshold = 0)
%! % edge length cost linear, thresholded by 2
%! SET_EDIT_COST(2, 1, @linearThresholded, {1,0}, @linearThresholded, {1,2});
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0.5; 1.5; 3; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 2; 2], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 1; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.5; 1.621; 0.207; 0.207], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 1; 3; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 2; 2], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.207; 1.328; 0.207; 0.207], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.5; 1.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 1; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 1; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0; 2; 2], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 1.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 1.914; 0.207], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0; 2; 2], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 2; 2], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 1; 3; 0; 2; 2], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.207; 1.328; 0.207; 0.207; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 1; 0; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 1.5; 3; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.207; 1.328; 0.207; 0.207; 0.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.5; 1.621; 0.207; 0.207; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.207; 1.328; 0.207; 0.207; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0.207; 1.914; 3; 0.207; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.207; 1.328; 0.207; 0.207; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.207; 0.207; 1.328; 0.207; 0.207; 0.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%!
%! % linear cost for node movement, thresholded by 2
%! % no edge length cost (threshold = 0)
%! SET_EDIT_COST(2, 1, @linearThresholded, {1,2}, @linearThresholded, {1,0});
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0.5; 1.5; 3; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 2; 2], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 1; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i1, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 2; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 1; 3; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 2; 2], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i2, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 1.5; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0.5; 1.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 1; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 1; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0; 2; 2], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 1.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i3, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 2.5; 0], 0.001);
%! assert(nodeAttributedCost{2}, [3; 0; 0; 3; 0; 3; 2.5], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 0.5; 0; 0; 2; 2], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 2; 2], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 1; 3; 0; 2; 2], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i4, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 1.5; 0; 0; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 1; 0; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 1.5; 3; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0.5; 0; 0; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i5, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 1; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i1, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0.5; 2; 0; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i2, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 1.5; 0; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i3, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [3; 0; 2.5; 3; 0; 3; 2.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i4, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 1.5; 0; 0; 1; 0.5], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i5, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 1; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! [cost, nodeAttributedCost] = getEditDistance(i6, i6, @editDistanceViaItgragDeltas, {});
%! assert(nodeAttributedCost{1}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%! assert(nodeAttributedCost{2}, [0; 0; 0; 0; 0; 0; 0], 0.001);
%!
%! CLEAR; % as this is the last testcase

