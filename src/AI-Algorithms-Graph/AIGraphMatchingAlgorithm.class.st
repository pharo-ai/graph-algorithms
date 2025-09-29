"
I compute an approximation either of the maximum-weight, the minimum-weight or the maximum-cardinality matching.
##Concepts
In graph theory, a *matching* (also known as an *independent edge set*) in an undirected graph is a set of edges without common vertices.
The maximum weight matching problem consists of finding in a weighted graph a matching for which the sum of weights is maximized.
Dually, for the minimum weight matching problem, the sum of weights is minimized.
A maximum matching (also known as maximum-cardinality matching) is a matching that contains the largest possible number of edges.
Maximum matching is not to be confused with maximal matching.
More on these concepts in https://en.wikipedia.org/wiki/Matching_(graph_theory).
(Don't confuse with another meaning of *graph matching* that is computing the similarity of graphs).

##Greedy algorithm
For finding matchings in a graph, I provide a version of the well studied greedy algorithms for matching, which are considerably easy to implement.
However, in contrast to [more elaborated matching algorithms](https://brilliant.org/wiki/matching-algorithms), a greedy graph matching algorithm doesn't always find the optimal solution. 
Nevertheless, it is a **2-approximation** (greedy result >= 1/2 optimal result).
These two claims are concisely proven for the maximum weight matching at the beginning of the following lecture:
https://www.cs.cornell.edu/courses/cs6820/2014fa/matchingNotes.pdf
A greedy matching algorithm can be efficient as about O(|E| log(|V|)).
By the way: A greedy matching algorithm always finds a maximal matching.

##Usage
Instantiate me with `newMaximumWeighted` for the greedy maximum weighted matching algorithm.
Instantiate me with `newMinimumWeighted` for the greedy minimum weighted matching algorithm.
Instantiate me with `newMaximumCardinality` for the greedy maximum cardinality matching algorithm.

##Examples
See in my commented test class examples of how to use me.
"
Class {
	#name : 'AIGraphMatchingAlgorithm',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'edgeClass',
		'preprocessingSortBlock'
	],
	#category : 'AI-Algorithms-Graph-Graph Matching',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Graph Matching'
}

{ #category : 'instance creation' }
AIGraphMatchingAlgorithm class >> new [

	^ self shouldNotImplement
]

{ #category : 'instance creation' }
AIGraphMatchingAlgorithm class >> newMaximumCardinality [

	^ self basicNew initializeMaximumCardinality
]

{ #category : 'instance creation' }
AIGraphMatchingAlgorithm class >> newMaximumWeighted [

	^ self basicNew initializeMaximumWeighted
]

{ #category : 'instance creation' }
AIGraphMatchingAlgorithm class >> newMinimumWeighted [

	^ self basicNew initializeMinimumWeighted
]

{ #category : 'configuration' }
AIGraphMatchingAlgorithm >> edgeClass [

	^ edgeClass
]

{ #category : 'initialization' }
AIGraphMatchingAlgorithm >> initializeMaximumCardinality [

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
AIGraphMatchingAlgorithm >> initializeMaximumWeighted [

	self initialize.
	edgeClass := AIWeightedEdge.
	preprocessingSortBlock := [ :a :b | a weight >= b weight ]
]

{ #category : 'initialization' }
AIGraphMatchingAlgorithm >> initializeMinimumWeighted [

	self initialize.
	edgeClass := AIWeightedEdge.
	preprocessingSortBlock := [ :a :b | a weight <= b weight ]
]

{ #category : 'running' }
AIGraphMatchingAlgorithm >> run [

	| matchingEdges eligibleEdges |
	matchingEdges := Set new.
	"Loops are not eligible."
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
