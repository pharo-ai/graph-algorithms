"
I am a matching relating an element in group A with an element in group B.
"
Class {
	#name : 'AIStableMatchingEdge',
	#superclass : 'AIGraphEdge',
	#instVars : [
		'nodeOfGroupA',
		'nodeOfGroupB'
	],
	#category : 'AI-Algorithms-Graph-Components-Edges',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Edges'
}

{ #category : 'comparing' }
AIStableMatchingEdge >> = anObject [
	^ self class = anObject class
			and: [ self nodeOfGroupA = anObject nodeOfGroupA
						and: [ self nodeOfGroupB = anObject nodeOfGroupB ] ]
]

{ #category : 'comparing' }
AIStableMatchingEdge >> hash [
	^ self nodeOfGroupA hash bitXor: self nodeOfGroupB hash
]

{ #category : 'accessing' }
AIStableMatchingEdge >> nodeOfGroupA [
	^ nodeOfGroupA
]

{ #category : 'accessing' }
AIStableMatchingEdge >> nodeOfGroupA: anObject [
	nodeOfGroupA := anObject
]

{ #category : 'accessing' }
AIStableMatchingEdge >> nodeOfGroupB [
	^ nodeOfGroupB
]

{ #category : 'accessing' }
AIStableMatchingEdge >> nodeOfGroupB: anObject [
	nodeOfGroupB := anObject
]

{ #category : 'printing' }
AIStableMatchingEdge >> printOn: aStream [
	super printOn: aStream.
	
	aStream << $(.
	self nodeOfGroupA printOn: aStream.
	aStream << $,.
	self nodeOfGroupB printOn: aStream.
	aStream <<$)
]
