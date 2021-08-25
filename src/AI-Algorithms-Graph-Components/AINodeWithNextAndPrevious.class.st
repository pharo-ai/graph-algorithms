"
A basic node able to host the model and to represent edges with no additional class.
Edges are navigable in both way through the nextNodes and prevousNodes instances variables.
"
Class {
	#name : #AINodeWithNextAndPrevious,
	#superclass : #AINodeWithNext,
	#instVars : [
		'incomingNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AINodeWithNextAndPrevious >> from: sourceNode [

	incomingNodes add: sourceNode
]

{ #category : #accessing }
AINodeWithNextAndPrevious >> incomingNodes [

	^ incomingNodes
]

{ #category : #setting }
AINodeWithNextAndPrevious >> incomingNodes: aNodeList [

	incomingNodes := aNodeList
]

{ #category : #initialization }
AINodeWithNextAndPrevious >> initialize [

	super initialize.
	incomingNodes := OrderedCollection new
]

{ #category : #testing }
AINodeWithNextAndPrevious >> isRoot [

	^ incomingNodes isEmpty
]
