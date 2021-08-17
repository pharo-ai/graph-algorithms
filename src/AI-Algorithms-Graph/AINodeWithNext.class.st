"
I am basic node that stores my adjacent nodes. The instance variable `nextNodes` represent my adjacent nodes (the nodes to which I am connected)
"
Class {
	#name : #AINodeWithNext,
	#superclass : #AIGraphNode,
	#instVars : [
		'adjacentNodes'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
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

{ #category : #testing }
AINodeWithNext >> isLeaf [

	^ self nextNodes isEmpty
]

{ #category : #accessing }
AINodeWithNext >> nextNodes [

	self
		deprecated: 'Please use #adjacentNodes instead'
		transformWith: '`@receiver nextNodes' -> '`@receiver adjacentNodes'.
	^ self adjacentNodes
]

{ #category : #setting }
AINodeWithNext >> nextNodes: aNodeList [

	self
		deprecated: 'Please use #adjacentNodes: instead'
		transformWith:
		'`@receiver nextNodes: `@arg' -> '`@receiver adjacentNodes: `@arg'.
	self adjacentNodes: aNodeList
]

{ #category : #accessing }
AINodeWithNext >> to: targetNode [

	adjacentNodes add: targetNode
]
