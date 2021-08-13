Class {
	#name : #AIHalNode,
	#superclass : #AITarjanNode,
	#instVars : [
		'hNumber',
		'previousNodes'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
AIHalNode >> from: aHalNode [
	previousNodes add: aHalNode
]

{ #category : #accessing }
AIHalNode >> hNumber [
	^ hNumber
]

{ #category : #accessing }
AIHalNode >> hNumber: anObject [
	hNumber := anObject
]

{ #category : #initialization }
AIHalNode >> initialize [
	super initialize.
	previousNodes := Set new
]

{ #category : #testing }
AIHalNode >> isSink [

	^ self nextNodes isEmpty 
]

{ #category : #testing }
AIHalNode >> isSource [

	^ self previousNodes isEmpty 
]

{ #category : #accessing }
AIHalNode >> label [

	^ 'Ha '
]

{ #category : #'hal-algorithm' }
AIHalNode >> markCycleWith: anInteger [

	self cycleNodes do: [ :next | next hNumber: anInteger ].
	^ self cycleNodes 
]

{ #category : #'hal-algorithm' }
AIHalNode >> markHNumber: anInteger [

	self hNumber: anInteger.
	self isInCycle ifTrue: [
		^ self markCycleWith: anInteger
	].
	^ OrderedCollection new
]

{ #category : #accessing }
AIHalNode >> previousNodes [
	^ previousNodes
]

{ #category : #accessing }
AIHalNode >> previousNodes: anObject [
	previousNodes := anObject
]

{ #category : #'hal-algorithm' }
AIHalNode >> removeCycleFromEdges [

	self nextNodes removeAllFoundIn: self cycleNodes.
	self previousNodes removeAllFoundIn: self cycleNodes 
]

{ #category : #accessing }
AIHalNode >> to: aNode [
	super to: aNode.
	aNode previousNodes add: self
]
