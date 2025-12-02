"
Depth-First-Search (DFS) is an algorithm for traversing or searching tree or graph data structures. The algorithm starts at the root node (selecting some arbitrary node as the root node in the case of a graph) and explores as far as possible along each branch before backtracking.

The `stack` instance variable uses a LinkedList. This is because the linked list has constant access times. The `addlast`, `addFirst`, `removeFirst` & `removeLast` takes a constant time to operate.

See my test class examples of how to use me, but in a nutshell:
```
dfs := AIDFS new
            nodes: #( 1 2 3 4);
            edges: { (1 -> 4) . (1 -> 2) . (2 -> 3) . (3 -> 4)} from: #key to: #value;
            yourself.
path := dfs runFrom: 1 to: 4
```
This will return `#( 1 4 )`.
"
Class {
	#name : 'AIDFS',
	#superclass : 'AIGraphAlgorithm',
	#instVars : [
		'start',
		'end'
	],
	#category : 'AI-Algorithms-Graph-Shortest path',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Shortest path'
}

{ #category : 'accessing' }
AIDFS >> end [

	^ end
]

{ #category : 'accessing' }
AIDFS >> end: endModel [

	end := self findNode: endModel
]

{ #category : 'configuration' }
AIDFS >> nodeClass [

	^ AIDFSNode
]

{ #category : 'actions' }
AIDFS >> reconstructPath [

	| path previous |
	end previousNode ifNil: [ "If start and end are the same, return a path with just the start node"
		start = end ifTrue: [ ^ { start model } ].
		^ #(  ) "Otherwise, return an empty list" ].

	path := LinkedList empty.
	previous := end.
	path addFirst: end model.

	[ previous = start ] whileFalse: [
		previous := previous previousNode.
		path addFirst: previous model ].

	^ path
]

{ #category : 'actions' }
AIDFS >> resetValues [

	nodes do: [ :aNode |
		aNode
			visited: false;
			previousNode: nil
			
			]
]

{ #category : 'running' }
AIDFS >> run [

	| node unvisitedNeighbor stack |
	self resetValues.

	stack := LinkedList new.
	start visited: true.
	stack addLast: start.

	[ stack isNotEmpty ] whileTrue: [
		node := stack last.
		unvisitedNeighbor := node adjacentNodes
			                     detect: [ :next | next visited not ]
			                     ifNone: [ nil ].

		unvisitedNeighbor
			ifNotNil: [ "Process unvisited neighbor"
				unvisitedNeighbor visited: true.
				unvisitedNeighbor previousNode: node.
				stack addLast: unvisitedNeighbor ]
			ifNil: [ "Backtrack when no more unvisited neighbors"
				stack removeLast. ] ]
]

{ #category : 'running' }
AIDFS >> runFrom: startModel [

	self start: startModel.
	self run
]

{ #category : 'running' }
AIDFS >> runFrom: startModel to: endModel [

	self
		start: startModel;
		end: endModel.
	self run.
	^ self reconstructPath
]

{ #category : 'accessing' }
AIDFS >> start [

	^ start
]

{ #category : 'accessing' }
AIDFS >> start: startModel [

	start := self findNode: startModel
]
