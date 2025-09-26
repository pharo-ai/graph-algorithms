"
I am a mariage between a man (SMMarried) and a woman (SMMarried).
"
Class {
	#name : 'AIStableMatchingEdge',
	#superclass : 'Object',
	#instVars : [
		'man',
		'woman'
	],
	#category : 'AI-Algorithms-Graph-Components-Edges',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Edges'
}

{ #category : 'comparing' }
AIStableMatchingEdge >> = anObject [
	^ self class = anObject class
			and: [ self man = anObject man
						and: [ self woman = anObject woman ] ]
]

{ #category : 'comparing' }
AIStableMatchingEdge >> hash [
	^ self man hash bitXor: self woman hash
]

{ #category : 'accessing' }
AIStableMatchingEdge >> man [
	^ man
]

{ #category : 'accessing' }
AIStableMatchingEdge >> man: anObject [
	man := anObject
]

{ #category : 'printing' }
AIStableMatchingEdge >> printOn: aStream [
	super printOn: aStream.
	
	aStream << $(.
	self man printOn: aStream.
	aStream << $,.
	self woman printOn: aStream.
	aStream <<$)
]

{ #category : 'accessing' }
AIStableMatchingEdge >> woman [
	^ woman
]

{ #category : 'accessing' }
AIStableMatchingEdge >> woman: anObject [
	woman := anObject
]
