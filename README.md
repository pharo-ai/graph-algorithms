# Graph Algorithms

![Build status](https://github.com/pharo-ai/edit-distances/actions/workflows/ci.yml/badge.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)

## Description

This a re-implementation of an ancient version of graphs algorithms package from [Moose](https://github.com/moosetechnology). Also, several algorithms were added. The nodes in the graph can be any kind of object: a Character, a String, an Integer or a complex object.

## Available graph algorithms

  - Tarjan’s Algorithm: Strongly Connected Components
  - BFS: Breath Fisrt Search
  - Graph Reducer: Merge all strongly connected components in a graph to a single node
  - Dijkstra: Shortest path in a weighted graph
  - Bellman-Ford: Shortest path in negative weighted graphs
  - Kruskal: Minimum or Maximum expanding tree in a graph
  - HITS: Hyperlink-Induced Topic Search
  - Topological Sort
  - Shortest Path in DAG

## How to install it

```smalltalk
Metacello new
    repository: 'github://pharo-ai/graph-algorithms/src';
    baseline: 'AIGraphAlgorithms';
    load
```

## How to depend on it

If you want to add this repo to your Metacello Baselines or Configurations, copy and paste the following expression:
```smalltalk
spec
    baseline: 'AIGraphAlgorithms' 
    with: [ spec repository: 'github://pharo-ai/graph-algorithms/src' ]
```

## How to use it

The below code was extracted from the Pharo Graphs booklet which is a booklet in which this library along with all the algorithms are explained. You can check it out in [Booklet-PharoGraphs](https://github.com/SquareBracketAssociates/Booklet-PharoGraphs)

All the graph algorithms of this library share a common API also. The class AIGraphAlgorithm provides the common API to add nodes, edges, searching the nodes, etc.

Some of the common methods are:
- `algorithm nodes:`
- `algorithm nodes`
- `algorithm edges`
- `algorithm edges:from:to:`
- `algorithm edges:from:to:weight:`
- `algorithm findNode:`
- `algorithm run`

For example, for using the topological sort algorithm for the following graph, we can run this code snippet

<img src="https://user-images.githubusercontent.com/33934979/144241102-639f4ff8-6bc2-41ad-9082-ea6e8dada306.png" width="500" />

```st
"First define the nodes and the edges"
nodes := #( $A $B $C $D $E $F $G ).
edges := #( #( $A $B ) #( $A $C ) #( $B $E ) #( $C $E ) #( $C $D )
    #( $D $E ) #( $D $F ) #( $E $G ) #( $F $G ) ).

"Instantiate the graph algorithm"
topSortingAlgo := AITopologicalSorting new.

"Set the nodes and edges"    
topSortingAlgo nodes: nodes.
topSortingAlgo
    edges: edges
    from: [ :each | each first ]
    to: [ :each | each second ].

"Run to obtain the result"
topologicalSortedElements := topSortingAlgo run.
```

Or if we want to find the shortest path in a weighted graph:

<img src="https://user-images.githubusercontent.com/33934979/144241616-8cc92bf7-959b-4f47-817d-6d1cd2f3cf70.png" width="500" />

```st
nodes := $A to: $F.
edges := #( #( $A $B 5 ) #( $A $C 1 ) #( $B $C 2 ) #( $B $E 20 )
    #( $B $D 3 ) #( $C $B 3 ) #( $C $E 12 ) #( $D $C 3 )
    #( $D $E 2 ) #( $D $F 6 ) #( $E $F 1 ) ).

dijkstra := AIDijkstra new.
dijkstra nodes: nodes.
dijkstra
    edges: edges
    from: [ :each | each first ]
    to: [ :each | each second ]
    weight: [ :each | each third ].

shortestPathAToB := dijkstra runFrom: $A to: $B.
pathDistanceAToB := (dijkstra findNode: $B) pathDistance.

dijkstra end: $F.
shortestPathAToF := dijkstra reconstructPath.
pathDistanceAToF := (dijkstra findNode: $F) pathDistance.

dijkstra reset.
shortestPathBToE := dijkstra runFrom: $B to: $E.
```
