"
I am a node that is used in the BFS algorithm defined in the `AIBFS` class. I have an instance variable `previousNode` to track from which node I have been called and also an instance variable visited to see if I were visited or not.
"
Class {
	#name : #AIBFSNode,
	#superclass : #AINodeWithNext,
	#instVars : [
		'previousNode',
		'visited'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #initialization }
AIBFSNode >> initialize [

	super initialize.
	visited := false
]

{ #category : #accessing }
AIBFSNode >> label [

	^ 'BFS: '
]

{ #category : #accessing }
AIBFSNode >> previousNode [

	^ previousNode
]

{ #category : #accessing }
AIBFSNode >> previousNode: aNode [

	previousNode := aNode
]

{ #category : #initialization }
AIBFSNode >> visited [

	^ visited
]

{ #category : #initialization }
AIBFSNode >> visited: aBoolean [

	visited := aBoolean
]
