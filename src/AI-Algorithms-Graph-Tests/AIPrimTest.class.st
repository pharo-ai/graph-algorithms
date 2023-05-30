Class {
	#name : #AIPrimTest,
	#superclass : #TestCase,
	#instVars : [
		'prim'
	],
	#category : #'AI-Algorithms-Graph-Tests'
}

{ #category : #running }
AIPrimTest >> setUp [

	super setUp.
	prim := AIPrim new.
]

{ #category : #tests }
AIPrimTest >> testMinSpanningTreeComplex2 [

	| tree graph algo |
	graph := AICyclicWeightedComplexGraph new.
	algo :=graph complexWeightedGraph4.
	prim nodes: algo nodes.
	prim  
	   edges: algo edges
		from: #first
		to: #second
		weight: #third.
	tree := prim run collect: [ :e | e asTuple ].
	self assert: tree size equals: 11.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 112
]

{ #category : #tests }
AIPrimTest >> testMinimumSpanningTreeComplex [

	| tree expectedEdges graph algo |
	graph := AICyclicWeightedComplexGraph new.
	algo :=graph complexWeightedGraph3.
	prim nodes: algo nodes.
	prim  
	   edges: algo edges
		from: #first
		to: #second
		weight: #third.
	tree := prim run collect: [ :e | e asTuple ].

	expectedEdges := #( #( $a $d 1 ) #( $d $e 1 ) #( $d $b 2 )
	                    #( $e $c 5 ) ).
	self assertCollection: tree hasSameElements: expectedEdges.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 9
]

{ #category : #tests }
AIPrimTest >> testMinimumSpanningTreeSimple [

	| tree expectedEdges graph algo |
	graph := AICyclicWeightedSimpleGraph new.
	algo :=graph simpleWeightedGraph2.
	prim nodes: algo nodes.
	prim  
	   edges: algo edges
		from: #first
		to: #second
		weight: #third.
	tree := prim run collect: [ :e | e asTuple ].

	expectedEdges := #( #( 1 2 3 ) #( 2 3 1 ) #( 3 4 2 ) #( 4 5 3 ) ).
	self assertCollection: tree hasSameElements: expectedEdges.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 9
]
