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

{ #category : #'drawing - roassal' }
AIGraphNonWeightedFixtureStructure >> buildGraphCanvas [

	| canvas |
	canvas := RSCanvas new.
	canvas addAll: (self nodesAsRoassalShapes).
	canvas nodes @ RSDraggable new.
	canvas @ RSCanvasController new.

	RSLineBuilder arrowedLine
		color: Color black;
		withBorderAttachPoint;
		shapes: canvas nodes;
		useAssociations:
			(edges collect: [ :each | each first -> each last ]).

	RSCircleLayout on: canvas nodes.
	^ canvas
]
