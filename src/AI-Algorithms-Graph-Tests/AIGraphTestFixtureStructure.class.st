Class {
	#name : #AIGraphTestFixtureStructure,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #'drawing - roassal' }
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

{ #category : #inspector }
AIGraphTestFixtureStructure >> inspectGraph [

	<inspectorPresentationOrder: 0 title: 'Graph'>
	| c |
	c := self buildGraphCanvas.
	^ SpRoassal3InspectorPresenter new
		  canvas: c;
		  yourself
]

{ #category : #inspector }
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

{ #category : #'drawing - roassal' }
AIGraphTestFixtureStructure >> nodesAsRoassalShapes [

	|nodesAsRoassalShapes |

	nodesAsRoassalShapes := RSComposite models: nodes forEach: [ :shape :model |
		| box label |
		label := RSLabel new
			text: model asString;
			color: Color black;
			yourself.
		box := RSCircle new
			extent: label extent y @ label extent y;
			color: Color white;
			borderColor: Color black.
		shape
			add: box;
			add: label;
			yourself ].
	^ nodesAsRoassalShapes
]
