Class {
	#name : 'AIAstarTest',
	#superclass : 'TestCase',
	#instVars : [
		'astar'
	],
	#category : 'AI-Algorithms-Graph-Tests-Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
AIAstarTest >> setUp [
	super setUp.
	astar := AIAstar new
]

{ #category : 'tests' }
AIAstarTest >> testAseBasicCircuit [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType aseCircuitWeightedGraph.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	astar runFrom: $a.
	self assert: 1 equals: (astar findNode: $b) pathDistance.
	self assert: 3 equals: (astar findNode: $e) pathDistance.
	self assert: 5 equals: (astar findNode: $h) pathDistance.

	astar reset.
	astar runFrom: $c.
	self assert: 2 equals: (astar findNode: $b) pathDistance.

	astar reset.
	astar runFrom: $h.
	self assert: Float infinity equals: (astar findNode: $a) pathDistance
]

{ #category : 'tests' }
AIAstarTest >> testAseBasicCircuitBacktrack [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType aseCircuitWeightedGraph.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	self assert: (#( $a $b ) hasEqualElements: (astar
				  runFrom: $a to: $b;
				  reconstructPath)).
	astar reset.
	self assert: (#( $a $b $d $e ) hasEqualElements: (astar
				  runFrom: $a to: $e;
				  reconstructPath)).
	astar reset.
	self assert: (#( $c $d $b ) hasEqualElements: (astar
				  runFrom: $c to: $b;
				  reconstructPath)).
	astar reset.
	self assert: (#( $a $b $c $f $g $h ) hasEqualElements: (astar
				  runFrom: $a to: $h;
				  reconstructPath)).
	astar reset.
	self assert: (#(  ) hasEqualElements: (astar
				  runFrom: $h to: $a;
				  reconstructPath))
]

{ #category : 'tests' }
AIAstarTest >> testComplexWeightedGraph2 [


	|graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph2.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	astar runFrom: 0.
	self assert: (astar findNode: 1) pathDistance equals: 4.
	self assert: (astar findNode: 2) pathDistance equals: 1.
	self assert: (astar findNode: 3) pathDistance equals: 7.
	self assert: (astar findNode: 4) pathDistance equals: 9.
	self assert: (astar findNode: 5) pathDistance equals: 10
]

{ #category : 'tests' }
AIAstarTest >> testComplexWeightedGraph2BackTracking [

	| shortestPath graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph2.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	shortestPath := astar
		                runFrom: 0 to: 1;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 ).
	astar reset.

	shortestPath := astar
		                runFrom: 0 to: 2;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 ).
	astar reset.

	shortestPath := astar
		                runFrom: 0 to: 3;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 3 ).
	astar reset.

	shortestPath := astar
		                runFrom: 0 to: 4;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 3 4 ).
	astar reset.

	shortestPath := astar
		                runFrom: 0 to: 5;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 0 2 1 3 4 5 ).
	astar reset
]

{ #category : 'tests' }
AIAstarTest >> testComplexWeightedGraph3 [

	|graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph3.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	astar runFrom: $a.
	self assert: (astar findNode: $b) pathDistance equals: 3.
	self assert: (astar findNode: $c) pathDistance equals: 7.
	self assert: (astar findNode: $d) pathDistance equals: 1.
	self assert: (astar findNode: $e) pathDistance equals: 2
]

{ #category : 'tests' }
AIAstarTest >> testComplexWeightedGraph3Backtracking [

	| shortestPath graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph3.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	shortestPath := astar
		                runFrom: $a to: $b;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d $b ).
	astar reset.

	shortestPath := astar
		                runFrom: $a to: $c;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d $e $c ).
	astar reset.

	shortestPath := astar
		                runFrom: $a to: $d;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d ).
	astar reset.

	shortestPath := astar
		                runFrom: $a to: $e;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( $a $d $e ).
	astar reset
]

{ #category : 'tests' }
AIAstarTest >> testSimpleWeightedGraph [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType simpleWeightedGraph.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	astar runFrom: 1.
	self assert: (astar findNode: 2) pathDistance equals: 5.
	self assert: (astar findNode: 3) pathDistance equals: 4.
	self assert: (astar findNode: 4) pathDistance equals: 8.
	self assert: (astar findNode: 5) pathDistance equals: 3
]

{ #category : 'tests' }
AIAstarTest >> testSimpleWeightedGraphBacktracking [

	| shortestPath graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType simpleWeightedGraph.
	astar nodes: graph nodes.
	astar 
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	shortestPath := astar
		                runFrom: 1 to: 2;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 2 ).
	astar reset.

	shortestPath := astar
		                runFrom: 1 to: 3;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 3 ).
	astar reset.

	shortestPath := astar
		                runFrom: 1 to: 4;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 2 4 ).
	astar reset.

	shortestPath := astar
		                runFrom: 1 to: 5;
		                reconstructPath.
	self assertCollection: shortestPath hasSameElements: #( 1 5 ).
	astar reset
]
