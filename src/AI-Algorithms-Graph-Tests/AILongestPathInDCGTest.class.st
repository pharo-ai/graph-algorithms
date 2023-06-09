Class {
	#name : #AILongestPathInDCGTest,
	#superclass : #TestCase,
	#instVars : [
		'longestPathAlgo'
	],
	#category : #'AI-Algorithms-Graph-Tests-Shortest path'
}

{ #category : #running }
AILongestPathInDCGTest >> setUp [
	super setUp.
	longestPathAlgo := AILongestPathInDCG new
]

{ #category : #tests }
AILongestPathInDCGTest >> testNegativeUnconnectedWeightedGraph [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType negativeUnconnectedWeightedGraph.
	longestPathAlgo nodes: graph nodes.
	longestPathAlgo  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	longestPathAlgo start: 0.
	longestPathAlgo run.

	self assert: (longestPathAlgo findNode: 1) pathDistance equals: 5.
	self assert: (longestPathAlgo findNode: 2) pathDistance equals: 25.
	self assert: (longestPathAlgo findNode: 3) pathDistance equals: 35.
	self assert: (longestPathAlgo findNode: 4) pathDistance equals: 100.
	self assert: (longestPathAlgo findNode: 5) pathDistance equals: 35.
	self assert: (longestPathAlgo findNode: 6) pathDistance equals: 65.
	self assert: (longestPathAlgo findNode: 7) pathDistance equals: 15.
	"No possible path between 0 and 8"
	self assert: (longestPathAlgo findNode: 8) pathDistance equals: Float infinity negated.
	self assert: (longestPathAlgo findNode: 9) pathDistance equals: 200
]

{ #category : #tests }
AILongestPathInDCGTest >> testNegativeWeightedGraph [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType negativeWeightedGraph.
	longestPathAlgo nodes: graph nodes.
	longestPathAlgo  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	longestPathAlgo start: 0.
	longestPathAlgo run.

	self assert: (longestPathAlgo findNode: 1) pathDistance equals: 5.
	self assert: (longestPathAlgo findNode: 2) pathDistance equals: 25.
	self assert: (longestPathAlgo findNode: 3) pathDistance equals: 35.
	self assert: (longestPathAlgo findNode: 4) pathDistance equals: 100.
	self assert: (longestPathAlgo findNode: 5) pathDistance equals: 35.
	self assert: (longestPathAlgo findNode: 6) pathDistance equals: 65.
	self assert: (longestPathAlgo findNode: 7) pathDistance equals: 15.
	self assert: (longestPathAlgo findNode: 8) pathDistance equals: 85.
	self assert: (longestPathAlgo findNode: 9) pathDistance equals: 200
]

{ #category : #tests }
AILongestPathInDCGTest >> testNegativeWeightedGraph2 [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType negativeWeightedGraph2.
	longestPathAlgo nodes: graph nodes.
	longestPathAlgo  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	longestPathAlgo start: 0.
	longestPathAlgo run.

	self assert: (longestPathAlgo findNode: 1) pathDistance equals: 5.
	self assert: (longestPathAlgo findNode: 2) pathDistance equals: 25.
	self assert: (longestPathAlgo findNode: 3) pathDistance equals: 35.
	self assert: (longestPathAlgo findNode: 4) pathDistance equals: 100.
	self assert: (longestPathAlgo findNode: 5) pathDistance equals: 35.
	self assert: (longestPathAlgo findNode: 6) pathDistance equals: 65.
	self assert: (longestPathAlgo findNode: 7) pathDistance equals: 15.
	"No possible path between 0 and 8"
	self assert: (longestPathAlgo findNode: 8) pathDistance equals: Float infinity negated.
	self assert: (longestPathAlgo findNode: 9) pathDistance equals: 200
]

{ #category : #tests }
AILongestPathInDCGTest >> testNegativeWeightedGraphReconstrucPath [

	|graphType graph |
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType negativeWeightedGraph.
	longestPathAlgo nodes: graph nodes.
	longestPathAlgo  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.

	longestPathAlgo runFrom: 0 to: 8.
	self assertCollection: longestPathAlgo reconstructPath asArray equals: #( 0 1 5 8).

	longestPathAlgo reset.
	longestPathAlgo runFrom: 0 to: 7.
	self assertCollection: longestPathAlgo reconstructPath asArray equals: #( 0 1 6 7 )
]
