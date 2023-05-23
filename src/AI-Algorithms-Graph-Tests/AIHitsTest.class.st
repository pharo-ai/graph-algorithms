Class {
	#name : #AIHitsTest,
	#superclass : #TestCase,
	#instVars : [
		'hits'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIHitsTest >> setUp [

	super setUp.
	hits := AIHits new
]

{ #category : #tests }
AIHitsTest >> testComplexCycle [

	| graph |
	graph := AICyclicNonWeightedGraph new.
	hits :=graph complexCycleGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testComplexWCycle [

	| graph |
	graph := AICyclicWeightedGraph new.
	hits :=graph complexWeightedGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testCycle [

	| graph |
	graph := AICyclicNonWeightedGraph new.
	hits :=graph cycleGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testGraphForHits [

	| graph |
	graph := AICyclicNonWeightedGraph new.
	hits :=graph simpleGraphForHits: hits .
	hits k: 3.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 0.
		self deny: node auth equals: 0 ]
]

{ #category : #tests }
AIHitsTest >> testNestedCycle [

	| graph |
	graph := AICyclicNonWeightedGraph new.
	hits :=graph nestedCycleGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testSimple [

	| graph |
	graph := AINonWeightedDAG new.
	hits :=graph simpleGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testSimpleW [

	| graph |
	graph := AICyclicWeightedGraph new.
	hits :=graph simpleWeightedGraph: hits .
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]
