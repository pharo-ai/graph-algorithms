Class {
	#name : 'AIHitsTest',
	#superclass : 'TestCase',
	#instVars : [
		'hits'
	],
	#category : 'AI-Algorithms-Graph-Tests-Link Analysis Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Link Analysis Tests'
}

{ #category : 'running' }
AIHitsTest >> setUp [

	super setUp.
	hits := AIHits new
]

{ #category : 'tests' }
AIHitsTest >> testComplexCycle [

	| graphType graph|
	graphType := AICyclicNonWeightedComplexFixture new.
	graph := graphType complexCycleGraph.
	hits nodes: graph nodes.
	hits edges: graph edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : 'tests' }
AIHitsTest >> testComplexWCycle [

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

{ #category : 'tests' }
AIHitsTest >> testCycle [

	| graphType graph|
	graphType := AICyclicNonWeightedSimpleFixture new.
	graph := graphType cycleGraph.
	hits nodes: graph nodes.
	hits edges: graph edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : 'tests' }
AIHitsTest >> testGraphForHits [

	| graphType graph|
	graphType := AICyclicNonWeightedSimpleFixture new.
	graph := graphType simpleGraphForHits.
	hits nodes: graph nodes.
	hits edges: graph edges from: #first to: #second.
	hits k: 3.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 0.
		self deny: node auth equals: 0 ]
]

{ #category : 'tests' }
AIHitsTest >> testNestedCycle [

	| graphType graph|
	graphType := AICyclicNonWeightedSimpleFixture new.
	graph := graphType nestedCycleGraph.
	hits nodes: graph nodes.
	hits edges: graph edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : 'tests' }
AIHitsTest >> testSimple [

	| graphType graph|
	graphType := AINonWeightedDAGFixture new.
	graph := graphType simpleGraph.
	hits nodes: graph nodes.
	hits edges: graph edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : 'tests' }
AIHitsTest >> testSimpleW [

	| graphType graph|
	graphType := AICyclicWeightedSimpleFixture new.
	graph := graphType simpleWeightedGraph.
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
