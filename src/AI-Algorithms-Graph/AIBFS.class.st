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

{ #category : #accessing }
AIBFS >> end [

	^ end
]

{ #category : #accessing }
AIBFS >> end: aBFSNode [

	end := aBFSNode
]

{ #category : #configuration }
AIBFS >> nodeClass [

	^ AIBFSNode
]

{ #category : #actions }
AIBFS >> reconstructPath [

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

{ #category : #actions }
AIBFS >> resetValues [

	nodes do: [ :aNode | 
		aNode
			visited: false;
			previousNode: nil ]
]

{ #category : #running }
AIBFS >> run [

	| node neighbours |
	self resetValues.

	queue := LinkedList with: start.
	start visited: true.

	[ queue isNotEmpty ] whileTrue: [ 
		node := queue removeFirst.
		neighbours := node nextNodes.

		neighbours do: [ :next | 
			next visited ifFalse: [ 
				queue addLast: next.
				next visited: true.
				next previousNode: node ] ] ].
	^ self reconstructPath
]

{ #category : #running }
AIBFS >> runFrom: startModel to: endModel [

	self
		start: (self findNode: startModel);
		end: (self findNode: endModel).
	^ self run
]

{ #category : #accessing }
AIBFS >> start [

	^ start
]

{ #category : #accessing }
AIBFS >> start: aBFSNode [

	start := aBFSNode
]
