"
I am a node of group A or group B in the bipartite graph that models the stable matching problem.

I require a preference list of all nodes in the other group, sorted in the order of my preference.
"
Class {
	#name : 'AIStableMatchingNode',
	#superclass : 'AIGraphNode',
	#instVars : [
		'preferences',
		'lastProposedIndex',
		'pairing'
	],
	#category : 'AI-Algorithms-Graph-Components-Nodes',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Nodes'
}

{ #category : 'initialization' }
AIStableMatchingNode >> initialize [
	super initialize.
	lastProposedIndex := 0
]

{ #category : 'accessing' }
AIStableMatchingNode >> isFree [
	^ self pairing isNil
]

{ #category : 'accessing' }
AIStableMatchingNode >> lastProposedIndex [
	^ lastProposedIndex
]

{ #category : 'accessing' }
AIStableMatchingNode >> lastProposedIndex: anObject [
	^ lastProposedIndex := anObject
]

{ #category : 'accessing' }
AIStableMatchingNode >> nextPreferenceToPropose [
	^ self preferences at: (lastProposedIndex := lastProposedIndex + 1)
]

{ #category : 'accessing' }
AIStableMatchingNode >> pairing [
	^ pairing
]

{ #category : 'accessing' }
AIStableMatchingNode >> pairing: anAIStableMatchingEdge [
	pairing := anAIStableMatchingEdge
]

{ #category : 'testing' }
AIStableMatchingNode >> prefer: aContender over: anotherContender [
	self preferences do: [ :pref |
		pref = aContender
			ifTrue: [ ^ true ].
		pref = anotherContender
			ifTrue: [ ^ false ] ].
	"Should never reach the next statement since each contender defines his preferences for all the others."
	^ false
]

{ #category : 'accessing' }
AIStableMatchingNode >> preferences [
	^ preferences
]

{ #category : 'accessing' }
AIStableMatchingNode >> preferences: anObject [
	preferences := anObject
]

{ #category : 'printing' }
AIStableMatchingNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		<< $(.
	self data printOn: aStream.
	aStream
		<< $)
]

{ #category : 'testing' }
AIStableMatchingNode >> stillHasPreference [
	^ lastProposedIndex < self preferences size
]
