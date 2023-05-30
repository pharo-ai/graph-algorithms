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

	| graph algo|
	graph := AICyclicNonWeightedComplexGraph new.
	algo := graph complexCycleGraph.
	hits nodes: algo nodes.
	hits edges: algo edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testComplexWCycle [

	| graph algo |
	graph := AICyclicWeightedComplexGraph new.
	algo :=graph complexWeightedGraph.
	hits nodes: algo nodes.
	hits  
	   edges: algo edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testCycle [

	| graph algo|
	graph := AICyclicNonWeightedSimpleGraph new.
	algo := graph cycleGraph.
	hits nodes: algo nodes.
	hits edges: algo edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testGraphForHits [

	| graph algo|
	graph := AICyclicNonWeightedSimpleGraph new.
	algo := graph simpleGraphForHits.
	hits nodes: algo nodes.
	hits edges: algo edges from: #first to: #second.
	hits k: 3.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 0.
		self deny: node auth equals: 0 ]
]

{ #category : #tests }
AIHitsTest >> testNestedCycle [

	| graph algo|
	graph := AICyclicNonWeightedSimpleGraph new.
	algo := graph nestedCycleGraph.
	hits nodes: algo nodes.
	hits edges: algo edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testSimple [

	| graph algo|
	graph := AINonWeightedDAG new.
	algo := graph simpleGraph.
	hits nodes: algo nodes.
	hits edges: algo edges from: #first to: #second.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]

{ #category : #tests }
AIHitsTest >> testSimpleW [

	| graph algo |
	graph := AICyclicWeightedSimpleGraph new.
	algo :=graph simpleWeightedGraph.
	hits nodes: algo nodes.
	hits  
	   edges: algo edges
		from: #first
		to: #second
		weight: #third.
	hits run.
	hits nodes do: [ :node |
		self deny: node hub equals: 1.
		self deny: node auth equals: 1 ]
]
