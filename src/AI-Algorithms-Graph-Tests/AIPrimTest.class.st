Class {
	#name : 'AIPrimTest',
	#superclass : 'TestCase',
	#instVars : [
		'prim'
	],
	#category : 'AI-Algorithms-Graph-Tests-Minimum Spanning Tree Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Minimum Spanning Tree Tests'
}

{ #category : 'running' }
AIPrimTest >> setUp [

	super setUp.
	prim := AIPrim new.
]

{ #category : 'tests' }
AIPrimTest >> testMinSpanningTreeComplex2 [

	| resultEdges graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph4.
	prim nodes: graph nodes.
	prim  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	prim run.
	resultEdges := prim minimumSpanningTreeEdges collect: [ :e | e asTuple ].
	self assert: resultEdges size equals: 11.
	self
		assert: (resultEdges inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 112
]

{ #category : 'tests' }
AIPrimTest >> testMinimumSpanningTreeComplex [

	| resultEdges expectedEdges graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph3.
	prim nodes: graph nodes.
	prim  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	prim run.
	resultEdges := prim minimumSpanningTreeEdges collect: [ :e | e asTuple ].

	expectedEdges := #( #( $a $d 1 ) #( $d $e 1 ) #( $d $b 2 )
	                    #( $e $c 5 ) ).
	self assertCollection: resultEdges hasSameElements: expectedEdges.
	self
		assert: (resultEdges inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 9
]

{ #category : 'tests' }
AIPrimTest >> testMinimumSpanningTreeSimple [

	| resultEdges expectedEdges graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType simpleWeightedGraph2.
	prim nodes: graph nodes.
	prim  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	prim run.
	resultEdges := prim minimumSpanningTreeEdges collect: [ :e | e asTuple ].

	expectedEdges := #( #( 1 2 3 ) #( 2 3 1 ) #( 3 4 2 ) #( 4 5 3 ) ).
	self assertCollection: resultEdges hasSameElements: expectedEdges.
	self
		assert: (resultEdges inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 9
]
