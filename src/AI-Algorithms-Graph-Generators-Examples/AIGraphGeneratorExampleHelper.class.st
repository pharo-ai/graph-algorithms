Class {
	#name : #AIGraphGeneratorExampleHelper,
	#superclass : #Object,
	#instVars : [
		'canvas'
	],
	#category : #'AI-Algorithms-Graph-Generators-Examples-Helper'
}

{ #category : #public }
AIGraphGeneratorExampleHelper >> animatedLayout [

	| layout |
	layout := RSForceBasedLayout new
		          nodes: canvas nodes;
		          edges: canvas edges;
		          start;
		          yourself.
	canvas nodes @ (RSDraggableForce new layout: layout).
	canvas newAnimation repeat onStepDo: [ :t | 
		layout step.
		canvas zoomToFit ]
]

{ #category : #building }
AIGraphGeneratorExampleHelper >> buildEdgesFor: graphEdges inCanvas: canvas [

	| edges |
	edges := RSEdgeBuilder line
		         canvas: canvas;
		         color: (Color red alpha: 0.5);
		         source: graphEdges connectFrom: #from to: #to.
	edges do: [ :e | e pushBack ]
]

{ #category : #public }
AIGraphGeneratorExampleHelper >> fixedLayout [

	| layout |
	layout := RSGridLayout new
		          nodes: canvas nodes;
		          edges: canvas edges;
		          yourself
]

{ #category : #public }
AIGraphGeneratorExampleHelper >> gridLayout: anInteger [

	RSGridLayout new
		lineItemsCount: anInteger;
		on: canvas nodes;
		yourself
]

{ #category : #initialization }
AIGraphGeneratorExampleHelper >> initialize [

	super initialize.
	canvas := RSCanvas new
]

{ #category : #public }
AIGraphGeneratorExampleHelper >> nodes: graphNodes edges: graphEdges [

	canvas addAll: (self shapesFor: graphNodes).
	self buildEdgesFor: graphEdges inCanvas: canvas
]

{ #category : #public }
AIGraphGeneratorExampleHelper >> run [

	canvas @ RSCanvasController.
	canvas zoomToFit.
	canvas open
]

{ #category : #building }
AIGraphGeneratorExampleHelper >> shape [

	^ (RSEllipse new
		   color: (Color purple alpha: 0.3);
		   size: 10)
		  @ RSDraggable;
		  yourself
]

{ #category : #building }
AIGraphGeneratorExampleHelper >> shapesFor: graphNodes [

	^ RSGroup newFrom:
		  (graphNodes collect: [ :node | self shape model: node ])
]
