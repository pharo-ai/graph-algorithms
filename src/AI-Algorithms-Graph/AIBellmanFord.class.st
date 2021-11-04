Class {
	#name : #AIBellmanFord,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start',
		'end'
	],
	#category : #'AI-Algorithms-Graph-Shortest path'
}

{ #category : #configuration }
AIBellmanFord >> edgeClass [

	^ AIWeightedEdge
]

{ #category : #configuration }
AIBellmanFord >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : #running }
AIBellmanFord >> relaxEdges [

	| anEdgeHasBeenRelaxed |
	"Relax the edges V-1 times at worst case"
	nodes size - 1 timesRepeat: [ 
		anEdgeHasBeenRelaxed := false.

		edges do: [ :edge | 
			edge from pathDistance + edge weight < edge to pathDistance ifTrue: [ 
				edge to pathDistance: edge from pathDistance + edge weight.
				anEdgeHasBeenRelaxed := true ] ].

		"If no edge has been relaxed means that we can stop the iteration before V-1 times"
		anEdgeHasBeenRelaxed ifFalse: [ ^ self ] ]
]

{ #category : #running }
AIBellmanFord >> relaxEdgesToNegativeInfinity [

	"This method is called after a first relaxation has ocurred already. The algorithm is the same as the previous one but with the only difference that now if an edge can be relaxed we set the path distance as negative infinity because means that the edge is part of a negative cycle."
	
	| anEdgeHasBeenRelaxed |
	"Relax the edges V-1 times at worst case"
	nodes size - 1 timesRepeat: [ 
		anEdgeHasBeenRelaxed := false.

		edges do: [ :edge | 
			edge from pathDistance + edge weight < edge to pathDistance ifTrue: [ 
				edge to pathDistance: Float negativeInfinity.
				anEdgeHasBeenRelaxed := true ] ].

		"If no edge has been relaxed means that we can stop the iteration before V-1 times"
		anEdgeHasBeenRelaxed ifFalse: [ ^ self ] ]
]

{ #category : #running }
AIBellmanFord >> run [

	start pathDistance: 0.
	self relaxEdges.
	"Run the algorithm another time to detect if any negative cycles exist.
	The only variation now is that if we can relax another time an edge, then means that we are part of a negative cycle. So, we put negative infinity as the path distance"
	self relaxEdgesToNegativeInfinity
]

{ #category : #accessing }
AIBellmanFord >> start: aModel [

	start := (self findNode: aModel)
]
