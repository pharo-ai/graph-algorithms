# Graph Algorithms

[![Build status](https://github.com/pharo-ai/linear-models/workflows/CI/badge.svg)](https://github.com/pharo-ai/graph-algorithms/actions/workflows/CI.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/graph-algorithms/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/graph-algorithms?branch=master)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)

For more information please refer to the pharo-ai wiki: https://github.com/pharo-ai/wiki/blob/master/wiki/Graphs/Graph-Algorithms.md

Or also to our graphs booklet [Booklet-PharoGraphs](https://github.com/SquareBracketAssociates/Booklet-PharoGraphs)

### Table of Contents

- [Description](#description)
- [How to install it](#how-to-install-it)
- [How to depend on it](#how-to-depend-on-it)
- [Implemented graph algorithms](#implemented-graph-algorithms)  
- [How to use the graph algorithms](#how-to-use-the-graph-algorithms)  
- [Graph generation algorithms](#graph-generation-algorithms)

## Description

This library contains several graphs algorithms. The nodes in the graph can be any kind of object: a Character, a String, an Integer or a complex object.

## How to install it

```smalltalk
Metacello new
    repository: 'github://pharo-ai/graph-algorithms';
    baseline: 'AIGraphAlgorithms';
    load
```

## How to depend on it

If you want to add this repo to your Metacello Baselines or Configurations, copy and paste the following expression:
```smalltalk
spec
    baseline: 'AIGraphAlgorithms' 
    with: [ spec repository: 'github://pharo-ai/graph-algorithms' ]
```

## Implemented graph algorithms

  - Tarjan’s Algorithm: Strongly Connected Components
  - BFS: Breath First Search
  - Graph Reducer: Merge all strongly connected components in a graph to a single node
  - Dijkstra: Shortest path in a weighted graph
  - Bellman-Ford: Shortest path in negative weighted graphs
  - Kruskal: Minimum or Maximum expanding tree in a graph
  - HITS: Hyperlink-Induced Topic Search
  - Topological Sort
  - Shortest Path in DAG
  - Longest path in DAG
  - Longest path in any type of graph
  - Dinic: strongly polynomial algorithm for computing the maximum flow in a flow network
  - A* algorithm: searching algorithm for having the shortest path

## How to use the graph algorithms

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

### Example 1

For using the topological sort algorithm, we can run this code snippet

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

### Example 2

Or if we want to find the shortest path in a weighted graph:

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

## Graph generation algorithms

This library also contains algorithms for generating regular and random graphs. This algorithms are not loaded by default. To load them, you can either load them manually using Iceberg directly from the Pharo image or load the `GraphGenerators` baseline group.

The algorithms implemented are:

- Albert Barabasi Graph Generator
- Atlas Graph Graph Generator
- Erdos Renyi GNM Graph Generator
- Erdos Renyi GNP Graph Generator
- Grid 2D Graph Generator
- Grid 3D Graph Generator
- Hexagonal Lattice Graph Generator
- Kleinberg Graph Generator
- Triangular Lattice Graph Generator
- Waltz Strogatz Graph Generator
