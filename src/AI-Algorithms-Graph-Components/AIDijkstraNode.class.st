"
I am a node that is used in the Dijkstra algorithm
"
Class {
	#name : #AIDijkstraNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'previousNode',
		'pathWeight',
		'nextEdges',
		'visited'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #initialization }
AIDijkstraNode >> initialize [

	super initialize.
	nextEdges := OrderedCollection new.
	"initialization for Dijsktra"
	pathWeight := Float infinity.
	visited := false
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
AIDijkstraNode >> previousNode [

	^ previousNode
]

{ #category : #accessing }
AIDijkstraNode >> previousNode: aNode [

	previousNode := aNode
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

{ #category : #accessing }
AIDijkstraNode >> visited [

	^ visited
]

{ #category : #accessing }
AIDijkstraNode >> visited: anObject [

	visited := anObject
]
