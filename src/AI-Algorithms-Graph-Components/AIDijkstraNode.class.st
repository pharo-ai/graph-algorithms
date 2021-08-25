"
I am a node that is used in the Dijkstra algorithm
"
Class {
	#name : #AIDijkstraNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'pathWeight',
		'previousEdges',
		'nextEdges',
		'previousNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIDijkstraNode >> from: aNode edge: anEdge [

	previousNodes add: aNode.
	previousEdges add: anEdge
]

{ #category : #initialization }
AIDijkstraNode >> initialize [

	super initialize.
	previousNodes := OrderedCollection new.
	previousEdges := OrderedCollection new.
	nextEdges := OrderedCollection new.
	"initialization for Dijsktra"
	pathWeight := Float infinity
]

{ #category : #accessing }
AIDijkstraNode >> nextEdges [

	^ nextEdges
]

{ #category : #accessing }
AIDijkstraNode >> pathWeight [

	^ pathWeight
]

{ #category : #accessing }
AIDijkstraNode >> pathWeight: anObject [

	pathWeight := anObject
]

{ #category : #accessing }
AIDijkstraNode >> previousEdges [

	^ previousEdges
]

{ #category : #accessing }
AIDijkstraNode >> previousNodes [

	^ previousNodes
]

{ #category : #printing }
AIDijkstraNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' weight: ';
		nextPutAll: pathWeight asString
]

{ #category : #accessing }
AIDijkstraNode >> to: aNode edge: anEdge [

	nextEdges add: anEdge
]
