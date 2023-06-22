Class {
	#name : #AIGraphTestFixtureStructure,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #action }
AIGraphTestFixtureStructure >> buildGraphCanvas [

	^ self subclassResponsibility
]

{ #category : #accessing }
AIGraphTestFixtureStructure >> edges [

	^ edges
]

{ #category : #accessing }
AIGraphTestFixtureStructure >> edges: anObject [

	edges := anObject
]

{ #category : #action }
AIGraphTestFixtureStructure >> inspectGraph [

	<inspectorPresentationOrder: 0 title: 'Graph'>
	| c |
	c := self buildGraphCanvas.
	^ SpRoassal3InspectorPresenter new
		  canvas: c;
		  yourself
]

{ #category : #action }
AIGraphTestFixtureStructure >> inspectGraphContext: aContext [

	aContext withoutEvaluator
]

{ #category : #accessing }
AIGraphTestFixtureStructure >> nodes [

	^ nodes
]

{ #category : #accessing }
AIGraphTestFixtureStructure >> nodes: asObject [

	nodes := asObject
]
