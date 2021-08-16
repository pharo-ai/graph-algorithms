"
Breadth-first search (BFS) is an algorithm for traversing or searching tree or graph data structures. It starts at the tree root (or some arbitrary node of a graph, sometimes referred to as a `search key') and explores the neighbor nodes first, before moving to the next level neighbours. (source: Wikipedia)

The `queue` instance variable uses a LinkedList. This is because the linked list has constant access times. The `removeFist`, `#add:`, `#addLast:` takes a constant time to operate.
"
Class {
	#name : #AIBFS,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start',
		'end',
		'queue'
	],
	#category : #'AI-Algorithms-Graph-BFS'
}

{ #category : #configuration }
AIBFS >> edgeClass [

	^ MalGraphEdge 
]

{ #category : #private }
AIBFS >> end [

	^ end
]

{ #category : #private }
AIBFS >> end: aDijsktraNode [

	end := aDijsktraNode
]

{ #category : #configuration }
AIBFS >> nodeClass [

	^ BFSNode
]

{ #category : #running }
AIBFS >> run [

	| path |
	queue := LinkedList withAll: start nextEdges.
	start firstDepth: 0.
	path := self run: 1.
	start notVisited.
	^ path
]

{ #category : #running }
AIBFS >> run: depth [
	| edge path next |
	edge := queue removeFirst.
	next := edge to.
	^ next = end
		ifTrue: [ OrderedCollection with: edge from model with: end model ]
		ifFalse:[
			next visited ifFalse:[ 
				"only add edges if node not already visited (avoid cycles on the path)"
				queue addAll: next nextEdges.
				next firstDepth: depth ].
			"continue recursion"
			path := self run: depth + 1.
			depth = next firstDepth ifTrue: [
				"out of stack"
				path first = next model ifTrue: [ 
					"backtrack along the path"
					path addFirst: edge from model ].
				"reset visited for next run"
				next notVisited ].
			"stop recursion, start backtrack"
			path ]
]

{ #category : #running }
AIBFS >> runFrom: startModel to: endModel [

	self
		start: (self findNode: startModel);
		end: (self findNode: endModel).
	^ self run
]

{ #category : #private }
AIBFS >> start [

	^ start
]

{ #category : #private }
AIBFS >> start: aDijsktraNode [

	start := aDijsktraNode
]
