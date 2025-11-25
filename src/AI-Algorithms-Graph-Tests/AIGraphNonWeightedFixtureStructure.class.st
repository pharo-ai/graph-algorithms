"
I am the fixture structure for unweighted graph fixtures.

I contain the edges in an Array of Arrays, where for each of the latter:
- The first element is the from node
- The second element is the to node.
"
Class {
	#name : 'AIGraphNonWeightedFixtureStructure',
	#superclass : 'AIGraphTestFixtureStructure',
	#category : 'AI-Algorithms-Graph-Tests-Fixture',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Fixture'
}

{ #category : 'drawing - roassal' }
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
			(edges collect: [ :each | each first -> each second ]).

	RSCircleLayout on: canvas nodes.
	^ canvas
]
