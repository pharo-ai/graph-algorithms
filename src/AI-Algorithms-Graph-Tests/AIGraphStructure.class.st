"
Structure of Non Weighted Graphs
  - nodes
  - edges
"
Class {
	#name : #AIGraphStructure,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #action }
AIGraphStructure >> InspectGraph [
<inspectorPresentationOrder: 0 title: 'Cool graph'>
| c label box |
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

RSLineBuilder arrowedLine
    color: Color black;
    withBorderAttachPoint;
    shapes: c nodes;
    useAssociations: (edges collect: [:each | each first -> each last ]).
    
RSCircleLayout on: c nodes.
c
]

{ #category : #accessing }
AIGraphStructure >> edges [
  ^edges.
]

{ #category : #accessing }
AIGraphStructure >> edges: asObject [
  edges := asObject .
]

{ #category : #accessing }
AIGraphStructure >> nodes [
  ^nodes.
]

{ #category : #accessing }
AIGraphStructure >> nodes: asObject [
  nodes := asObject .
]
