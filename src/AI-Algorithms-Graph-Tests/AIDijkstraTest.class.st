Class {
	#name : #AIDijkstraTest,
	#superclass : #TestCase,
	#instVars : [
		'dijkstra'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIDijkstraTest >> setUp [
	super setUp.
	dijkstra := AIDijkstra new
]

{ #category : #tests }
AIDijkstraTest >> testAseBasicCircuit [

	AIGraphFixture aseCircuitWeightedGraph: dijkstra.
	dijkstra runFrom: $a.
	self assert: 1 equals: (dijkstra findNode: $b) pathDistance.
	self assert: 3 equals: (dijkstra findNode: $e) pathDistance.
	self assert: 5 equals: (dijkstra findNode: $h) pathDistance.

	dijkstra reset.
	dijkstra runFrom: $c.
	self assert: 2 equals: (dijkstra findNode: $b) pathDistance.

	dijkstra reset.
	dijkstra runFrom: $h.
	self assert: Float infinity equals: (dijkstra findNode: $a) pathDistance
]

{ #category : #tests }
AIDijkstraTest >> testAseBasicCircuitBacktrack [

	AIGraphFixture aseCircuitWeightedGraph: dijkstra.

	self assert: (#( $a $b ) hasEqualElements: (dijkstra
				  runFrom: $a to: $b;
				  reconstructPath)).
	dijkstra reset.
	self assert: (#( $a $b $d $e ) hasEqualElements: (dijkstra
				  runFrom: $a to: $e;
				  reconstructPath)).
	dijkstra reset.
	self assert: (#( $c $d $b ) hasEqualElements: (dijkstra
				  runFrom: $c to: $b;
				  reconstructPath)).
	dijkstra reset.
	self assert: (#( $a $b $c $f $g $h ) hasEqualElements: (dijkstra
				  runFrom: $a to: $h;
				  reconstructPath)).
	dijkstra reset.
	self assert: (#(  ) hasEqualElements: (dijkstra
				  runFrom: $h to: $a;
				  reconstructPath))
]

{ #category : #tests }
AIDijkstraTest >> testComplexWeightedGraph2 [


	AIGraphFixture complexWeightedGraph2: dijkstra.

	dijkstra runFrom: 0.
	self assert: (dijkstra findNode: 1) pathDistance equals: 4.
	self assert: (dijkstra findNode: 2) pathDistance equals: 1.
	self assert: (dijkstra findNode: 3) pathDistance equals: 7.
	self assert: (dijkstra findNode: 4) pathDistance equals: 9.
	self assert: (dijkstra findNode: 5) pathDistance equals: 10
]

{ #category : #tests }
AIDijkstraTest >> testComplexWeightedGraph2BackTracking [

	| shortestPath |
	AIGraphFixture complexWeightedGraph2: dijkstra.
	shortestPath := dijkstra
		                runFrom: 0 to: 1;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 0 to: 2;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 0 to: 3;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 3 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 0 to: 4;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 3 4 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 0 to: 5;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 3 4 5 ).
	dijkstra reset
]

{ #category : #tests }
AIDijkstraTest >> testComplexWeightedGraph3 [

	AIGraphFixture complexWeightedGraph3: dijkstra.

	dijkstra runFrom: $a.
	self assert: (dijkstra findNode: $b) pathDistance equals: 3.
	self assert: (dijkstra findNode: $c) pathDistance equals: 7.
	self assert: (dijkstra findNode: $d) pathDistance equals: 1.
	self assert: (dijkstra findNode: $e) pathDistance equals: 2
]

{ #category : #tests }
AIDijkstraTest >> testComplexWeightedGraph3Backtracking [

	| shortestPath |
	AIGraphFixture complexWeightedGraph3: dijkstra.
	shortestPath := dijkstra
		                runFrom: $a to: $b;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d $b ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: $a to: $c;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d $e $c ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: $a to: $d;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: $a to: $e;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d $e ).
	dijkstra reset
]

{ #category : #tests }
AIDijkstraTest >> testSimpleWeightedGraph [

	AIGraphFixture simpleWeightedGraph: dijkstra.

	dijkstra runFrom: 1.
	self assert: (dijkstra findNode: 2) pathDistance equals: 5.
	self assert: (dijkstra findNode: 3) pathDistance equals: 4.
	self assert: (dijkstra findNode: 4) pathDistance equals: 8.
	self assert: (dijkstra findNode: 5) pathDistance equals: 3
]

{ #category : #tests }
AIDijkstraTest >> testSimpleWeightedGraphBacktracking [

	| shortestPath |
	AIGraphFixture simpleWeightedGraph: dijkstra.
	shortestPath := dijkstra
		                runFrom: 1 to: 2;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 2 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 1 to: 3;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 3 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 1 to: 4;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 2 4 ).
	dijkstra reset.

	shortestPath := dijkstra
		                runFrom: 1 to: 5;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 5 ).
	dijkstra reset
]
