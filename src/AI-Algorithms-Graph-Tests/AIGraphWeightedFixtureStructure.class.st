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

{ #category : #action }
AIGraphWeightedFixtureStructure >> buildGraphCanvas [

	| canvas box label arrowHeight marker attachedPoint interaction |
	canvas := RSCanvas new.

	canvas addAll: (RSComposite models: nodes forEach: [ :shape :model |
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
		fontSize: 12;
		bold.
	canvas lines @ interaction.
	
	RSForceBasedLayout new
		charge: -200;
		on: canvas nodes.
	^ canvas
]
