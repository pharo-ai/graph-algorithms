"
A* is a graph traversal and path search algorithm, which is used in many fields of computer science due to its completeness, optimality, and optimal efficiency. One major practical drawback is its O(b^d) space complexity, as it stores all generated nodes in memory. Thus, in practical travel-routing systems, it is generally outperformed by algorithms that can pre-process the graph to attain better performance, as well as memory-bounded approaches; however, A* is still the best solution in many cases. (source: Wikipedia)

Pseudocode and implementation for the approach is taken from: https://github.com/tatut/aoc2021-smalltalk/blob/main/src/AoC2021/AStar.class.st 
"
Class {
	#name : 'AIAstar',
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
AIAstar >> edgeClass [

	^ AIWeightedEdge
]

{ #category : 'accessing' }
AIAstar >> end [

	^ end
]

{ #category : 'accessing' }
AIAstar >> end: endModel [

	end := self findNode: endModel
]

{ #category : 'running' }
AIAstar >> heuristicFrom: startModel to: endModel [
	"We are using a version of dijkstra algorithm here with all weights the for every node
	(value 1).
	So it has the same time complexity as BFS and takes into account the number of nodes in 
	between intermediate and goal as a heuristic function. Edge weight can be increased to add
	more weight to heuristic part of Astar."

	| dijkstra addEdges pathD use |
	addEdges := OrderedCollection new.

	edges do: [ :edge |
		| efrom eto eval array |
		efrom := edge from model.
		eto := edge to model.
		eval := edge weight.
		array := OrderedCollection new.
		array add: efrom.
		array add: eto.
		array add: eval.
		addEdges add: array asArray
		"Transcript show: array;cr." ].
	addEdges := addEdges asArray.



	end ifNil: [ ^ 0 ].
	endModel ifNil: [ ^ 0 ].

	dijkstra := AIDijkstra new.
	dijkstra nodes: (nodes first model to: nodes last model).
	dijkstra edges: addEdges
		from: [ :each | each first ]
		to: [ :each | each second ]
		weight: [ :each | each third ].

	use := OrderedCollection new.
	use add: startModel model.
	use add: endModel model.
	dijkstra start: use first.
	dijkstra end: use second.
	dijkstra run.
	pathD := (dijkstra findNode: endModel model) pathDistance.

	^ pathD
]

{ #category : 'actions' }
AIAstar >> newPriorityQueue [
	"We use the Heap object defined in the SequenceableCollections package."

	^ Heap new
]

{ #category : 'configuration' }
AIAstar >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : 'running' }
AIAstar >> pathDistance [
	"Needs to be editted"

	^ self end pathDistance
]

{ #category : 'backtracking' }
AIAstar >> reconstructPath [

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

{ #category : 'actions' }
AIAstar >> removeMostPromisingPair: aPriorityQueue [

	^ aPriorityQueue removeFirst
]

{ #category : 'initialization' }
AIAstar >> reset [

	self nodes do: [ :node |
		node
			pathDistance: Float infinity;
			visited: false;
			previousNode: nil ]
]

{ #category : 'running' }
AIAstar >> run [

	| pq cameFrom gScore fScore gs fs |
	
	cameFrom := Dictionary new.
	gScore := Dictionary new.
	gScore at: start put: 0.
	fScore := Dictionary new.
	fScore at: start put: (self heuristicFrom: start to: end).
	
	gs := [ :p | gScore at: p ifAbsent: Float infinity ].
	fs := [ :p | fScore at: p ifAbsent: Float infinity ].
	
	pq := SortedCollection sortUsing: [ :a :b | (fs value: a) < (fs value: b) ].
	pq add: start.
	
	[ pq isEmpty ] whileFalse: [ 
		| current |
		current := pq removeFirst.
		
		current = end 
			ifTrue: [
				| path prev |
				path := OrderedCollection with: current.
			   prev := cameFrom at: current ifAbsent: nil.
			   [ prev isNotNil ] whileTrue: [ 
					path addFirst: prev.
					prev := cameFrom at: prev ifAbsent: nil.
				].
      			"^ path."
      			 ]
			ifFalse: [ 
				current outgoingEdges do: [ :edge |
					| tentative_gScore |
					tentative_gScore := (gs value: current) + (edge weight).
					tentative_gScore < (gs value: (edge to))
						ifTrue: [ 
							"This path to neighbor is better than any previous one. Record it!"
							self updateDistance: tentative_gScore of: edge to previousNode: current.
		                cameFrom at: (edge to) put: current.
		                gScore at: (edge to) put: tentative_gScore.
		                fScore at: (edge to) put: tentative_gScore + (self heuristicFrom: (edge to) to: end).
		                (pq includes: (edge to)) ifFalse: [ pq add: (edge to) ].
						] 
				].
			].
	]
]

{ #category : 'running' }
AIAstar >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : 'running' }
AIAstar >> runFrom: startModel to: endModel [

	self start: startModel.
	self end: endModel.
	^ self run
]

{ #category : 'accessing' }
AIAstar >> start [

	^ start
]

{ #category : 'accessing' }
AIAstar >> start: startModel [

	start := self findNode: startModel.
	start pathDistance: 0
]

{ #category : 'private' }
AIAstar >> updateDistance: newDistance of: aNode previousNode: previousNode [

	aNode previousNode: previousNode.
	aNode pathDistance: newDistance
]
