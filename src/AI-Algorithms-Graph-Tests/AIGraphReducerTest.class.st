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
AIGraphReducerTest >> testAdjacenciesFor [

	| nodes |
	AIGraphFixture complexCycleGraph2: graphReducer.
	nodes := {
		         (graphReducer findNode: $f).
		         (graphReducer findNode: $g) }.
	self
		assert: ((graphReducer adjacenciesFor: nodes)
				 collect: #model
				 as: SortedCollection) asArray
		equals: #( $a $b $d $e $i )
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
	mergedNodes := graphReducer nodes
		               select: [ :each | each mergedNodes isNotNil ]
		               thenCollect: #model.
	self assert: (mergedNodes anySatisfy: [ :collapsedNode |
			 collapsedNode includesAll: #( $g $h ) ]).
	self assert: (mergedNodes anySatisfy: [ :collapsedNode |
			 collapsedNode includesAll: #( $c $d $f ) ])
]

{ #category : #tests }
AIGraphReducerTest >> testComplexCycle2 [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	self assert: graphReducer nodes size equals: 6.
	self assert: (graphReducer nodes at: 6) mergedNodes size equals: 4
]

{ #category : #tests }
AIGraphReducerTest >> testComplexCycleReferences [

	| mergedNodes reducedNodeA reducedNodeB reducedNodeE reducedNodeCDF reducedNodeGH |
	AIGraphFixture complexCycleGraph: graphReducer.
	graphReducer run.
	reducedNodeA := (graphReducer nodes select: [ :each |
		                 each model = $a ]) first.
	reducedNodeB := (graphReducer nodes select: [ :each |
		                 each model = $b ]) first.
	reducedNodeE := (graphReducer nodes select: [ :each |
		                 each model = $e ]) first.
	mergedNodes := graphReducer nodes select: [ :each |
		               each model isCollection ].
	reducedNodeCDF := (mergedNodes select: [ :each |
		                   each model includesAll: #( $d $f $c ) ]) first.
	reducedNodeGH := (mergedNodes select: [ :each |
		                  each model includesAll: #( $g $h ) ]) first.

	self
		assertCollection: reducedNodeA adjacentNodes
		hasSameElements: { reducedNodeB. reducedNodeGH. reducedNodeCDF }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeA adjacentNodes size equals: 3.

	self
		assertCollection: reducedNodeB adjacentNodes
		hasSameElements: { reducedNodeE }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeB adjacentNodes size equals: 1.

	self assert: reducedNodeE adjacentNodes isEmpty.

	self
		assertCollection: reducedNodeGH adjacentNodes
		hasSameElements: { reducedNodeCDF }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeGH adjacentNodes size equals: 1.

	self
		assertCollection: reducedNodeCDF adjacentNodes
		hasSameElements: { reducedNodeB }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeCDF adjacentNodes size equals: 1
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
AIGraphReducerTest >> testGraphReducingWhenNoCycleReferences [

	| reducedNodeA reducedNodeB reducedNodeC reducedNodeD |
	AIGraphFixture simpleGraph: graphReducer.
	graphReducer run.
	reducedNodeA := (graphReducer nodes select: [ :each |
		                 each model = $a ]) first.
	reducedNodeB := (graphReducer nodes select: [ :each |
		                 each model = $b ]) first.
	reducedNodeC := (graphReducer nodes select: [ :each |
		                 each model = $c ]) first.
	reducedNodeD := (graphReducer nodes select: [ :each |
		                 each model = $d ]) first.
	self
		assertCollection: reducedNodeA adjacentNodes
		hasSameElements: { reducedNodeB }.
	self
		assertCollection: reducedNodeB adjacentNodes
		hasSameElements: { reducedNodeC }.
	self
		assertCollection: reducedNodeD adjacentNodes
		hasSameElements: { reducedNodeC }.
	self assert: reducedNodeC adjacentNodes isEmpty
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInNextNodes [

	AIGraphFixture complexCycleGraph: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #adjacentNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInNextNodesC2 [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #adjacentNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testMergedNodesNotReferencedInNextNodesForSCG [

	AIGraphFixture stronglyConnectedGraph: graphReducer.
	graphReducer run.
	self
		assertNodes: (graphReducer nodes flatCollect: #adjacentNodes)
		doesNotInclude: (self mergedNodesIn: graphReducer nodes)
]

{ #category : #tests }
AIGraphReducerTest >> testNoCycle [

	AIGraphFixture complexCycleGraph2: graphReducer.
	graphReducer run.
	graphReducer nodes do: [ :node |
		self
			deny: (node adjacentNodes includes: node)
			description: node asString , ' node is in cycle!' ]
]

{ #category : #tests }
AIGraphReducerTest >> testStronglyConnectedGraph [

	| nodeModels nodeModelsCollection |
	AIGraphFixture stronglyConnectedGraph: graphReducer.
	graphReducer run.
	nodeModels := graphReducer nodes collect: #model.
	nodeModelsCollection := nodeModels select: [ :e | e isCollection ].

	self assert: graphReducer nodes size equals: 4.
	self assert: (nodeModels includes: $i).
	self assert: (nodeModelsCollection anySatisfy: [ :aNodeModel |
		aNodeModel includesAll: #( $e $d ) ]).
	self assert: (nodeModelsCollection anySatisfy: [ :aNodeModel |
		aNodeModel includesAll: #( $a $b $c ) ]).
	self assert: (nodeModelsCollection anySatisfy: [ :aNodeModel |
		aNodeModel includesAll: #( $f $g $h ) ])
]

{ #category : #tests }
AIGraphReducerTest >> testStronglyConnectedGraphReferences [

	| reducedNodeI mergedNodes reducedNodeABC reducedNodeDE reducedNodeFGH |
	AIGraphFixture stronglyConnectedGraph: graphReducer.
	graphReducer run.
	reducedNodeI := (graphReducer nodes select: [ :each |
		                 each model = $i ]) first.
	mergedNodes := graphReducer nodes select: [ :each |
		               each model isCollection ].
	reducedNodeABC := (mergedNodes select: [ :each |
		                   each model includesAll: #( $a $b $c ) ]) first.
	reducedNodeDE := (mergedNodes select: [ :each |
		                  each model includesAll: #( $d $e ) ]) first.
	reducedNodeFGH := (mergedNodes select: [ :each |
		                   each model includesAll: #( $f $g $h ) ]) first.

	self
		assertCollection: reducedNodeI adjacentNodes
		hasSameElements: { reducedNodeI. reducedNodeFGH }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeI adjacentNodes size equals: 2.

	self
		assertCollection: reducedNodeABC adjacentNodes
		hasSameElements: { reducedNodeDE }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeABC adjacentNodes size equals: 1.

	self
		assertCollection: reducedNodeFGH adjacentNodes
		hasSameElements: { reducedNodeDE. reducedNodeABC }.
	"See is there is no duplicated adjacencies"
	self assert: reducedNodeFGH adjacentNodes size equals: 2.

	self assert: reducedNodeDE adjacentNodes isEmpty
]
