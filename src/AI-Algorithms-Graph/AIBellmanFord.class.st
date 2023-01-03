"
The Bellman Ford algorithm calculates the shortest path in any kind of graph. The graph edges can have negative weights and this algo hanldes negative cycles. If a negative cycle is detected, the path distance of that node is set to negative infinity
"
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

{ #category : #accessing }
AIBellmanFord >> end: aModel [

	end := (self findNode: aModel)
]

{ #category : #configuration }
AIBellmanFord >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : #actions }
AIBellmanFord >> reconstructPath [

	| path previous |
	"If no path exists between the start and the end node"
	end pathDistance = Float infinity ifTrue: [ ^ #(  ) ].
	"If the end node is part of a negative cycle"
	end pathDistance = Float negativeInfinity ifTrue: [ ^ #(  ) ].

	path := LinkedList empty.
	previous := end.
	path addFirst: end model.
	[ previous = start ] whileFalse: [
		previous := previous previousNode.
		path addFirst: previous model ].
	^ path
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
				edge to previousNode: edge from.
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

{ #category : #actions }
AIBellmanFord >> reset [

	self nodes do: [ :node |
		node
			pathDistance: Float infinity;
			previousNode: nil ]
]

{ #category : #running }
AIBellmanFord >> run [

	start pathDistance: 0.
	self relaxEdges.
	"Run the algorithm one more time to detect if there is any negative cycles.
	The variation is if we can relax one more time an edge,
	means that the edge is part of a negative cycle.
	So, we put negative infinity as the path distance"
	self relaxEdgesToNegativeInfinity
]

{ #category : #running }
AIBellmanFord >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : #running }
AIBellmanFord >> runFrom: startModel to: endModel [

	self runFrom: startModel.
	self end: endModel.
	^ self reconstructPath
]

{ #category : #accessing }
AIBellmanFord >> start: aModel [

	start := (self findNode: aModel).
	start pathDistance: 0
]
