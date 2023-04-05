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
AIPrimTest >> testMinimumSpanningTreeComplex [
| tree expectedEdges |
	AIGraphFixture complexWeightedGraph3: prim.
	tree := prim run collect: [ :e | e asTuple ].

	expectedEdges := #( #( $a $d 1 ) #( $d $e 1 ) #( $d $b 2 ) #( $e $c 5 ) ).
	self assertCollection: tree hasSameElements: expectedEdges.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 9
]
