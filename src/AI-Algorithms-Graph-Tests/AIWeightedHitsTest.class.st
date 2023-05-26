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

	| graph algo |
	graph := AICyclicWeightedGraph new.
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
AIWeightedHitsTest >> testComplexWeighted2 [

	| graph algo |
	graph := AICyclicWeightedGraph new.
	algo :=graph complexWeightedGraph2.
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
AIWeightedHitsTest >> testComplexWeighted3 [

	| graph algo |
	graph := AICyclicWeightedGraph new.
	algo :=graph complexWeightedGraph3.
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
AIWeightedHitsTest >> testSimpleW [

	| graph algo |
	graph := AICyclicWeightedGraph new.
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

{ #category : #tests }
AIWeightedHitsTest >> testWithoutCyclesComplexWeightedGraph [

	| graph algo |
	graph := AIWeightedDAG new.
	algo :=graph weightedDAG.
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
