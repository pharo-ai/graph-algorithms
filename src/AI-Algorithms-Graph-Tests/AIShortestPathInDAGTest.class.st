"
An AIShortestPathInDAGTest is a test class for testing the behavior of AIShortestPathInDAG
"
Class {
	#name : #AIShortestPathInDAGTest,
	#superclass : #TestCase,
	#instVars : [
		'shortestPathAlgo'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIShortestPathInDAGTest >> setUp [

	super setUp.
	shortestPathAlgo := AIShortestPathInDAG new
]

{ #category : #tests }
AIShortestPathInDAGTest >> testWithoutCyclesComplexWeightedGraph [

	| shortestPath |
	AIGraphFixture withoutCyclesComplexWeightedGraph: shortestPathAlgo.
	shortestPathAlgo
		start: $b;
		end: $s;
		run.
	shortestPath := shortestPathAlgo reconstructPath.
	self assert: (shortestPathAlgo findNode: $s) pathWeight equals: 10.
	self assert: shortestPath asArray equals: #( $b $c $q $p $s )
]
