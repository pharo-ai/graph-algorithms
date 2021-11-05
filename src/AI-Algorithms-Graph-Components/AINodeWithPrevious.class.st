"
A basic node able to host the model and to represent edges with no additional class.
Edges are navigable in both way through the nextNodes and prevousNodes instances variables.
"
Class {
	#name : #AINodeWithPrevious,
	#superclass : #AIGraphNode,
	#instVars : [
		'incomingNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AINodeWithPrevious >> from: sourceNode [

	incomingNodes add: sourceNode
]

{ #category : #accessing }
AINodeWithPrevious >> incomingNodes [

	^ incomingNodes
]

{ #category : #setting }
AINodeWithPrevious >> incomingNodes: aNodeList [

	incomingNodes := aNodeList
]

{ #category : #initialization }
AINodeWithPrevious >> initialize [

	super initialize.
	incomingNodes := OrderedCollection new
]

{ #category : #testing }
AINodeWithPrevious >> isLeaf [

	^ incomingNodes isEmpty
]

{ #category : #testing }
AINodeWithPrevious >> isRoot [

	^ incomingNodes isEmpty
]
