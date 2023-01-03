"
This algorithm works only in weighted DAG (Directed Acyclic graph). The algorithm is simple and it has a complexity of O(V + E). You have to define a start node. Then, for obtaining the shortest path from the start node to another node, you have to define an end node and the call the `AIShortestPathInDAG>>#reconstructPath` method. See the test class for more examples.

The algorithm is:

1) Initialize the initial distance to every node to be infinity and the distance of the start node to be 0.  
2) Create a topological order of all nodes. 
3) For every node u in topological order:
- Do following for every adjacent node v of u 
- IF (v pathWeight > u pathWeight + weight(u, v)) THEN v pathWeight: u pathWeight + weight(u, v) 
"
Class {
	#name : #AIShortestPathInDAG,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start',
		'end'
	],
	#category : #'AI-Algorithms-Graph-Shortest path'
}

{ #category : #configuration }
AIShortestPathInDAG >> edgeClass [

	^ AIWeightedEdge
]

{ #category : #accessing }
AIShortestPathInDAG >> end [

	^ end
]

{ #category : #accessing }
AIShortestPathInDAG >> end: aModel [

	end := self findNode: aModel
]

{ #category : #running }
AIShortestPathInDAG >> initializePathWeights [

	nodes do: [ :node | node pathDistance: Float infinity ].
	start pathDistance: 0
]

{ #category : #configuration }
AIShortestPathInDAG >> nodeClass [

	^ AIPathDistanceNode
]

{ #category : #running }
AIShortestPathInDAG >> reconstructPath [

	| path previous |
	"If no path exists between the start and the end node"
	end previousNode ifNil: [ ^ #(  ) ].
	path := LinkedList empty.
	previous := end.
	path addFirst: end model.
	[ previous = start ] whileFalse: [
		previous := previous previousNode.
		path addFirst: previous model ].
	^ path
]

{ #category : #running }
AIShortestPathInDAG >> run [

	| stack sortedNode |
	self initializePathWeights.
	stack := self topologicalSortedNodes.

	[ stack isNotEmpty ] whileTrue: [
		sortedNode := self findNode: stack removeFirst.

		sortedNode outgoingEdges do: [ :nextEdge |
			nextEdge to pathDistance > (sortedNode pathDistance + nextEdge weight)
				ifTrue: [ self updatePathDistance: nextEdge previousNode: sortedNode ] ] ]
]

{ #category : #running }
AIShortestPathInDAG >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : #running }
AIShortestPathInDAG >> runFrom: startModel to: endModel [

	self runFrom: startModel.
	self end: endModel.
	^ self reconstructPath
]

{ #category : #accessing }
AIShortestPathInDAG >> start [

	^ start
]

{ #category : #accessing }
AIShortestPathInDAG >> start: aModel [

	start := self findNode: aModel
]

{ #category : #running }
AIShortestPathInDAG >> topologicalSortedNodes [

	| topSorter  |
	topSorter := AITopologicalSorting new
		addNodesFromDifferentGraph: nodes;
		yourself.
	topSorter run.
	^ topSorter topologicalSortedElements
]

{ #category : #running }
AIShortestPathInDAG >> updatePathDistance: edge previousNode: previousNode [

	edge to pathDistance: previousNode pathDistance + edge weight.
	edge to previousNode: previousNode
]
