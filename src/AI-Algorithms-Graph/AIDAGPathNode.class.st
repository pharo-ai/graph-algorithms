Class {
	#name : #AIDAGPathNode,
	#superclass : #AINodeWithNext,
	#instVars : [
		'previousNode',
		'visited',
		'pathWeight',
		'outgoingEdges'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #initialization }
AIDAGPathNode >> initialize [

	super initialize.
	outgoingEdges := OrderedCollection new.
	visited := false.
	pathWeight := Float infinity
]

{ #category : #accessing }
AIDAGPathNode >> label [

	^ 'BFS: '
]

{ #category : #accessing }
AIDAGPathNode >> pathWeight [

	^ pathWeight
]

{ #category : #accessing }
AIDAGPathNode >> pathWeight: aNumber [

	pathWeight := aNumber
]

{ #category : #accessing }
AIDAGPathNode >> previousNode [

	^ previousNode
]

{ #category : #accessing }
AIDAGPathNode >> previousNode: aNode [

	previousNode := aNode
]

{ #category : #accessing }
AIDAGPathNode >> to: aNode edge: anEdge [

	adjacentNodes add: aNode.
	outgoingEdges add: anEdge
]

{ #category : #initialization }
AIDAGPathNode >> visited [

	^ visited
]

{ #category : #initialization }
AIDAGPathNode >> visited: aBoolean [

	visited := aBoolean
]
