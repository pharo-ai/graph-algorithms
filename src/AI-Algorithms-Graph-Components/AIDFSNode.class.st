"
I am a node that is used in the DFS algorithm defined in the `AIDFS` class. I have an instance variable `previousNode` to track from which node I have been called and also an instance variable visited to see if I were visited or not.
"
Class {
	#name : 'AIDFSNode',
	#superclass : 'AIGraphNode',
	#instVars : [
		'previousNode',
		'visited'
	],
	#category : 'AI-Algorithms-Graph-Components-Nodes',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Nodes'
}

{ #category : 'initialization' }
AIDFSNode >> initialize [

	super initialize.
	visited := false.
]

{ #category : 'accessing' }
AIDFSNode >> label [

	^ 'DFS: '
]

{ #category : 'accessing' }
AIDFSNode >> previousNode [

	^ previousNode
]

{ #category : 'accessing' }
AIDFSNode >> previousNode: aNode [

	previousNode := aNode
]

{ #category : 'accessing' }
AIDFSNode >> visited [

	^ visited
]

{ #category : 'accessing' }
AIDFSNode >> visited: aBoolean [

	visited := aBoolean
]
