"
A basic node able to host the model and to represent edges with no additional class.
Edges are navigable in one way through the nextNodes instance variable.
"
Class {
	#name : #AINodeWithNext,
	#superclass : #AIGraphNode,
	#instVars : [
		'nextNodes'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #initialization }
AINodeWithNext >> initialize [

	super initialize.
	nextNodes := OrderedCollection new
]

{ #category : #testing }
AINodeWithNext >> isLeaf [

	^ self nextNodes isEmpty
]

{ #category : #accessing }
AINodeWithNext >> nextNodes [

	^ nextNodes
]

{ #category : #setting }
AINodeWithNext >> nextNodes: aNodeList [

	nextNodes := aNodeList
]

{ #category : #accessing }
AINodeWithNext >> to: targetNode [

	nextNodes add: targetNode
]
