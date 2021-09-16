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
AIShortestPathInDAGTest >> testWeightedDAG [

	| shortestPath |
	AIGraphFixture weightedDAG: shortestPathAlgo.
	shortestPathAlgo
		start: $A;
		end: $F;
		run.
	shortestPath := shortestPathAlgo reconstructPath.
	self assert: (shortestPathAlgo findNode: $F) pathWeight equals: 19.
	self assert: shortestPath asArray equals: #( $A $B $E $F ).

	shortestPathAlgo end: $E.
	shortestPath := shortestPathAlgo reconstructPath.
	self assert: (shortestPathAlgo findNode: $E) pathWeight equals: 12.
	self assert: shortestPath asArray equals: #( $A $B $E ).

	shortestPathAlgo
		start: $B;
		end: $F;
		run.
	shortestPath := shortestPathAlgo reconstructPath.
	self assert: (shortestPathAlgo findNode: $F) pathWeight equals: 18.
	self assert: shortestPath asArray equals: #( $B $E $F )
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
