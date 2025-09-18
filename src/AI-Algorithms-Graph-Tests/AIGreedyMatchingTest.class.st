Class {
	#name : 'AIGreedyMatchingTest',
	#superclass : 'TestCase',
	#category : 'AI-Algorithms-Graph-Tests-Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Tests'
}

{ #category : 'fixtures' }
AIGreedyMatchingTest >> graphForProvingNotOptimalWeight [
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

{ #category : 'running' }
AIGreedyMatchingTest >> newMaximumCardinality [

	^ AIGreedyMatching newMaximumCardinality
]

{ #category : 'running' }
AIGreedyMatchingTest >> newMaximumWeighted [

	^ AIGreedyMatching newMaximumWeighted
]

{ #category : 'running' }
AIGreedyMatchingTest >> newMinimumWeighted [

	^ AIGreedyMatching newMinimumWeighted
]

{ #category : 'fixtures' }
AIGreedyMatchingTest >> singleNodeGraphWithLoop [

	^ #( #( $a ) #( #( $a $a ) ) )
]

{ #category : 'tests' }
AIGreedyMatchingTest >> testCyclicNonWeightedComplex [

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
AIGreedyMatchingTest >> testCyclicNonWeightedSimple [

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
AIGreedyMatchingTest >> testCyclicWeightedComplex [

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
AIGreedyMatchingTest >> testCyclicWeightedSimple [

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
AIGreedyMatchingTest >> testIsAtMostPerfectWithAlgorithm: aAIGreedyMatching graph: graph [

	aAIGreedyMatching nodes: graph nodes.
	aAIGreedyMatching
		edges: graph edges
		from: #first
		to: #second
		weight: #third.
	"Is at most a (near-)perfect matching."
	self assert: aAIGreedyMatching run size <= (graph nodes size // 2)
]

{ #category : 'tests' }
AIGreedyMatchingTest >> testLoop [

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
AIGreedyMatchingTest >> testMaximumCardinalityIsAtMostPerfectForGraph: graph [

	| algorithm |
	algorithm := self newMaximumCardinality.
	algorithm nodes: graph nodes.
	algorithm edges: graph edges from: #first to: #second.
	"Is at most a (near-)perfect matching."
	self assert: algorithm run size <= (graph nodes size // 2)
]

{ #category : 'tests' }
AIGreedyMatchingTest >> testMaximumWeightedIsAtMostPerfectForGraph: graph [

	self
		testIsAtMostPerfectWithAlgorithm: self newMaximumWeighted
		graph: graph
]

{ #category : 'tests' }
AIGreedyMatchingTest >> testMinimumWeightedIsAtMostPerfectForGraph: graph [

	self
		testIsAtMostPerfectWithAlgorithm: self newMinimumWeighted 
		graph: graph
]

{ #category : 'tests' }
AIGreedyMatchingTest >> testNewShouldnt [

	self should: [ AIGreedyMatching new ] raise: ShouldNotImplement
]

{ #category : 'tests' }
AIGreedyMatchingTest >> testNonWeightedDAG [

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
AIGreedyMatchingTest >> testNotOptimalMaximumWeight [

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
AIGreedyMatchingTest >> testNotOptimalMinimumWeight [

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
AIGreedyMatchingTest >> testWeightedDAG [

	self testMaximumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new weightedDAG.
	self testMaximumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new withoutCyclesComplexWeightedGraph.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new weightedDAG.
	self testMinimumWeightedIsAtMostPerfectForGraph:
		AIWeightedDAGFixture new withoutCyclesComplexWeightedGraph
]
