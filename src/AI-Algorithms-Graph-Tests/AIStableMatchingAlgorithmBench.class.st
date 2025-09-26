Class {
	#name : 'AIStableMatchingAlgorithmBench',
	#superclass : 'Object',
	#category : 'AI-Algorithms-Graph-Tests-Bench',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Bench'
}

{ #category : 'generation' }
AIStableMatchingAlgorithmBench class >> generateRandomProblemWith: numberOfContender [
	| men women |
	men := (1 to: numberOfContender) collect: [ :i | AIStableMatchingNode new ].
	women := (1 to: numberOfContender) collect: [ :i | AIStableMatchingNode new ].
	
	men do: [ :man | man preferences: women copy shuffle ].
	women do: [ :woman | woman preferences: men copy shuffle ].
	
	^ AIStableMatchingAlgorithm new
		men: men;
		women: women;
		yourself
]

{ #category : 'benchmarking' }
AIStableMatchingAlgorithmBench >> benchmark: nTimes upToPower: power [
	| result |
	result := OrderedCollection new.
	(1 to: power) do: [ :i | |size times|
		size := 10**i.
		times := OrderedCollection new.
		(1 to: nTimes) do: [ :j | |solver|
			solver := (self generateRandomProblemWith: size). 
			times add: [ solver stableMatching ] timeToRun ] displayingProgress: 'Iterations'.
		result add: { size }, times ] displayingProgress: 'Size loop'.
	^ result
]

{ #category : 'generation' }
AIStableMatchingAlgorithmBench >> generateRandomProblemWith: numberOfContender [
	^ self class generateRandomProblemWith: numberOfContender
]
