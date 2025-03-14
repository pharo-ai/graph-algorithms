"
I am a node that is used in the Dijkstra algorithm
"
Class {
	#name : 'AIPathDistanceNode',
	#superclass : 'AIGraphNode',
	#instVars : [
		'previousNode',
		'visited',
		'outgoingEdges',
		'pathDistance',
		'priority'
	],
	#category : 'AI-Algorithms-Graph-Components-Nodes',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Nodes'
}

{ #category : 'initialization' }
AIPathDistanceNode >> initialize [

	super initialize.
	outgoingEdges := OrderedCollection new.
	pathDistance := Float infinity.
	visited := false.
	priority := Float infinity. 
	
]

{ #category : 'accessing' }
AIPathDistanceNode >> outgoingEdges [

	^ outgoingEdges
]

{ #category : 'accessing' }
AIPathDistanceNode >> pathDistance [

	^ pathDistance
]

{ #category : 'accessing' }
AIPathDistanceNode >> pathDistance: anObject [

	pathDistance := anObject
]

{ #category : 'accessing' }
AIPathDistanceNode >> previousNode [

	^ previousNode
]

{ #category : 'accessing' }
AIPathDistanceNode >> previousNode: aNode [

	previousNode := aNode
]

{ #category : 'printing' }
AIPathDistanceNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' weight: ';
		nextPutAll: pathDistance asString
]

{ #category : 'accessing' }
AIPathDistanceNode >> priority [ 
	
	^ priority 
]

{ #category : 'accessing' }
AIPathDistanceNode >> priority: anInteger [
	
	priority := anInteger.
]

{ #category : 'accessing' }
AIPathDistanceNode >> to: aNode edge: anEdge [

	outgoingEdges add: anEdge.
	adjacentNodes add: aNode
]

{ #category : 'accessing' }
AIPathDistanceNode >> visited [

	^ visited
]

{ #category : 'accessing' }
AIPathDistanceNode >> visited: anObject [

	visited := anObject
]
