"
I am a node used for the weighted hits algorithm
"
Class {
	#name : #AIWeightedHitsNode,
	#superclass : #AIHitsNode,
	#instVars : [
		'outgoingEdges',
		'incomingEdges'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIWeightedHitsNode >> from: aNode edge: anEdge [

	incomingNodes add: aNode.
	incomingEdges add: anEdge
]

{ #category : #accessing }
AIWeightedHitsNode >> incomingEdges [

	^ incomingEdges
]

{ #category : #initialization }
AIWeightedHitsNode >> initialize [

	super initialize.
	outgoingEdges := OrderedCollection new.
	incomingEdges := OrderedCollection new
]

{ #category : #accessing }
AIWeightedHitsNode >> label [

	^ 'WH '
]

{ #category : #accessing }
AIWeightedHitsNode >> outgoingEdges [

	^ outgoingEdges
]

{ #category : #accessing }
AIWeightedHitsNode >> to: aNode edge: anEdge [

	adjacentNodes add: aNode.
	outgoingEdges add: anEdge
]
