"
I am a node used for the Hits algorithm
"
Class {
	#name : #MalHitsNode,
	#superclass : #AINodeWithNextAndPrevious,
	#instVars : [
		'auth',
		'hub'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
MalHitsNode >> auth [
	^ auth
]

{ #category : #accessing }
MalHitsNode >> auth: anObject [
	auth := anObject
]

{ #category : #accessing }
MalHitsNode >> hub [
	^ hub
]

{ #category : #accessing }
MalHitsNode >> hub: anObject [
	hub := anObject
]

{ #category : #initialization }
MalHitsNode >> initialize [

	super initialize.
	auth := 1.
	hub := 1
]

{ #category : #accessing }
MalHitsNode >> label [

	^ 'H '
]

{ #category : #printing }
MalHitsNode >> printOn: aStream [

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
