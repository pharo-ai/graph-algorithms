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

	AIGraphFixture complexCycleGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testComplexWCycle [

	AIGraphFixture complexWeightedGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testCycle [

	AIGraphFixture cycleGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testGraphForHits [

	AIGraphFixture simpleGraphForHits: hits.
	hits k: 3.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 0.
		self deny: node auth equals: 0 ]
]

{ #category : #tests }
AIHitsTest >> testNestedCycle [

	AIGraphFixture nestedCycleGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testSimple [

	AIGraphFixture simpleGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testSimpleW [

	AIGraphFixture simpleWeightedGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]
