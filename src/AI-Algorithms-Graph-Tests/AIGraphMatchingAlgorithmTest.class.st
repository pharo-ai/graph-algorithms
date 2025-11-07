"
The tests can be grouped as follows:
- If the fixture's optimal matching is known, test that the greedy result approximates by the half at least. 
- For (generated) complete graphs, test that the greedy result is (near-)perfect.
- If the fixture's optimal matching is not known, test that the greedy result is at best perfect.  
- Miscellaneous
  - Test that loops are not considered for matching.
  - Test that the greedy method is not optimal.
  - Test that all vertices of a matching are distinct.
  - Test that the class AIGreedyMatching shouldn't implement the new method.
"
Class {
	#name : 'AIGraphMatchingAlgorithmTest',
	#superclass : 'TestCase',
	#category : 'AI-Algorithms-Graph-Tests-Graph Matching Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Graph Matching Tests'
}

{ #category : 'fixtures' }
AIGraphMatchingAlgorithmTest >> bipartiteCompleteGraphWithVerticesA: numberOfVerticesA andVerticesB: numberOfVerticesB [
	"Answer a complete bipartite graph of size numberOfVerticesA,numberOfVerticesB."

	| oddNodes evenNodes allNodes edges |
	oddNodes := 1 to: numberOfVerticesA * 2 by: 2.
	evenNodes := 2 to: numberOfVerticesB * 2 by: 2.
	edges := oddNodes
		         inject: OrderedCollection new
		         into: [ :collection :from |
				         collection addAll: (evenNodes collect: [ :to |
							          {
								          from.
								          to } ]).
				         collection ].
	allNodes := oddNodes asOrderedCollection
		            addAll: evenNodes;
		            yourself.
	^ {
		  allNodes.
		  edges }
]

{ #category : 'fixtures' }
AIGraphMatchingAlgorithmTest >> completeGraphWithVertices: numberOfVertices [
	"Answer a complete graph of size numberOfVertices."

	| nodes edges nodesCopy |
	nodes := 1 to: numberOfVertices.
	"This to avoid the following (unjustified?) warning: 'Modifies collection while iterating over it'."
	nodesCopy := nodes.
	edges := nodes
		         inject: OrderedCollection new
		         into: [ :collection :from |
				         | adjacentEdges |
				         adjacentEdges := (nodesCopy copyWithout: from) collect: [ :to |
						                          {
							                          from.
							                          to } ].
				         collection
					         addAll: adjacentEdges;
					         yourself ].
	^ {
		  nodes.
		  edges }
]

{ #category : 'fixtures' }
AIGraphMatchingAlgorithmTest >> graphForProvingNotOptimalWeight [
	"Answer a weighted graph for proving that the greedy maximum weighted matching algorithm is not optimal.
	This is the example used for the proof in https://www.cs.cornell.edu/courses/cs6820/2014fa/matchingNotes.pdf.
	The optimal maximal weight sum is 2. The optimal minimal weight sum is 1+epsilon."

	| nodes edges |
	nodes := $a to: $d.
	edges := {
		         #( $a $b 1 ).
		         {
			         $b.
			         $c.
			         (1 + Number epsilon) }.
		         #( $c $d 1 ) }.
	^ {
		  nodes.
		  edges }
]

{ #category : 'fixtures' }
AIGraphMatchingAlgorithmTest >> mwmfSampleWeigthedGraph [
	"Answer the sample graph (slightly modified to get different maximum and minimum matching weight sums) of the Maximum Weighted Matching Finder online app available at https://mwmatching.johnridesa.bike.
This is an app for finding optimal matchings on weighted graphs. The user can enter any example graph with weights at will in order to calculate an optimal maximum weighted matching or the maximum cardinality. It is also possible to dually calculate an optimal minimum weighted matching by subtracting all edge weights in the graph from the maximum weight.
- The maximum weighted matching sums 155.
- The maximum cardinality is 5.
- The minimum weighted matching sums 145."

	| nodes edges |
	nodes := #( #john #gabriel #james #joseph #mary #michael #paul #peter
	            #raphael #andrew ).
	edges := #( #( #raphael #andrew 40 ) #( #andrew #gabriel 30 )
	            #( #gabriel #raphael 50 ) #( #gabriel #joseph 55 )
	            #( #james #paul 10 ) #( #john #peter 10 )
	            #( #joseph #michael 60 ) #( #joseph #mary 40 )
	            #( #mary #paul 15 ) #( #mary #michael 40 )
	            #( #michael #raphael 55 ) #( #peter #raphael 30 ) ).
	^ {
		  nodes.
		  edges }
]

{ #category : 'running' }
AIGraphMatchingAlgorithmTest >> newMaximumCardinality [

	^ AIGraphMatchingAlgorithm newMaximumCardinality
]

{ #category : 'running' }
AIGraphMatchingAlgorithmTest >> newMaximumWeighted [

	^ AIGraphMatchingAlgorithm newMaximumWeighted
]

{ #category : 'running' }
AIGraphMatchingAlgorithmTest >> newMinimumWeighted [

	^ AIGraphMatchingAlgorithm newMinimumWeighted
]

{ #category : 'fixtures' }
AIGraphMatchingAlgorithmTest >> singleNodeGraphWithLoop [

	^ #( #( $a ) #( #( $a $a ) ) )
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCompleteBipartiteRegularGraph [

	| algorithm graph |
	algorithm := self newMaximumCardinality.
	"A bipartite graph is regular if it is balanced (both parts have the same cardinality)."
	graph := self bipartiteCompleteGraphWithVerticesA: 10 andVerticesB: 10.
	algorithm nodes: graph first.
	algorithm edges: graph second from: #first to: #second.
	"For a regular bipartite graph, it exists a perfect matching."
	self assert: algorithm run size equals: algorithm nodes size // 2
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCompleteGraph [

	self testCompleteGraphWithVertices: 5.
	self testCompleteGraphWithVertices: 6.
	self testCompleteGraphWithVertices: 10.
	self testCompleteGraphWithVertices: 11
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCompleteGraphWithVertices: numberOfVertices [

	| algorithm graph |
	algorithm := self newMaximumCardinality.
	graph := self completeGraphWithVertices: numberOfVertices.
	algorithm nodes: graph first.
	algorithm edges: graph second from: #first to: #second.
	"For a complete graph, the greedy algorithm finds always a (near-)perfect matching."
	self assert: algorithm run size equals: numberOfVertices // 2
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCyclicNonWeightedComplex [

	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedComplexFixture new complexCycleGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedComplexFixture new complexCycleGraph2.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedComplexFixture new complexUndirectedGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedComplexFixture new stronglyConnectedGraph
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCyclicNonWeightedSimple [

	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new aseCircuitGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new aseSccGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new cycleGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new dependencyGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new moduleGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new nestedCycleGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AICyclicNonWeightedSimpleFixture new simpleGraphForHits
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCyclicWeightedComplex [

	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph2.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph3.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph4.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph2.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph3.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedComplexFixture new complexWeightedGraph4
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testCyclicWeightedSimple [

	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new aseCircuitWeightedGraph.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new aseWeightedCircuitGraph.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new negativeUnconnectedWeightedGraph.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new negativeWeightedGraph.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new negativeWeightedGraph2.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new simpleWeightedGraph.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new simpleWeightedGraph2.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new aseCircuitWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new aseWeightedCircuitGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new negativeUnconnectedWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new negativeWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new negativeWeightedGraph2.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new simpleWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AICyclicWeightedSimpleFixture new simpleWeightedGraph2
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testDifferentVertices [

	| algorithm graph distintVertices |
	algorithm := self newMaximumCardinality.
	graph := self completeGraphWithVertices: 8.
	algorithm nodes: graph first.
	algorithm edges: graph second from: #first to: #second.

	"A matching (aka independent edge set) has no common vertices."
	distintVertices := algorithm run
		                   inject: OrderedCollection new
		                   into: [ :vertices :edge |
				                   vertices
					                   add: edge from;
					                   add: edge to;
					                   yourself ].
	self assert: distintVertices size equals: distintVertices asSet size
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testIsAtMostPerfectWithAlgorithm: aAIGreedyMatching weightedGraph: weightedGraph [

	aAIGreedyMatching nodes: weightedGraph nodes.
	aAIGreedyMatching
		edges: weightedGraph edges
		from: #first
		to: #second
		weight: #third.
	"Is at most a (near-)perfect matching."
	self assert: aAIGreedyMatching run size <= (weightedGraph nodes size // 2)
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testLoop [

	| algorithm |
	algorithm := self newMaximumCardinality.
	algorithm nodes: self singleNodeGraphWithLoop first.
	algorithm
		edges: self singleNodeGraphWithLoop second
		from: #first
		to: #second.
	self assert: algorithm run isEmpty
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testMaximumCardinalityIsAtMostPerfectForGraph: graph [

	| algorithm |
	algorithm := self newMaximumCardinality.
	algorithm nodes: graph nodes.
	algorithm edges: graph edges from: #first to: #second.
	"Is at most a (near-)perfect matching."
	self assert: algorithm run size <= (graph nodes size // 2)
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testMaximumWeightedIsAtMostPerfectForGraph: weightedGraph [

	self
		testIsAtMostPerfectWithAlgorithm: self newMaximumWeighted
		weightedGraph: weightedGraph
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testMinimumWeightedIsAtMostPerfectForGraph: weightedGraph [

	self
		testIsAtMostPerfectWithAlgorithm: self newMinimumWeighted 
		weightedGraph: weightedGraph
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testMwmfSampleMaximumCardinality [

	| algorithm sampleGraph |
	algorithm := self newMaximumCardinality.
	sampleGraph := self mwmfSampleWeigthedGraph.
	algorithm nodes: sampleGraph first.
	algorithm edges: sampleGraph second from: #first to: #second.
	"The optimal maximum cardinality for this sample graph is 5."
	self assert: algorithm run size >= (5 / 2)
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testMwmfSampleMaximumWeight [

	| algorithm sampleGraph |
	algorithm := self newMaximumWeighted.
	sampleGraph := self mwmfSampleWeigthedGraph.
	algorithm nodes: sampleGraph first.
	algorithm
		edges: sampleGraph second
		from: #first
		to: #second
		weight: #third.
	"The optimal maximum weight for this sample graph is 155."
	self assert: (algorithm run sum: #weight) >= (155 / 2)
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testMwmfSampleMinimumWeight [

	| algorithm sampleGraph |
	algorithm := self newMinimumWeighted.
	sampleGraph := self mwmfSampleWeigthedGraph.
	algorithm nodes: sampleGraph first.
	algorithm
		edges: sampleGraph second
		from: #first
		to: #second
		weight: #third.
	"The optimal minimum weight for this sample graph is 145."
	self assert: (algorithm run sum: #weight) <= (145 * 2)
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testNewShouldnt [

	self should: [ AIGraphMatchingAlgorithm new ] raise: ShouldNotImplement
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testNonWeightedDAG [

	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AINonWeightedDAGFixture new simpleGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AINonWeightedDAGFixture new moduleGraph2.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AINonWeightedDAGFixture new withoutCyclesComplexGraph.
	self testMaximumCardinalityIsAtMostPerfectForGraph:
		AINonWeightedDAGFixture new withoutCyclesMediumGraph
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testNotOptimalMaximumWeight [

	| algorithm provingGraph |
	algorithm := self newMaximumWeighted.
	provingGraph := self graphForProvingNotOptimalWeight.
	algorithm nodes: provingGraph first.
	algorithm
		edges: provingGraph second
		from: #first
		to: #second
		weight: #third.
	"The optimal maximum weight is 2."
	self assert: (algorithm run sum: #weight) ~= 1
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testNotOptimalMinimumWeight [

	| algorithm provingGraph |
	algorithm := self newMinimumWeighted.
	provingGraph := self graphForProvingNotOptimalWeight.
	algorithm nodes: provingGraph first.
	algorithm
		edges: provingGraph second
		from: #first
		to: #second
		weight: #third.
	"The optimal minimum weight is 1+epsilon."
	self assert: (algorithm run sum: #weight) equals: 2
]

{ #category : 'tests' }
AIGraphMatchingAlgorithmTest >> testWeightedDAG [

	self testMaximumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new weightedDAG.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new withoutCyclesComplexWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new weightedDAG.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new withoutCyclesComplexWeightedGraph
]
