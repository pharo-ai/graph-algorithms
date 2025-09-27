"
I am a solver for the classic stable matching problem. I use the Gale-Shapley (Deferred Acceptance) algorithm.
Mass General Shapley and Alvin Roth won the Nobel Prize in Economics in 2012 for the Gale-Shapley algorithm and their work on applying it in practice.

I require that my two contender groups A and B are equaly sized and of course disjunct.

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

{ #category : 'instance creation' }
AIStableMatchingAlgorithm class >> groupA: groupA groupB: groupB [
	"Answer a new instance of mine with groupA and groupB being each a Set of AIStableMatchingNode of equal size and disjunct."

	^ self new
		  groupA: groupA;
		  groupB: groupB;
		  yourself
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> firstContenderInAHavingAMatchingToProposeTo [
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
						contenderInGroupA: man;
						contenderInGroupB: woman;
						yourself.
	man pairing: marriage.
	woman pairing: marriage.
	self stableMatching
		add: marriage
]

{ #category : 'configuration' }
AIStableMatchingAlgorithm >> nodeClass [

	^ AIStableMatchingNode
]

{ #category : 'running' }
AIStableMatchingAlgorithm >> run [

	| contenderInA |
	[ (contenderInA := self firstContenderInAHavingAMatchingToProposeTo) isNotNil ]
		whileTrue: [
				| contenderInB |
				contenderInB := contenderInA nextPreferenceToPropose.
				contenderInB isFree
					ifTrue: [ self match: contenderInA with: contenderInB ]
					ifFalse: [
							| currentPairing |
							currentPairing := contenderInB pairing.
							(contenderInB prefer: contenderInA over: currentPairing contenderInGroupA)
								ifTrue: [
										self unmatch: currentPairing.
										self match: contenderInA with: contenderInB ]
								ifFalse: [ freeNodesInAWithPreferenceFIFO addLast: contenderInA ] ] ]
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
	aSTStableMatchingEdge contenderInGroupA
		pairing: nil.
	aSTStableMatchingEdge contenderInGroupA stillHasPreference
		ifTrue: [ freeNodesInAWithPreferenceFIFO addLast: aSTStableMatchingEdge contenderInGroupA ].
	aSTStableMatchingEdge contenderInGroupB
		pairing: nil.
	self stableMatching
		remove: aSTStableMatchingEdge
]
