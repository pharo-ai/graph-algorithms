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

{ #category : #running }
AITopologicalSorting >> gatherNoIncomingNodes [

	nodesWithNoIncomingEdges addAll:
		(nodes select: [ :node | node isLeaf ])
]

{ #category : #private }
AITopologicalSorting >> graphHasEdges [

	^ nodes anySatisfy: [ :node | node adjacentNodes isNotEmpty ]
]

{ #category : #running }
AITopologicalSorting >> initializeElements [

	topologicalSortedElements := OrderedCollection new.
	"nodesWithNoIncomingEdge is a queue is a linked list because it has
	a better time complexity for removing the first element."
	nodesWithNoIncomingEdges := LinkedList new
]

{ #category : #configuration }
AITopologicalSorting >> nodeClass [

	^ AINodeWithPrevious
]

{ #category : #private }
AITopologicalSorting >> removeEdgesOf: aNode [

	aNode adjacentNodes do: [ :node |
		node incomingNodes remove: aNode.
		node isLeaf ifTrue: [ nodesWithNoIncomingEdges add: node ] ].
	aNode adjacentNodes: #(  )
]

{ #category : #running }
AITopologicalSorting >> run [

	self initializeElements.
	self gatherNoIncomingNodes.
	[ nodesWithNoIncomingEdges isNotEmpty ] whileTrue: [
		| node |
		node := nodesWithNoIncomingEdges removeFirst.
		topologicalSortedElements addLast: node model.
		self removeEdgesOf: node ].

	self graphHasEdges ifTrue: [
		Error signal: 'Not a DAG (Directed Acyclic Graph)' ].
	^ topologicalSortedElements
]

{ #category : #accessing }
AITopologicalSorting >> topologicalSortedElements [

	^ topologicalSortedElements
]
