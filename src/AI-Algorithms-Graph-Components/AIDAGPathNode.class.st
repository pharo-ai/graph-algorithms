"
I am a node that is used in the shortest path algorithm for DAG (Directed Acyclic Graph)
"
Class {
	#name : #AIDAGPathNode,
	#superclass : #AINodeWithNext,
	#instVars : [
		'previousNode',
		'pathWeight',
		'outgoingEdges'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #initialization }
AIDAGPathNode >> initialize [

	super initialize.
	outgoingEdges := OrderedCollection new.
	pathWeight := Float infinity
]

{ #category : #accessing }
AIDAGPathNode >> label [

	^ 'Path in DAG: '
]

{ #category : #accessing }
AIDAGPathNode >> outgoingEdges [

	^ outgoingEdges
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
