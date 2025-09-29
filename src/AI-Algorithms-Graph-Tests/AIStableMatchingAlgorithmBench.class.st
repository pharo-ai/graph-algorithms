"
I support benchmarking the AIStableMatchingAlgorithm class.
"
Class {
	#name : 'AIStableMatchingAlgorithmBench',
	#superclass : 'Object',
	#category : 'AI-Algorithms-Graph-Tests-Bench',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Bench'
}

{ #category : 'generation' }
AIStableMatchingAlgorithmBench class >> generateRandomProblemWith: groupSize [

	| groupA groupB |
	groupA := (1 to: groupSize) collect: [ :i | AIStableMatchingNode new ].
	groupB := (1 to: groupSize) collect: [ :i | AIStableMatchingNode new ].

	groupA do: [ :elementInA |
		elementInA preferences: groupB copy shuffle ].
	groupB do: [ :elementInB |
		elementInB preferences: groupA copy shuffle ].

	^ AIStableMatchingAlgorithm groupA: groupA groupB: groupB
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
			times add: [ solver run ] timeToRun ] displayingProgress: 'Iterations'.
		result add: { size }, times ] displayingProgress: 'Size loop'.
	^ result
]

{ #category : 'generation' }
AIStableMatchingAlgorithmBench >> generateRandomProblemWith: numberOfContender [
	^ self class generateRandomProblemWith: numberOfContender
]
