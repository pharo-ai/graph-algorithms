"
Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph, which may represent, for example, road networks. It was conceived by computer scientist Edsger W. Dijkstra in 1956 and published in 1959. The algorithm exists in many variants; Dijkstra's original variant found the shortest path between two nodes, but a more common variant fixes a single node as the ""source"" node and finds shortest paths from the source to all other nodes in the graph, producing a shortest path tree. (source: Wikipedia).


This algorithm doesn't work properly is still Work in Progress
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

{ #category : #backtracking }
AIDijkstra >> backtrack [

	^ self backtrack: self end
]

{ #category : #backtracking }
AIDijkstra >> backtrack: b [

	| p |
	b pathWeight = Float infinity ifTrue: [ ^ #(  ) ]. "no solution"
	^ b = self start
		  ifTrue: [ OrderedCollection with: b model ]
		  ifFalse: [ 
			  p := b previousNodes detectMin: [ :n | n pathWeight ].
			  (self backtrack: p)
				  add: b model;
				  yourself ]
]

{ #category : #backtracking }
AIDijkstra >> backtrack: b edgeDo: aBlock [

	"special purpose backtracking for CSE: backtrack through edge and do something on each edge 
	while traversing.
	 do not check if there is a solution (pathWeight ~= Float infinity)"

	| pe p |
	^ b = self start
		  ifTrue: [ OrderedCollection with: b model ]
		  ifFalse: [ 
			  pe := b previousEdges detectMin: [ :e | e from pathWeight ].
			  p := pe from.
			  aBlock value: pe.
			  (self backtrack: p edgeDo: aBlock)
				  add: b model;
				  yourself ]
]

{ #category : #configuration }
AIDijkstra >> edgeClass [

	^ AIDijkstraEdge
]

{ #category : #private }
AIDijkstra >> end [

	^ end
]

{ #category : #private }
AIDijkstra >> end: aDijsktraNode [

	end := aDijsktraNode
]

{ #category : #configuration }
AIDijkstra >> nodeClass [

	^ AIDijkstraNode
]

{ #category : #running }
AIDijkstra >> pathWeight [

	^ self end pathWeight
]

{ #category : #initialization }
AIDijkstra >> reset [

	self nodes do: [ :n | n pathWeight: Float infinity ].
	self edges do: [ :e | e visited: false ]
]

{ #category : #running }
AIDijkstra >> run [

	self traverse: self start
]

{ #category : #running }
AIDijkstra >> runFrom: startModel to: endModel [

	self
		start: (self findNode: startModel);
		end: (self findNode: endModel).
	self run.
	^ self pathWeight
]

{ #category : #private }
AIDijkstra >> start [

	^ start
]

{ #category : #private }
AIDijkstra >> start: aDijsktraNode [

	start := aDijsktraNode.
	aDijsktraNode pathWeight: 0
]

{ #category : #running }
AIDijkstra >> traverse: node [

	node nextEdges do: [ :edge | 
		edge isVisited ifFalse: [ 
			edge to pathWeight:
				(edge to pathWeight min: node pathWeight + edge weight).
			edge visited: true.
			self traverse: edge to ] ]
]
