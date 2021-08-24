Class {
	#name : #AIKruskalTest,
	#superclass : #TestCase,
	#instVars : [
		'nodes',
		'kruskal'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIKruskalTest >> setUp [

	super setUp.
	kruskal := AIKruskal new.
	nodes := OrderedCollection new.
	nodes add: AIDisjointSetNode new.
	nodes add: AIDisjointSetNode new.
	nodes add: AIDisjointSetNode new.
	nodes add: AIDisjointSetNode new
]

{ #category : #tests }
AIKruskalTest >> testMaxSpanningTreeComplex [

	| tree expectedEdges |
	AIGraphFixture complexWeightedGraph: kruskal.
	kruskal maxSpanningTree.
	tree := kruskal run collect: [ :e | e asTuple ].

	expectedEdges := #( #( $a $b 30 ) #( $b $s 1 ) #( $b $c 30 )
	                    #( $d $e 30 ) #( $d $f 20 ) #( $d $j 10 )
	                    #( $e $a 15 ) #( $f $m 8 ) #( $g $h 20 )
	                    #( $g $r 3 ) #( $i $a 14 ) #( $i $k 4 )
	                    #( $j $q 5 ) #( $k $l 10 ) #( $k $g 5 )
	                    #( $m $n 7 ) #( $m $o 6 ) #( $p $b 5 ) ).
	self assertCollection: tree hasSameElements: expectedEdges.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 223
]

{ #category : #tests }
AIKruskalTest >> testMaxSpanningTreeSimple [

	| tree expectedEdges |
	AIGraphFixture simpleWeightedGraph: kruskal.
	kruskal maxSpanningTree.
	tree := kruskal run collect: [ :e | e asTuple ].

	expectedEdges := #( #( 1 2 5 ) #( 3 4 5 ) #( 1 3 4 ) #( 1 5 3 ) ).
	self assertCollection: tree hasSameElements: expectedEdges.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 17
]

{ #category : #tests }
AIKruskalTest >> testMinSpanningTreeComplex [

	| tree |
	AIGraphFixture complexWeightedGraph: kruskal.
	tree := kruskal run collect: [ :e | e asTuple ].
	self assert: tree size equals: kruskal nodes size - 1.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 164
]

{ #category : #tests }
AIKruskalTest >> testMinSpanningTreeComplexDisconnected [

	| tree |
	AIGraphFixture withoutCyclesComplexWeightedGraph: kruskal.
	tree := kruskal run collect: [ :e | e asTuple ].
	"The result is 2 trees. One with a total weight of 20 and the other with a total weight of 75"
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 95
]

{ #category : #tests }
AIKruskalTest >> testMinSpanningTreeSimple [

	| tree expectedEdges |
	AIGraphFixture simpleWeightedGraph: kruskal.
	tree := kruskal run collect: [ :e | e asTuple ].

	expectedEdges := #( #( 4 5 1 ) #( 5 1 2 ) #( 2 3 2 ) #( 2 4 3 ) ).
	self assertCollection: tree hasSameElements: expectedEdges.
	self
		assert: (tree inject: 0 into: [ :sum :edge | sum + edge third ])
		equals: 8
]
