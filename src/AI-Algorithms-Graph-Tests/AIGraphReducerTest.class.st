Class {
	#name : #AIGraphReducerTest,
	#superclass : #TestCase,
	#instVars : [
		'graphReducer'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #helpers }
AIGraphReducerTest >> assertNodes: aNodeList doesNotInclude: anotherNodeList [

	aNodeList collect: [ :each | each model ] thenDo: [ :model | 
		self
			deny: ((anotherNodeList collect: [ :each | each model ]) includes: model)
			description: model asString , ' should not be referenced!' ]
]

{ #category : #helpers }
AIGraphReducerTest >> mergedNodesIn: aNodeList [

	^ (aNodeList select: [ :node | node mergedNodes notNil ]) 
		  flatCollect: #mergedNodes
]

{ #category : #running }
AIGraphReducerTest >> setUp [

	super setUp.
	graphReducer := AIGraphReducer new
]

{ #category : #tests }
AIGraphReducerTest >> testComplexCycle [

	| mergedNodes |
	AIGraphFixture complexCycleGraph: graphReducer.
	graphReducer run.
	self assert: graphReducer nodes size equals: 5.
	self assert:
		(graphReducer nodes anySatisfy: [ :each | each model = $a ]).
	self assert:
		(graphReducer nodes anySatisfy: [ :each | each model = $b ]).
	self assert:
		(graphReducer nodes anySatisfy: [ :each | each model = $e ]).
	mergedNodes := graphReducer nodes select: [ :each | 
		               each mergedNodes isNotNil ].
	self
		assertCollection: (mergedNodes second mergedNodes collect: #model)
		hasSameElements: #( $g $h ).
	self
		assertCollection: (mergedNodes first mergedNodes collect: #model)
		hasSameElements: #( $d $c $f )
]

{ #category : #tests }
AIGraphReducerTest >> testComplexCycle2 [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	self assert: graphReducer nodes size equals: 6.
	self assert: (graphReducer nodes at: 6) mergedNodes size equals: 4
]

{ #category : #tests }
AIGraphReducerTest >> testGraphReducingWhenNoCycle [

	| initialGraph |
	AIGraphFixture simpleGraph: graphReducer.
	initialGraph := graphReducer graph copy.
	graphReducer run.
	self assert: initialGraph equals: graphReducer graph
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInNextNodes [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #nextNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInNextNodesForSCG [

	self skip.
	AIGraphFixture stronglyConnectedGraph: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #nextNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInPreviousNodes [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #previousNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInPreviousNodesForSCG [

	AIGraphFixture stronglyConnectedGraph: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #previousNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testNextNodesFor [

	| nodes |
	AIGraphFixture complexCycleGraph2: graphReducer.
	nodes := { 
		         (graphReducer findNode: $f).
		         (graphReducer findNode: $g) }.
	self
		assert: ((graphReducer nextNodesFor: nodes)
				 collect: #model
				 as: SortedCollection) asArray
		equals: #( $a $b $d $e $i )
]

{ #category : #tests }
AIGraphReducerTest >> testNoCycle [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	graphReducer nodes do: [ :node | 
		self
			deny: ((node adjacentNodes includes: node) or: [ 
					 node previousNodes includes: node ])
			description: node asString , ' node is in cycle!' ]
]

{ #category : #tests }
AIGraphReducerTest >> testPreviousNodesFor [

	| nodes |
	AIGraphFixture complexCycleGraph2: graphReducer.
	nodes := { 
		         (graphReducer findNode: $f).
		         (graphReducer findNode: $g) }.
	self
		assertCollection:
		((graphReducer previousNodesFor: nodes) collect: #model)
		hasSameElements: #( $a $b $c )
]

{ #category : #tests }
AIGraphReducerTest >> testStronglyConnectedGraph [

	AIGraphFixture stronglyConnectedGraph: graphReducer.
	graphReducer run.
	self assert: graphReducer nodes size equals: 4.
	self assert: (graphReducer nodes at: 1) model equals: $i.
	self
		assertCollection: (graphReducer nodes at: 2) model
		hasSameElements: #( $d $e ).
	self
		assertCollection: (graphReducer nodes at: 3) model
		hasSameElements: #( $a $b $c ).
	self
		assertCollection: (graphReducer nodes at: 4) model
		hasSameElements: #( $f $g $h )
]
