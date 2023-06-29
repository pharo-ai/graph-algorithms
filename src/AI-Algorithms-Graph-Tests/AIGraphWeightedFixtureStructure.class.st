"
Structure of Weighted Graphs
  - nodes
  - edges
  - weight
"
Class {
	#name : #AIGraphWeightedFixtureStructure,
	#superclass : #AIGraphTestFixtureStructure,
	#category : #'AI-Algorithms-Graph-Tests-Fixture'
}

{ #category : #'drawing - roassal' }
AIGraphWeightedFixtureStructure >> buildGraphCanvas [

	| canvas arrowHeight marker attachedPoint interaction |
	canvas := RSCanvas new.
	canvas addAll: (self nodesAsRoassalShapes).
	canvas nodes @ RSDraggable new.
	canvas @ RSCanvasController new.

	arrowHeight := 10.
	marker := RSShapeFactory arrow size: arrowHeight.
	marker := marker asMarker.
	marker offset: arrowHeight / 2.
	attachedPoint := RSBorderAttachPoint new
		endOffset: arrowHeight / 2;
		yourself.

	edges do: [ :edge |
		canvas add: (RSLine new
			markerEnd: marker;
			attachPoint: attachedPoint;
			color: Color black;
			from: (canvas nodes shapeFromModel: edge first) children second;
			to: (canvas nodes shapeFromModel: edge second) children second;
			model: edge third;
			yourself) ].

	canvas lines pushBack.
	interaction := RSLabeled new.
	interaction text: [ :edgeModel | edgeModel asString ].
	interaction location
		inner;
		middle.
	interaction shapeBuilder labelShape
		color: Color black;
		fontSize: 8.

	canvas lines @ interaction.
	
	RSForceBasedLayout new
		charge: -200;
		on: canvas nodes.
	^ canvas
]
