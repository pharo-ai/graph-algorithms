"
Breadth-first search (BFS) is an algorithm for traversing or searching tree or graph data structures. It starts at the tree root (or some arbitrary node of a graph, sometimes referred to as a `search key') and explores the neighbor nodes first, before moving to the next level neighbours. (source: Wikipedia)

The `queue` instance variable uses a LinkedList. This is because the linked list has constant access times. The `removeFist`, `#add:`, `#addLast:` takes a constant time to operate.

See my test class examples of how to use me, but in a nutshell:
```
bfs := AIBFS new
			nodes: #( 1 2 3 4);
			edges: { (1 -> 4) . (1 -> 2) . (2 -> 3) . (3 -> 4)} from: #key to: #value;
			yourself.
shortestPath := bfs runFrom: 1 to: 4
```
This will return `#( 1 4 )`.
"
Class {
	#name : #AIBFS,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start',
		'end',
		'queue'
	],
	#category : #'AI-Algorithms-Graph-Shortest path'
}

{ #category : #accessing }
AIBFS >> end [

	^ end
]

{ #category : #accessing }
AIBFS >> end: endModel [

	end := self findNode: endModel
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
			previousNode: nil;
			distance: nil ]
]

{ #category : #running }
AIBFS >> run [

	| node neighbours |
	self resetValues.

	queue := LinkedList with: start.
	start visited: true.
	start distance: 0.

	[ queue isNotEmpty ] whileTrue: [
		node := queue removeFirst.
		neighbours := node adjacentNodes.

		neighbours do: [ :next |
			next visited ifFalse: [
				queue addLast: next.
				next visited: true.
				next distance: node distance + 1.
				next previousNode: node ] ] ]
]

{ #category : #running }
AIBFS >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : #running }
AIBFS >> runFrom: startModel to: endModel [

	self runFrom: startModel.
	self end: endModel.
	^ self reconstructPath
]

{ #category : #accessing }
AIBFS >> start [

	^ start
]

{ #category : #accessing }
AIBFS >> start: startModel [

	start := self findNode: startModel
]
