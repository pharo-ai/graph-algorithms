"
I am a solver for the classic Stable Matching Problem, also known as Stable Marriage Problem.
I use the Gale-Shapley (Deferred Acceptance) algorithm.

Requirement:
I require that my two contender groups A and B are equaly sized and of course disjunct.

Result:
The algorithm answers always a stable matching. 
However, it yields the one that is best for group A and worst for group B.

Usage:
Instantiate me with class method ```#groupA:groupB:```.

By the way:
Mass General Shapley and Alvin Roth won the Nobel Prize in Economics in 2012 for the Gale-Shapley algorithm and their work on applying it in practice.

"
Class {
	#name : 'AIStableMatchingAlgorithm',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'stableMatching',
		'groupA',
		'groupB',
		'freeProposersWithPreference'
	],
	#category : 'AI-Algorithms-Graph-Graph Matching',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Graph Matching'
}

{ #category : 'instance creation' }
AIStableMatchingAlgorithm class >> groupA: groupA groupB: groupB [
	"Answer a new instance of mine with groupA and groupB being each a Set of AIStableMatchingNode of equal size and disjunct."

	^ self new initializeWithBipartition:
		  (Array with: groupA with: groupB)
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> groupA [
	^ groupA
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> groupB [
	^ groupB
]

{ #category : 'initialization' }
AIStableMatchingAlgorithm >> initialize [
	super initialize.
	stableMatching := Set new
]

{ #category : 'initialization' }
AIStableMatchingAlgorithm >> initializeWithBipartition: bipartition [
	"Initialize with the bipartition given as group pair."

	groupA := bipartition first.
	freeProposersWithPreference := LinkedList newFrom: groupA.
	groupB := bipartition second
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> matchContenderInGroupA: contenderInGroupA withContenderInGroupB: contenderInGroupB [

	| pairing |
	pairing := AIStableMatchingEdge
		           contenderInGroupA: contenderInGroupA
		           contenderInGroupB: contenderInGroupB.
	contenderInGroupA pairing: pairing.
	contenderInGroupB pairing: pairing.
	self stableMatching add: pairing
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> nextProposer [
	"^ self groupA detect: [ :nodeInA | nodeInA isFree and: [ nodeInA stillHasPreference ] ] ifNone: [ nil ]"
	^ [ freeProposersWithPreference removeFirst ] on: CollectionIsEmpty do: [ nil ]
]

{ #category : 'configuration' }
AIStableMatchingAlgorithm >> nodeClass [

	^ AIStableMatchingNode
]

{ #category : 'running' }
AIStableMatchingAlgorithm >> run [

	| contenderInA |
	[ (contenderInA := self nextProposer) isNotNil ]
		whileTrue: [
				| contenderInB |
				contenderInB := contenderInA nextPreferenceToPropose.
				contenderInB isFree
					ifTrue: [ self matchContenderInGroupA: contenderInA withContenderInGroupB: contenderInB ]
					ifFalse: [
							| currentPairing |
							currentPairing := contenderInB pairing.
							(contenderInB prefer: contenderInA over: currentPairing contenderInGroupA)
								ifTrue: [
										self unmatch: currentPairing.
										self matchContenderInGroupA: contenderInA withContenderInGroupB: contenderInB ]
								ifFalse: [ freeProposersWithPreference addLast: contenderInA ] ] ]
]

{ #category : 'accessing' }
AIStableMatchingAlgorithm >> stableMatching [
	^ stableMatching
]

{ #category : 'computation' }
AIStableMatchingAlgorithm >> unmatch: aSTStableMatchingEdge [
	aSTStableMatchingEdge contenderInGroupA
		pairing: nil.
	aSTStableMatchingEdge contenderInGroupA stillHasPreference
		ifTrue: [ freeProposersWithPreference addLast: aSTStableMatchingEdge contenderInGroupA ].
	aSTStableMatchingEdge contenderInGroupB
		pairing: nil.
	self stableMatching
		remove: aSTStableMatchingEdge
]
