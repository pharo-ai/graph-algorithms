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

	| graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph.
	hits nodes: graph nodes.
	hits  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted2 [

	| graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph2.
	hits nodes: graph nodes.
	hits  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testComplexWeighted3 [

	| graphType graph |
	graphType := AICyclicWeightedComplexFixture new.
	graph :=graphType complexWeightedGraph3.
	hits nodes: graph nodes.
	hits  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testSimpleW [

	| graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType simpleWeightedGraph.
	hits nodes: graph nodes.
	hits  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIWeightedHitsTest >> testWithoutCyclesComplexWeightedGraph [

	| graphType graph |
	graphType := AIWeightedDAGFixture new.
	graph :=graphType weightedDAG.
	hits nodes: graph nodes.
	hits  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]
