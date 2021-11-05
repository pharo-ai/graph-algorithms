"
I am a node used for the Hits algorithm
"
Class {
	#name : #AIHitsNode,
	#superclass : #AINodeWithPrevious,
	#instVars : [
		'auth',
		'hub'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIHitsNode >> auth [
	^ auth
]

{ #category : #accessing }
AIHitsNode >> auth: anObject [
	auth := anObject
]

{ #category : #accessing }
AIHitsNode >> hub [
	^ hub
]

{ #category : #accessing }
AIHitsNode >> hub: anObject [
	hub := anObject
]

{ #category : #initialization }
AIHitsNode >> initialize [

	super initialize.
	auth := 1.
	hub := 1
]

{ #category : #accessing }
AIHitsNode >> label [

	^ 'H '
]

{ #category : #printing }
AIHitsNode >> printOn: aStream [

	aStream nextPut: $(.
	self model printOn: aStream.
	aStream space.
	aStream << 'auth: '.
	self auth printOn: aStream showingDecimalPlaces: 2.
	aStream space.
	aStream << 'hub: '.
	self hub printOn: aStream showingDecimalPlaces: 2.
	aStream nextPutAll: ')'
]
