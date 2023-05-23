Class {
	#name : #AIWeightedHitsTest,
	#superclass : #TestCase,
	#instVars : [
		'hits'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIWeightedHitsTest >> setUp [

	super setUp.
	hits := AIWeightedHits new
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted [

	| graph |
	graph := AICyclicWeightedGraph new.
	hits :=graph complexWeightedGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted2 [

	| graph |
	graph := AICyclicWeightedGraph new.
	hits :=graph complexWeightedGraph2: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted3 [

	| graph |
	graph := AICyclicWeightedGraph new.
	hits :=graph complexWeightedGraph3: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testSimpleW [

	| graph |
	graph := AICyclicWeightedGraph new.
	hits :=graph simpleWeightedGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testWithoutCyclesComplexWeightedGraph [

	| graph |
	graph := AIWeightedDAG new.
	hits :=graph withoutCyclesComplexWeightedGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]
