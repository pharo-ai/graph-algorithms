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

	| longestPath graphType graph |
	graphType := AIWeightedDAGFixture new.
	graph :=graphType weightedDAG.
	longestPathAlgo nodes: graph nodes.
	longestPathAlgo  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	longestPathAlgo
		start: $A;
		end: $F;
		run.
	longestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $F) pathDistance equals: 22.
	self assert: longestPath asArray equals: #( $A $B $D $E $F ).

	longestPathAlgo end: $E.
	longestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $E) pathDistance equals: 15.
	self assert: longestPath asArray equals: #( $A $B $D $E ).

	longestPathAlgo runFrom: $B to: $F.
	longestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $F) pathDistance equals: 21.
	self assert: longestPath asArray equals: #( $B $D $E $F ).
	longestPathAlgo end: $G.
	longestPath := longestPathAlgo reconstructPath.
	self
		assert: (longestPathAlgo findNode: $G) pathDistance
		equals: Float infinity.
	self assert: longestPath asArray equals: #(  )
]

{ #category : #tests }
AILongestPathInDAGTest >> testWithoutCyclesComplexWeightedGraph [

	| longestPath graphType graph |
	graphType := AIWeightedDAGFixture new.
	graph :=graphType withoutCyclesComplexWeightedGraph.
	longestPathAlgo nodes: graph nodes.
	longestPathAlgo  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	longestPathAlgo
		start: $b;
		end: $s;
		run.
	longestPath := longestPathAlgo reconstructPath.
	self assert: (longestPathAlgo findNode: $s) pathDistance equals: 10.
	self assert: longestPath asArray equals: #( $b $c $q $p $s )
]
