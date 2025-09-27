"
I am pairing an element in group A with an element in group B.
"
Class {
	#name : 'AIStableMatchingEdge',
	#superclass : 'AIGraphEdge',
	#instVars : [
		'contenderInGroupA',
		'contenderInGroupB'
	],
	#category : 'AI-Algorithms-Graph-Components-Edges',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Edges'
}

{ #category : 'comparing' }
AIStableMatchingEdge >> = anObject [
	^ self class = anObject class
			and: [ self contenderInGroupA = anObject contenderInGroupA
						and: [ self contenderInGroupB = anObject contenderInGroupB ] ]
]

{ #category : 'accessing' }
AIStableMatchingEdge >> contenderInGroupA [
	^ contenderInGroupA
]

{ #category : 'accessing' }
AIStableMatchingEdge >> contenderInGroupA: anAIStableMatchingNode [
	contenderInGroupA := anAIStableMatchingNode
]

{ #category : 'accessing' }
AIStableMatchingEdge >> contenderInGroupB [
	^ contenderInGroupB
]

{ #category : 'accessing' }
AIStableMatchingEdge >> contenderInGroupB: anAIStableMatchingNode [
	contenderInGroupB := anAIStableMatchingNode
]

{ #category : 'comparing' }
AIStableMatchingEdge >> hash [
	^ self contenderInGroupA hash bitXor: self contenderInGroupB hash
]

{ #category : 'printing' }
AIStableMatchingEdge >> printOn: aStream [
	super printOn: aStream.
	
	aStream << $(.
	self contenderInGroupA printOn: aStream.
	aStream << $,.
	self contenderInGroupB printOn: aStream.
	aStream <<$)
]
