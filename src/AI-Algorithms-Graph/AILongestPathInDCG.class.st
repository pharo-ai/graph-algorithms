"
A variation of Bellman Ford algorithm that calculates the longest path in any kind of graph (including Directed Cyclic Graphs (DCG)). The graph edges can have negative weights and this algo hanldes negative cycles. If a negative cycle is detected, the path distance of that node is set to negative infinity.
"
Class {
	#name : 'AILongestPathInDCG',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'start',
		'end'
	],
	#category : 'AI-Algorithms-Graph-Shortest path',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Shortest path'
}

{ #category : 'configuration' }
AILongestPathInDCG >> edgeClass [

	^ AIWeightedEdge
]

{ #category : 'accessing' }
AILongestPathInDCG >> end: aModel [

	end := (self findNode: aModel)
]

{ #category : 'configuration' }
AILongestPathInDCG >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : 'actions' }
AILongestPathInDCG >> pathPositive [

	self nodes do: [ :node | node pathDistance: -1 * node pathDistance ]
]

{ #category : 'actions' }
AILongestPathInDCG >> reconstructPath [

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

{ #category : 'running' }
AILongestPathInDCG >> relaxEdges [

	| anEdgeHasBeenRelaxed |
	"Relax the edges V-1 times at worst case"
	nodes size - 1 timesRepeat: [
		anEdgeHasBeenRelaxed := false.

		edges do: [ :edge |
			edge from pathDistance + (-1 * edge weight) < edge to pathDistance ifTrue: [
				edge to pathDistance: edge from pathDistance + (-1 * edge weight).
				edge to previousNode: edge from.
				anEdgeHasBeenRelaxed := true ] ].

		"If no edge has been relaxed means that we can stop the iteration before V-1 times"
		anEdgeHasBeenRelaxed ifFalse: [ ^ self ] ]
]

{ #category : 'running' }
AILongestPathInDCG >> relaxEdgesToNegativeInfinity [
	"This method is called after a first relaxation has ocurred already. The algorithm is the
	same as the previous one but with the only difference that now if an edge can be relaxed
	we set the path distance as negative infinity because means that the edge is part of a
	negative cycle."

	| anEdgeHasBeenRelaxed |
	"Relax the edges V-1 times at worst case"
	nodes size - 1 timesRepeat: [
		anEdgeHasBeenRelaxed := false.

		edges do: [ :edge |
			edge from pathDistance + (-1 * edge weight) < edge to pathDistance ifTrue: [
				edge to pathDistance: Float negativeInfinity.
				anEdgeHasBeenRelaxed := true ] ].

		"If no edge has been relaxed means that we can stop the iteration before V-1 times"
		anEdgeHasBeenRelaxed ifFalse: [ ^ self ] ]
]

{ #category : 'actions' }
AILongestPathInDCG >> reset [

	self nodes do: [ :node |
		node
			pathDistance: Float infinity;
			previousNode: nil ]
]

{ #category : 'running' }
AILongestPathInDCG >> run [

	self reset.
	start pathDistance: 0.
	self relaxEdges.
	"Run the algorithm one more time to detect if there is any negative cycles.
	The variation is if we can relax one more time an edge,
	means that the edge is part of a negative cycle.
	So, we put negative infinity as the path distance"
	self relaxEdgesToNegativeInfinity.
	self pathPositive
]

{ #category : 'running' }
AILongestPathInDCG >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : 'running' }
AILongestPathInDCG >> runFrom: startModel to: endModel [

	self runFrom: startModel.
	self end: endModel.
	^ self reconstructPath
]

{ #category : 'accessing' }
AILongestPathInDCG >> start: aModel [

	start := self findNode: aModel.
	start pathDistance: 0
]
