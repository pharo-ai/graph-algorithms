"
An AIBellmanFordTest is a test class for testing the behavior of AIBellmanFord
"
Class {
	#name : #AIBellmanFordTest,
	#superclass : #TestCase,
	#instVars : [
		'bellmanFord'
	],
	#category : #'AI-Algorithms-Graph-Tests-Shortest path'
}

{ #category : #running }
AIBellmanFordTest >> setUp [
	super setUp.
	bellmanFord := AIBellmanFord new
]

{ #category : #tests }
AIBellmanFordTest >> testNegativeUnconnectedWeightedGraph [

	AIGraphFixture negativeUnconnectedWeightedGraph: bellmanFord.

	bellmanFord start: 0.
	bellmanFord run.

	self assert: (bellmanFord findNode: 1) pathDistance equals: 5.
	self assert: (bellmanFord findNode: 2) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 3) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 4) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 5) pathDistance equals: 35.
	self assert: (bellmanFord findNode: 6) pathDistance equals: 40.
	self assert: (bellmanFord findNode: 7) pathDistance equals: -10.
	"No possible path between 0 and 8"
	self assert: (bellmanFord findNode: 8) pathDistance equals: Float infinity.
	self assert: (bellmanFord findNode: 9) pathDistance equals: Float negativeInfinity
]

{ #category : #tests }
AIBellmanFordTest >> testNegativeWeightedGraph [

	AIGraphFixture negativeWeightedGraph: bellmanFord.

	bellmanFord start: 0.
	bellmanFord run.

	self assert: (bellmanFord findNode: 1) pathDistance equals: 5.
	self assert: (bellmanFord findNode: 2) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 3) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 4) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 5) pathDistance equals: 35.
	self assert: (bellmanFord findNode: 6) pathDistance equals: 40.
	self assert: (bellmanFord findNode: 7) pathDistance equals: -10.
	self assert: (bellmanFord findNode: 8) pathDistance equals: -20.
	self assert: (bellmanFord findNode: 9) pathDistance equals: Float negativeInfinity
]

{ #category : #tests }
AIBellmanFordTest >> testNegativeWeightedGraph2 [

	AIGraphFixture negativeWeightedGraph2: bellmanFord.

	bellmanFord start: 0.
	bellmanFord run.

	self assert: (bellmanFord findNode: 1) pathDistance equals: 5.
	self assert: (bellmanFord findNode: 2) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 3) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 4) pathDistance equals: Float negativeInfinity.
	self assert: (bellmanFord findNode: 5) pathDistance equals: 35.
	self assert: (bellmanFord findNode: 6) pathDistance equals: 40.
	self assert: (bellmanFord findNode: 7) pathDistance equals: -10.
	"No possible path between 0 and 8"
	self assert: (bellmanFord findNode: 8) pathDistance equals: Float infinity.
	self assert: (bellmanFord findNode: 9) pathDistance equals: Float negativeInfinity
]

{ #category : #tests }
AIBellmanFordTest >> testNegativeWeightedGraphReconstrucPath [

	AIGraphFixture negativeWeightedGraph: bellmanFord.

	bellmanFord runFrom: 0 to: 8.
	self assertCollection: bellmanFord reconstructPath asArray equals: #( 0 1 5 6 7 8).

	bellmanFord reset.
	bellmanFord runFrom: 0 to: 7.
	self assertCollection: bellmanFord reconstructPath asArray equals: #( 0 1 5 6 7 )
]
