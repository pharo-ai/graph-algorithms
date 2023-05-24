Class {
	#name : #AILongestPathInDAGTest,
	#superclass : #TestCase,
	#instVars : [
		'longestPathAlgo'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AILongestPathInDAGTest >> setUp [

	super setUp.
	longestPathAlgo := AILongestPathInDAG new
]

{ #category : #tests }
AILongestPathInDAGTest >> testWeightedDAG [

	| shortestPath |
	AIGraphFixture weightedDAG: longestPathAlgo.
	longestPathAlgo
		start: $A;
		end: $F;
		run.
	shortestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $F) pathDistance equals: 22.
	self assert: shortestPath asArray equals: #( $A $B $D $E $F ).

	longestPathAlgo end: $E.
	shortestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $E) pathDistance equals: 15.
	self assert: shortestPath asArray equals: #( $A $B $D $E ).

	longestPathAlgo runFrom: $B to: $F.
	shortestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $F) pathDistance equals: 21.
	self assert: shortestPath asArray equals: #( $B $D $E $F ).
	longestPathAlgo end: $G.
	shortestPath := longestPathAlgo reconstructPath.
	self
		assert: (longestPathAlgo findNode: $G) pathDistance
		equals: Float infinity.
	self assert: shortestPath asArray equals: #(  )
]

{ #category : #tests }
AILongestPathInDAGTest >> testWithoutCyclesComplexWeightedGraph [

	| longestPath |
	AIGraphFixture withoutCyclesComplexWeightedGraph: longestPathAlgo.
	longestPathAlgo
		start: $b;
		end: $s;
		run.
	longestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $s) pathDistance equals: 10.
	self assert: longestPath asArray equals: #( $b $c $q $p $s )
]
