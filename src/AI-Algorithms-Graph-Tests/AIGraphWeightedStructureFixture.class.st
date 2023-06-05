"
Structure of Weighted Graphs
  - nodes
  - edges
  - weight
"
Class {
	#name : #AIGraphWeightedStructureFixture,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #action }
AIGraphWeightedStructureFixture >> buildGraphCanvas [

	| c box label arrowHeight marker ap interaction |
	c := RSCanvas new.
nodes:= self nodes.
edges := self edges.

c addAll: (RSComposite models: nodes forEach: [:shape :model |
    label := (RSLabel new
        text: model asString;
        color: Color black;
        yourself).
    box := RSCircle new
          extent: label extent y @ label extent y;
        color: Color white;
        borderColor: Color black.
    shape
        add: box;
        add: label;
        yourself
     ]).
c nodes @ RSDraggable new.

c @ RSCanvasController new.

"RSLineBuilder arrowedLine
    color: Color black;
    withBorderAttachPoint;
    shapes: c nodes;
    useAssociations: (edges collect: [:each | each first -> each last ])."
arrowHeight := 10.
marker := RSShapeFactory arrow size: arrowHeight.
marker := marker asMarker.
marker offset: arrowHeight / 2.
ap := RSBorderAttachPoint new
    endOffset: arrowHeight / 2;
    yourself.
edges do: [ :edge | 
    c add: (RSLine new
        markerEnd: marker;
        attachPoint: ap;
        color: Color black;
        from: (c nodes shapeFromModel: edge first) children second;
        to: (c nodes shapeFromModel: edge second) children second;
        model: edge third;
        yourself)
     ].
c lines pushBack.
interaction := RSLabeled new.
interaction text: [ :edgeModel | 'Model: ', edgeModel asString ].
interaction location inner; middle.
interaction shapeBuilder labelShape
    fontSize: 12;
    bold.
c lines @ interaction.
RSForceBasedLayout new
    charge: -200;
    on: c nodes.
^c
]

{ #category : #accessing }
AIGraphWeightedStructureFixture >> edges [
  ^edges.
]

{ #category : #accessing }
AIGraphWeightedStructureFixture >> edges: asObject [
  edges := asObject .
]

{ #category : #action }
AIGraphWeightedStructureFixture >> inspectGraph [

	<inspectorPresentationOrder: 0 title: 'Graph Representation'>
	| c |
	c := self buildGraphCanvas.
	^ SpRoassal3InspectorPresenter new
		  canvas: c;
		  yourself
]

{ #category : #accessing }
AIGraphWeightedStructureFixture >> nodes [
  ^nodes.
]

{ #category : #accessing }
AIGraphWeightedStructureFixture >> nodes: asObject [
  nodes := asObject .
]
