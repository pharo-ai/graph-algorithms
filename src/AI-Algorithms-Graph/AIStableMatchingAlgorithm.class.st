"
I am a solver for the classic stable matching problem. I use the Gale-Shapley (Deferred Acceptance) algorithm.
Mass General Shapley and Alvin Roth won the Nobel Prize in Economics in 2012 for the Gale-Shapley algorithm and their work on applying it in practice.

"
Class {
	#name : 'AIStableMatchingAlgorithm',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'stableMatching',
		'groupA',
		'groupB',
		'freeNodesInAWithPreferenceFIFO'
	],
	#category : 'AI-Algorithms-Graph-Graph Matching',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Graph Matching'
}

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> firstInGroupAHavingAMatchingToProposeTo [
	"^ self groupA detect: [ :nodeInA | nodeInA isFree and: [ nodeInA stillHasPreference ] ] ifNone: [ nil ]"
	^ [ freeNodesInAWithPreferenceFIFO removeFirst ] on: CollectionIsEmpty do: [ nil ]
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> groupA [
	^ groupA
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> groupA: anObject [
	groupA := anObject.
	freeNodesInAWithPreferenceFIFO := LinkedList newFrom: groupA
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> groupB [
	^ groupB
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> groupB: anObject [
	groupB := anObject
]

{ #category : 'initialization' }
AIStableMatchingAlgorithm >> initialize [
	super initialize.
	self stableMatching: Set new
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> match: man with: woman [
	| marriage |
	marriage := AIStableMatchingEdge new
						nodeOfGroupA: man;
						nodeOfGroupB: woman;
						yourself.
	man marriage: marriage.
	woman marriage: marriage.
	self stableMatching
		add: marriage
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> stableMatching [
	^ stableMatching
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> stableMatching: anObject [
	stableMatching := anObject
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> unmatch: aSTStableMatchingEdge [
	aSTStableMatchingEdge nodeOfGroupA
		marriage: nil.
	aSTStableMatchingEdge nodeOfGroupA stillHasPreference
		ifTrue: [ freeNodesInAWithPreferenceFIFO addLast: aSTStableMatchingEdge nodeOfGroupA ].
	aSTStableMatchingEdge nodeOfGroupB
		marriage: nil.
	self stableMatching
		remove: aSTStableMatchingEdge
]
