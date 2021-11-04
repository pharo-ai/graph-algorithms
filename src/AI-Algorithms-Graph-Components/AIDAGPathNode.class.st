"
I am a node that is used in the shortest path algorithm for DAG (Directed Acyclic Graph)
"
Class {
	#name : #AIDAGPathNode,
	#superclass : #AIPathDistanceNode,
	#instVars : [
		'adjacentNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIDAGPathNode >> adjacentNodes [
	^ adjacentNodes
]

{ #category : #initialization }
AIDAGPathNode >> initialize [

	super initialize.
	adjacentNodes := OrderedCollection new
]

{ #category : #accessing }
AIDAGPathNode >> to: aNode edge: anEdge [

	adjacentNodes add: aNode.
	outgoingEdges add: anEdge
]
