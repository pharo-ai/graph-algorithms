"
Structure of Non Weighted Graphs
  - nodes
  - edges
"
Class {
	#name : #AIGraphNonWeightedStructureFixture,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #action }
AIGraphNonWeightedStructureFixture >> buildGraphCanvas [

	| c box label |
	c := RSCanvas new.
	nodes := self nodes.
	edges := self edges.

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

{ #category : #accessing }
AIGraphNonWeightedStructureFixture >> edges [
  ^edges.
]

{ #category : #accessing }
AIGraphNonWeightedStructureFixture >> edges: asObject [
  edges := asObject .
]

{ #category : #action }
AIGraphNonWeightedStructureFixture >> inspectGraph [

	<inspectorPresentationOrder: 0 title: 'Graph Representation'>
	| c |
	c := self buildGraphCanvas.
	^ SpRoassal3InspectorPresenter new
		  canvas: c;
		  yourself
]

{ #category : #accessing }
AIGraphNonWeightedStructureFixture >> nodes [
  ^nodes.
]

{ #category : #accessing }
AIGraphNonWeightedStructureFixture >> nodes: asObject [
  nodes := asObject .
]
