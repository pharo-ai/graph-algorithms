"
Structure of Non Weighted Graphs
  - nodes
  - edges
"
Class {
	#name : #AIGraphNonWeightedFixtureStructure,
	#superclass : #AIGraphTestFixtureStructure,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #action }
AIGraphNonWeightedFixtureStructure >> buildGraphCanvas [

	| c box label |
	c := RSCanvas new.
	c addAll: (RSComposite models: nodes forEach: [ :shape :model | 
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
				 yourself ]).
	c nodes @ RSDraggable new.

	c @ RSCanvasController new.

	RSLineBuilder arrowedLine
		color: Color black;
		withBorderAttachPoint;
		shapes: c nodes;
		useAssociations:
			(edges collect: [ :each | each first -> each last ]).

	RSCircleLayout on: c nodes.
	^ c
]

{ #category : #action }
AIGraphNonWeightedFixtureStructure >> nodesAsRoassalShapes [

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
