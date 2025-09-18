"
Concepts:
The maximum weight matching problem consists of finding in a weighted graph a matching for which the sum of weights is maximized.
Dually, for the minimum weight matching problem, the sum of weights is minimized.
A maximum matching (also known as maximum-cardinality matching) is a matching that contains the largest possible number of edges.
Maximum matching is not to be confused with maximal matching.
More on these concepts in https://en.wikipedia.org/wiki/Matching_(graph_theory).

Greedy algorithm:
The greedy matching algorithm doesn't always find the optimal solution.
However, it is a 2 approximation (greedy result >= 1/2 optimal result).
These two claims are concisely proven for the maximum weight matching in the following lecture at page 1:
https://www.cs.cornell.edu/courses/cs6820/2014fa/matchingNotes.pdf
A greedy matching algorithm can be efficient as about O(|E| log(|V|)).
By the way: A greedy matching algorithm always finds a maximal matching.

Usage:
Instantiate me with `newMaximumWeighted` for the greedy maximum weighted matching algorithm.
Instantiate me with `newMinimumWeighted` for the greedy minimum weighted matching algorithm.
Instantiate me with `newMaximumCardinality` for the greedy maximum cardinality matching algorithm.

Examples:
See in my test class examples of how to use me.
"
Class {
	#name : 'AIGreedyMatching',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'edgeClass',
		'preprocessingSortBlock'
	],
	#category : 'AI-Algorithms-Graph-Matching',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Matching'
}

{ #category : 'instance creation' }
AIGreedyMatching class >> new [

	^ self shouldNotImplement
]

{ #category : 'instance creation' }
AIGreedyMatching class >> newMaximumCardinality [

	^ self basicNew initializeMaximumCardinality
]

{ #category : 'instance creation' }
AIGreedyMatching class >> newMaximumWeighted [

	^ self basicNew initializeMaximumWeighted
]

{ #category : 'instance creation' }
AIGreedyMatching class >> newMinimumWeighted [

	^ self basicNew initializeMinimumWeighted
]

{ #category : 'configuration' }
AIGreedyMatching >> edgeClass [

	^ edgeClass
]

{ #category : 'initialization' }
AIGreedyMatching >> initializeMaximumCardinality [

	self initialize.
	edgeClass := AIGraphEdge.
	"No preprocessing sorting is used here.
	Alternatively, the edges could be first sorted by the sum of degrees of their endpoints.
	This can sometimes produce better results, albeit at the cost of some additional computational overhead.
	Runtime complexity: O(m) when the edges are not sorted, O(m+mlogn) otherwise, where n is the number of vertices, and m the number of edges.
	Information source: https://jgrapht.org/javadoc-1.5.1/org.jgrapht.core/org/jgrapht/alg/matching/GreedyMaximumCardinalityMatching.html."
	preprocessingSortBlock := nil
]

{ #category : 'initialization' }
AIGreedyMatching >> initializeMaximumWeighted [

	self initialize.
	edgeClass := AIWeightedEdge.
	preprocessingSortBlock := [ :a :b | a weight >= b weight ]
]

{ #category : 'initialization' }
AIGreedyMatching >> initializeMinimumWeighted [

	self initialize.
	edgeClass := AIWeightedEdge.
	preprocessingSortBlock := [ :a :b | a weight <= b weight ]
]

{ #category : 'running' }
AIGreedyMatching >> run [

	| matchingEdges eligibleEdges |
	matchingEdges := Set new.
	"Loops are not eligible for matching."
	eligibleEdges := self edges reject: [ :edge | edge from = edge to ].
	preprocessingSortBlock ifNotNil: [ :sortBlock |
		eligibleEdges sort: preprocessingSortBlock ].
	[ eligibleEdges notEmpty ] whileTrue: [
			| eligibleEdge |
			eligibleEdge := eligibleEdges first.
			matchingEdges add: eligibleEdge.
			eligibleEdges := eligibleEdges reject: [ :edge |
					                 {
						                 edge from.
						                 edge to } includesAny: {
							                 eligibleEdge from.
							                 eligibleEdge to } ] ].
	^ matchingEdges
]
