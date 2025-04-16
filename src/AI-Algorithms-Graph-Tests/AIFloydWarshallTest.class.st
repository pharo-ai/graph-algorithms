Class {
	#name : 'AIFloydWarshallTest',
	#superclass : 'TestCase',
	#instVars : [
		'floydWarshall'
	],
	#category : 'AI-Algorithms-Graph-Tests-Shortest path',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Shortest path'
}

{ #category : 'running' }
AIFloydWarshallTest >> setUp [

	super setUp.
    floydWarshall := AIFloydWarshall new
]

{ #category : 'tests' }
AIFloydWarshallTest >> testAllPairsDistances [

	| graphType graph result |
	graphType := AICyclicWeightedSimpleFixture new.
	graph := graphType simpleWeightedGraph2.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.
	result := floydWarshall getAllPairsDistances.
	
	self assert: (result at: { 1. 2 }) equals: 3.
	self assert: (result at: { 1. 5 }) equals: 8.
	self assert: (result at: { 3. 5 }) equals: 5
]

{ #category : 'tests' }
AIFloydWarshallTest >> testAllPairsPaths [

	| graphType graph result |
	graphType := AICyclicWeightedSimpleFixture new.
	graph := graphType simpleWeightedGraph2.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.
	result := floydWarshall getAllPairsPaths.
	
	self assert: (result at: { 1. 2 }) equals: #( 1 2 ).
	self assert: (result at: { 1. 5 }) equals: #( 1 5 ).
	self assert: (result at: { 3. 5 }) equals: #( 3 4 5 )
]

{ #category : 'tests' }
AIFloydWarshallTest >> testComplexWeightedGraph2 [

	| graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph := graphType complexWeightedGraph2.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.
	
	self assert: (floydWarshall distanceFrom: 0 to: 5) equals: 10.

	self assert: (floydWarshall distanceFrom: 1 to: 5) equals: 6.

	self assert: (floydWarshall distanceFrom: 3 to: 5) equals: 3.

	self
		assert: (floydWarshall pathFrom: 0 to: 5)
		equals: #( 0 2 1 3 4 5 ).
	self assert: (floydWarshall pathFrom: 1 to: 5) equals: #( 1 3 4 5 ).
	self assert: (floydWarshall pathFrom: 3 to: 5) equals: #( 3 4 5 ).

	self assert: floydWarshall hasNegativeCycle equals: false
]

{ #category : 'tests' }
AIFloydWarshallTest >> testHasPathFromTo [

	| graphType graph |
    graphType := AICyclicWeightedSimpleFixture new.
    graph := graphType negativeUnconnectedWeightedGraph.
    
    floydWarshall nodes: graph nodes.
    floydWarshall 
        edges: graph edges
        from: #first
        to: #second
        weight: #third.
    
    floydWarshall run.
    
    self assert: (floydWarshall hasPathFrom: 0 to: 1).
    self deny: (floydWarshall hasPathFrom: 0 to: 8).
    self deny: (floydWarshall hasPathFrom: 0 to: 9).
]

{ #category : 'tests' }
AIFloydWarshallTest >> testNegativeUnconnectedWeightedGraph [

	| graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph := graphType negativeUnconnectedWeightedGraph.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.

	self assert: (floydWarshall distanceFrom: 0 to: 1) equals: 5.
	self
		assert: (floydWarshall distanceFrom: 0 to: 2)
		equals: Float negativeInfinity.
	self assert: (floydWarshall distanceFrom: 0 to: 7) equals: -10.
	self
		assert: (floydWarshall distanceFrom: 0 to: 8)
		equals: Float infinity.

	self assert: (floydWarshall pathFrom: 0 to: 1) equals: #( 0 1 ).
	self assert: (floydWarshall pathFrom: 0 to: 7) equals: #( 0 1 5 6 7 ).
	self assert: (floydWarshall pathFrom: 0 to: 8) equals: #(  ).

	self assert: floydWarshall hasNegativeCycle equals: true.

	self
		assert: (floydWarshall distanceFrom: 0 to: 9)
		equals: Float negativeInfinity.
	self
		assert: (floydWarshall pathFrom: 0 to: 9)
		equals: #( 'Path affected by negative cycle' ).

	self
		assert: (floydWarshall distanceFrom: 2 to: 3)
		equals: Float negativeInfinity.
	self
		assert: (floydWarshall pathFrom: 2 to: 3)
		equals: #( 'Path affected by negative cycle' )
]

{ #category : 'tests' }
AIFloydWarshallTest >> testNegativeWeightedGraph [

	| graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph := graphType negativeWeightedGraph.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.

	self assert: (floydWarshall distanceFrom: 0 to: 8) equals: -20.
	self
		assert: (floydWarshall distanceFrom: 0 to: 9)
		equals: Float negativeInfinity.

	self
		assert: (floydWarshall pathFrom: 0 to: 8)
		equals: #( 0 1 5 6 7 8 ).
	self
		assert: (floydWarshall pathFrom: 0 to: 9)
		equals: #( 'Path affected by negative cycle' ).

	self assert: floydWarshall hasNegativeCycle equals: true
]

{ #category : 'tests' }
AIFloydWarshallTest >> testSimpleWeightedGraph [

	| graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph := graphType simpleWeightedGraph.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.

	self assert: (floydWarshall distanceFrom: 1 to: 5) equals: 3.
	self assert: (floydWarshall distanceFrom: 2 to: 5) equals: 4.
	self assert: (floydWarshall distanceFrom: 3 to: 5) equals: 6.

	self assert: (floydWarshall pathFrom: 1 to: 5) equals: #( 1 5 ).
	self assert: (floydWarshall pathFrom: 2 to: 5) equals: #( 2 4 5 ).
	self assert: (floydWarshall pathFrom: 3 to: 5) equals: #( 3 4 5 ).

	self assert: floydWarshall hasNegativeCycle equals: false
]

{ #category : 'tests' }
AIFloydWarshallTest >> testWeightedDAG [

	| graphType graph |
	graphType := AIWeightedDAGFixture new.
	graph := graphType weightedDAG.

	floydWarshall nodes: graph nodes.
	floydWarshall
		edges: graph edges
		from: #first
		to: #second
		weight: #third.

	floydWarshall run.

	self assert: (floydWarshall distanceFrom: $A to: $F) equals: 19.
	self assert: (floydWarshall distanceFrom: $B to: $F) equals: 18.
	self assert: (floydWarshall distanceFrom: $G to: $F) equals: 17.

	self
		assert: (floydWarshall pathFrom: $A to: $F)
		equals: #( $A $B $E $F ).
	self
		assert: (floydWarshall pathFrom: $G to: $F)
		equals: #( $G $D $E $F ).

	self assert: floydWarshall hasNegativeCycle equals: false
]
