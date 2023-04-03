"
Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph, which may represent, for example, road networks. It was conceived by computer scientist Edsger W. Dijkstra in 1956 and published in 1959. The algorithm exists in many variants; Dijkstra's original variant found the shortest path between two nodes, but a more common variant fixes a single node as the ""source"" node and finds shortest paths from the source to all other nodes in the graph, producing a shortest path tree. (source: Wikipedia).


The current implementation of this algo is the naive one. To improve it, Implement the data structure ""priority queue"" is needed. That is the key to improve the time complexity. Now, the priority queue is implemented as a list and the method `removeMostPromisingPair:` does a iteration to the list O(N) to retrieve the most promising pair. We can implement the priority queue as heap for example.
"
Class {
	#name : #AIDijkstra,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start',
		'end'
	],
	#category : #'AI-Algorithms-Graph-Shortest path'
}

{ #category : #configuration }
AIDijkstra >> edgeClass [

	^ AIWeightedEdge
]

{ #category : #accessing }
AIDijkstra >> end [

	^ end
]

{ #category : #accessing }
AIDijkstra >> end: endModel [

	end := (self findNode: endModel)
]

{ #category : #actions }
AIDijkstra >> newPriorityQueue [

	"This is the naive implementation of the data structure."

	^ OrderedCollection new
]

{ #category : #configuration }
AIDijkstra >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : #running }
AIDijkstra >> pathDistance [

	^ self end pathDistance
]

{ #category : #backtracking }
AIDijkstra >> reconstructPath [

	| path previous |
	"If no path exists between the start and the end node"
	end pathDistance = Float infinity ifTrue: [ ^ #(  ) ].
	path := LinkedList empty.
	previous := end.
	path addFirst: end model.
	[ previous = start ] whileFalse: [
		previous := previous previousNode.
		path addFirst: previous model ].
	^ path
]

{ #category : #actions }
AIDijkstra >> removeMostPromisingPair: aPriorityQueue [

	"This is the naive implementation of the data structure."

	| minValue |
	minValue := aPriorityQueue detectMin: [ :assoc | assoc value ].
	^ aPriorityQueue remove: minValue
]

{ #category : #initialization }
AIDijkstra >> reset [

	self nodes do: [ :node |
		node
			pathDistance: Float infinity;
			visited: false;
			previousNode: nil ]
]

{ #category : #running }
AIDijkstra >> run [

	| pq |
	pq := self newPriorityQueue.
	pq add: start -> 0.

	[ pq isNotEmpty ] whileTrue: [
		| assoc node minWeight |
		assoc := self removeMostPromisingPair: pq.
		node := assoc key.
		minWeight := assoc value.
		node visited: true.

		"Skip if the path weight is less than the one obtained from the pq.
		This is an optimization for not processing unnecessary nodes."
		node pathDistance < minWeight ifFalse: [
			node outgoingEdges do: [ :edge |
				edge to visited ifFalse: [
					| newDistance |
					newDistance := node pathDistance + edge weight.

					newDistance < edge to pathDistance ifTrue: [
						self updateDistance: newDistance of: edge to previousNode: node.
						pq add: edge to -> newDistance ] ] ] ] ]
]

{ #category : #running }
AIDijkstra >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : #running }
AIDijkstra >> runFrom: startModel to: endModel [

	self runFrom: startModel.
	self end: endModel.
	^ self reconstructPath
]

{ #category : #accessing }
AIDijkstra >> start [

	^ start
]

{ #category : #accessing }
AIDijkstra >> start: startModel [

	start := (self findNode: startModel).
	start pathDistance: 0
]

{ #category : #private }
AIDijkstra >> updateDistance: newDistance of: aNode previousNode: previousNode [

	aNode previousNode: previousNode.
	aNode pathDistance: newDistance
]
