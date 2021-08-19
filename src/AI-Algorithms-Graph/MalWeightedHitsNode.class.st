"
I am a node used for the weighted hits algorithm
"
Class {
	#name : #MalWeightedHitsNode,
	#superclass : #MalHitsNode,
	#instVars : [
		'outgoingEdges',
		'incomingEdges'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
MalWeightedHitsNode >> from: aNode edge: anEdge [

	incomingNodes add: aNode.
	incomingEdges add: anEdge
]

{ #category : #accessing }
MalWeightedHitsNode >> incomingEdges [

	^ incomingEdges
]

{ #category : #initialization }
MalWeightedHitsNode >> initialize [

	super initialize.
	outgoingEdges := OrderedCollection new.
	incomingEdges := OrderedCollection new
]

{ #category : #accessing }
MalWeightedHitsNode >> label [

	^ 'WH '
]

{ #category : #accessing }
MalWeightedHitsNode >> outgoingEdges [

	^ outgoingEdges
]

{ #category : #accessing }
MalWeightedHitsNode >> to: aNode edge: anEdge [

	adjacentNodes add: aNode.
	outgoingEdges add: anEdge
]
