"
I am a solver for the stable marriage problem. I use the David Gale and Lloyd Shapley algorithm.
"
Class {
	#name : 'AIStableMatchingAlgorithm',
	#superclass : 'Object',
	#instVars : [
		'men',
		'women',
		'marriages',
		'freeMenWithPreferenceFIFO'
	],
	#category : 'AI-Algorithms-Graph-Graph Matching',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Graph Matching'
}

{ #category : 'computation' }
AIStableMatchingAlgorithm >> divorce: marriage [
	marriage man
		marriage: nil.
	marriage man stillHasPreference
		ifTrue: [ freeMenWithPreferenceFIFO addLast: marriage man ].
	marriage woman
		marriage: nil.
	self marriages
		remove: marriage
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> firstManHavingAWomanToProposeTo [
	"^ self men detect: [ :man | man isFree and: [ man stillHasPreference ] ] ifNone: [ nil ]"
	^ [ freeMenWithPreferenceFIFO removeFirst ] on: CollectionIsEmpty do: [ nil ]
]

{ #category : 'initialization' }
AIStableMatchingAlgorithm >> initialize [
	super initialize.
	self marriages: Set new
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> marriages [
	^ marriages
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> marriages: anObject [
	marriages := anObject
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> marry: man with: woman [
	| marriage |
	marriage := AIStableMatchingEdge new
						man: man;
						woman: woman;
						yourself.
	man marriage: marriage.
	woman marriage: marriage.
	self marriages
		add: marriage
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> men [
	^ men
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> men: anObject [
	men := anObject.
	freeMenWithPreferenceFIFO := LinkedList newFrom: men
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> solve [
	self stableMatching.
	^ self marriages
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> stableMatching [
	|man|
	[ (man := self firstManHavingAWomanToProposeTo) isNotNil ]
		whileTrue: [ | woman|
			woman := man nextPreferenceToPropose.
			woman isFree
				ifTrue: [ 
					self marry: man with: woman ]
				ifFalse: [ |actualMariage|
					actualMariage := woman marriage.
					(woman prefer: man over: actualMariage man)
						ifTrue: [ 
							self divorce: actualMariage.
							self marry: man with: woman ]
						ifFalse: [ 
							freeMenWithPreferenceFIFO
								addLast: man ] ] ]
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> women [
	^ women
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> women: anObject [
	women := anObject
]
