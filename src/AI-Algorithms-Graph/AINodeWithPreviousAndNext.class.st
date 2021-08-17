"
A basic node able to host the model and to represent edges with no additional class.
Edges are navigable in both way through the nextNodes and prevousNodes instances variables.
"
Class {
	#name : #AINodeWithPreviousAndNext,
	#superclass : #AINodeWithNext,
	#instVars : [
		'previousNodes'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
AINodeWithPreviousAndNext >> from: sourceNode [
	self previousNodes add: sourceNode 
]

{ #category : #initialization }
AINodeWithPreviousAndNext >> initialize [
	super initialize.
	previousNodes := OrderedCollection new
]

{ #category : #testing }
AINodeWithPreviousAndNext >> isRoot [
	^ self previousNodes isEmpty
]

{ #category : #accessing }
AINodeWithPreviousAndNext >> previousNodes [
	^ previousNodes
]

{ #category : #setting }
AINodeWithPreviousAndNext >> previousNodes: aNodeList [
	previousNodes := aNodeList
]
