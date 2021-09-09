"
I am Kahn's Algorithm for topological sorting. I do the toplogical sorting in linear time O(V + E). I also detect and raise an error if the graph has any cycles. Because topological sorting is only possible if the graph is a Directed Acyclic Graph (DAG).

From Wikipedia:
A topological sort or topological ordering of a directed graph is a linear ordering of its vertices such that for every directed edge uv from vertex u to vertex v, u comes before v in the ordering. For instance, the vertices of the graph may represent tasks to be performed, and the edges may represent constraints that one task must be performed before another; in this application, a topological ordering is just a valid sequence for the tasks. A topological ordering is possible if and only if the graph has no directed cycles, that is, if it is a directed acyclic graph (DAG).
"
Class {
	#name : #AITopologicalSorting,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'topologicalSortedElements',
		'nodesWithNoIncomingEdges'
	],
	#category : #'AI-Algorithms-Graph-Topological Sorting'
}

{ #category : #private }
AITopologicalSorting >> graphHasEdges [

	^ nodes anySatisfy: [ :node | node adjacentNodes isNotEmpty ]
]

{ #category : #configuration }
AITopologicalSorting >> nodeClass [

	^ AINodeWithNextAndPrevious
]

{ #category : #private }
AITopologicalSorting >> removeEdgesOf: aNode [

	aNode adjacentNodes do: [ :node | 
		node incomingNodes remove: aNode.
		node incomingNodes ifEmpty: [ nodesWithNoIncomingEdges add: node ] ].
	aNode adjacentNodes: #(  )
]

{ #category : #running }
AITopologicalSorting >> run [

	topologicalSortedElements := OrderedCollection empty.
	"nodesWithNoIncomingEdge is a queue"
	nodesWithNoIncomingEdges := OrderedCollection empty.
	nodesWithNoIncomingEdges addAll:
		(nodes select: [ :node | node incomingNodes isEmpty ]).
	[ nodesWithNoIncomingEdges isNotEmpty ] whileTrue: [ 
		| node |
		node := nodesWithNoIncomingEdges removeFirst.
		topologicalSortedElements addLast: node model.
		self removeEdgesOf: node ].
	self graphHasEdges ifTrue: [ 
		Error signal: 'Not a DAG (Directed Acyclic Graph)' ].
	"Return the topological order the first element being the node without any dependencies"
	^ topologicalSortedElements
]

{ #category : #accessing }
AITopologicalSorting >> topologicalSortedElements [

	^ topologicalSortedElements
]
