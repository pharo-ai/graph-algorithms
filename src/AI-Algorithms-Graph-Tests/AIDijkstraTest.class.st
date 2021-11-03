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

	self assert: 1 equals: (dijkstra runFrom: $a to: $b).
	dijkstra reset.
	self assert: 3 equals: (dijkstra runFrom: $a to: $e).
	dijkstra reset.
	self assert: 2 equals: (dijkstra runFrom: $c to: $b).
	dijkstra reset.
	self assert: 5 equals: (dijkstra runFrom: $a to: $h).
	dijkstra reset.
	self assert: Float infinity equals: (dijkstra runFrom: $h to: $a)
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

	| pathWeight |

	AIGraphFixture complexWeightedGraph2: dijkstra.
	pathWeight := dijkstra runFrom: 0 to: 1.
	self assert: pathWeight equals: 4.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 0 to: 2.
	self assert: pathWeight equals: 1.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 0 to: 3.
	self assert: pathWeight equals: 7.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 0 to: 4.
	self assert: pathWeight equals: 9.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 0 to: 5.
	self assert: pathWeight equals: 10.
	dijkstra reset
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

	| pathWeight |
	AIGraphFixture complexWeightedGraph3: dijkstra.
	pathWeight := dijkstra runFrom: $a to: $b.
	self assert: pathWeight equals: 3.
	dijkstra reset.

	pathWeight := dijkstra runFrom: $a to: $c.
	self assert: pathWeight equals: 7.
	dijkstra reset.

	pathWeight := dijkstra runFrom: $a to: $d.
	self assert: pathWeight equals: 1.
	dijkstra reset.

	pathWeight := dijkstra runFrom: $a to: $e.
	self assert: pathWeight equals: 2.
	dijkstra reset
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

	| pathWeight |
	AIGraphFixture simpleWeightedGraph: dijkstra.
	pathWeight := dijkstra runFrom: 1 to: 2.
	self assert: pathWeight equals: 5.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 1 to: 3.
	self assert: pathWeight equals: 4.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 1 to: 4.
	self assert: pathWeight equals: 8.
	dijkstra reset.

	pathWeight := dijkstra runFrom: 1 to: 5.
	self assert: pathWeight equals: 3.
	dijkstra reset
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
