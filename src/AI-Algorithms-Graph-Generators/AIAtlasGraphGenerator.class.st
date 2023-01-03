"
I'm able to build graphs described in the Atlas of Graphs.

See ""An Atlas of Graphs"" by Ronald C. Read and Robin J. Wilson,
Oxford University Press, 1998.


"
Class {
	#name : #AIAtlasGraphGenerator,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'edgesArray'
	],
	#category : #'AI-Algorithms-Graph-Generators'
}

{ #category : #'0 node' }
AIAtlasGraphGenerator class >> G0 [
	^ self new edgesArray: #()
]

{ #category : #'1 node' }
AIAtlasGraphGenerator class >> G1 [
	^ self new
		nodes: (1 to: 1);
		edgesArray: #()
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G10 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(4 3) #(4 2))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G11 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(1 2) #(4 3))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G12 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(4 3) #(2 3) #(4 2))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G13 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(4 1) #(4 2) #(4 3))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G14 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(1 2) #(2 3) #(1 4))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G15 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(4 3) #(2 3) #(4 2) #(4 1))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G16 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(1 2) #(2 3) #(3 4) #(1 4))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G17 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(1 2) #(1 3) #(1 4) #(2 3) #(3 4))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G18 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(1 2) #(1 3) #(1 4) #(2 3) #(3 4))
]

{ #category : #'2 nodes' }
AIAtlasGraphGenerator class >> G2 [
	^ self new
		nodes: (1 to: 2);
		edgesArray: #()
]

{ #category : #'2 nodes' }
AIAtlasGraphGenerator class >> G3 [
	^ self new
		nodes: (1 to: 2);
		edgesArray: #(#(1 2))
]

{ #category : #'3 nodes' }
AIAtlasGraphGenerator class >> G4 [
	^ self new
		nodes: (1 to: 3);
		edgesArray: #()
]

{ #category : #'3 nodes' }
AIAtlasGraphGenerator class >> G5 [
	^ self new
		nodes: (1 to: 3);
		edgesArray: #(#(2 3))
]

{ #category : #'3 nodes' }
AIAtlasGraphGenerator class >> G6 [
	^ self new
		nodes: (1 to: 3);
		edgesArray: #(#(1 2) #(1 3))
]

{ #category : #'3 nodes' }
AIAtlasGraphGenerator class >> G7 [
	^ self new
		nodes: (1 to: 3);
		edgesArray: #(#(1 2) #(1 3) #(2 3))
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G8 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #()
]

{ #category : #'4 nodes' }
AIAtlasGraphGenerator class >> G9 [
	^ self new
		nodes: (1 to: 4);
		edgesArray: #(#(4 3))
]

{ #category : #configuration }
AIAtlasGraphGenerator >> edgeClass [
	^ AIGraphEdge
]

{ #category : #configuration }
AIAtlasGraphGenerator >> edgesArray: anArray [
	edgesArray := anArray
]

{ #category : #running }
AIAtlasGraphGenerator >> run [
	edgesArray
		do: [ :edge |
			self
				addEdge:
					{edge first.
					edge second}
				from: #first
				to: #second ]
]
