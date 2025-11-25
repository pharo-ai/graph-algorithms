"
I contain the basic graph fixture structure:
- an Array of node models
- an Array of weighted or unweighted edges.

Furthermore, I am able to visualize the graph by Roassal's inspector integration.

 
"
Class {
	#name : 'AIGraphTestFixtureStructure',
	#superclass : 'Object',
	#instVars : [
		'nodes',
		'edges'
	],
	#category : 'AI-Algorithms-Graph-Tests-Fixture',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Fixture'
}

{ #category : 'drawing - roassal' }
AIGraphTestFixtureStructure >> buildGraphCanvas [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
AIGraphTestFixtureStructure >> edges [

	^ edges
]

{ #category : 'accessing' }
AIGraphTestFixtureStructure >> edges: anObject [

	edges := anObject
]

{ #category : 'inspector' }
AIGraphTestFixtureStructure >> inspectGraph: aBuilder [

	<inspectorPresentationOrder: 0 title: 'Graph'>
	| c |
	c := self buildGraphCanvas.
	^ (aBuilder instantiate: SpRoassalInspectorPresenter)
		  canvas: c;
		  yourself
]

{ #category : 'inspector' }
AIGraphTestFixtureStructure >> inspectGraphContext: aContext [

	aContext withoutEvaluator
]

{ #category : 'accessing' }
AIGraphTestFixtureStructure >> nodes [

	^ nodes
]

{ #category : 'accessing' }
AIGraphTestFixtureStructure >> nodes: asObject [

	nodes := asObject
]

{ #category : 'drawing - roassal' }
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
