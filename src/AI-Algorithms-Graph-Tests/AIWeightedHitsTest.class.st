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

	AIGraphFixture complexWeightedGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted2 [

	AIGraphFixture complexWeightedGraph2: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted3 [

	AIGraphFixture complexWeightedGraph3: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testSimpleW [

	AIGraphFixture simpleWeightedGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testWithoutCyclesComplexWeightedGraph [

	AIGraphFixture withoutCyclesComplexWeightedGraph: hits.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]
