"
I am basic node that stores my adjacent nodes. The instance variable `nextNodes` represent my adjacent nodes (the nodes to which I am connected)
"
Class {
	#name : #AINodeWithNext,
	#superclass : #AIGraphNode,
	#instVars : [
		'adjacentNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AINodeWithNext >> adjacentNodes [

	^ adjacentNodes
]

{ #category : #setting }
AINodeWithNext >> adjacentNodes: aNodeList [

	adjacentNodes := aNodeList
]

{ #category : #initialization }
AINodeWithNext >> initialize [

	super initialize.
	adjacentNodes := OrderedCollection new
]

{ #category : #accessing }
AINodeWithNext >> to: targetNode [

	adjacentNodes add: targetNode
]
