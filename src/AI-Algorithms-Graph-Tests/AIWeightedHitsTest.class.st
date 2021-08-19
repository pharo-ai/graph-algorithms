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
AIWeightedHitsTest >> testComplexWCycle [

	AIGraphFixture complexWeightedGraph: hits.
	hits run
]

{ #category : #tests }
AIWeightedHitsTest >> testSimpleW [

	AIGraphFixture simpleWeightedGraph: hits.
	hits run
]
