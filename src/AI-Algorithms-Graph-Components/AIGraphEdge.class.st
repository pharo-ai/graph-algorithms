"
I represent an edge in a graph.  I'm part of the edges of a AIGraphAlgorithm and I link two AINode together.

Public API and Key Messages
- from
- to 
- model 
 
Instance Variables
	from: <MalNode>
	to: <MalNode>
	model: <Object>
"
Class {
	#name : #AIGraphEdge,
	#superclass : #Object,
	#instVars : [
		'model',
		'from',
		'to'
	],
	#category : #'AI-Algorithms-Graph-Components-Edges'
}

{ #category : #'instance creation' }
AIGraphEdge class >> with: aModel [

	^ self new model: aModel
]

{ #category : #'instance creation' }
AIGraphEdge class >> with: aModel from: srcNode to: dstNode [
	| edge |
	edge := self new.
	edge model: aModel.
	edge from: srcNode.
	edge to: dstNode.
	^ edge
]

{ #category : #accessing }
AIGraphEdge >> asTuple [

	^ {from model . to model}
]

{ #category : #accessing }
AIGraphEdge >> from [

	^ from
]

{ #category : #accessing }
AIGraphEdge >> from: anObject [

	from := anObject
]

{ #category : #accessing }
AIGraphEdge >> model [

	^ model
]

{ #category : #accessing }
AIGraphEdge >> model: aModel [

	model := aModel
]

{ #category : #printing }
AIGraphEdge >> printOn: aStream [

	self from printOn: aStream.
	aStream nextPutAll: ' -> '.
	self to printOn: aStream
]

{ #category : #accessing }
AIGraphEdge >> to [

	^ to
]

{ #category : #accessing }
AIGraphEdge >> to: anObject [

	to := anObject
]
