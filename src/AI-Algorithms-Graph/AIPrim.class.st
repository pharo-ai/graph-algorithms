"
Prim's algorithm (also known as Jarník's algorithm) is a greedy algorithm that finds a minimum spanning tree for a weighted undirected graph. This means it finds a subset of the edges that forms a tree that includes every vertex, where the total weight of all the edges in the tree is minimized. The algorithm operates by building this tree one vertex at a time, from an arbitrary starting vertex, at each step adding the cheapest possible connection from the tree to another vertex.

For more, see: https://en.wikipedia.org/wiki/Prim%27s_algorithm
"
Class {
	#name : 'AIPrim',
	#superclass : 'AIGraphAlgorithm',
	#category : 'AI-Algorithms-Graph-Prim',
	#package : 'AI-Algorithms-Graph',
	#tag : 'Prim'
}

{ #category : 'configuration' }
AIPrim >> edgeClass [

	^ AIWeightedEdge
]

{ #category : 'initialization' }
AIPrim >> initialize [

	super initialize
]

{ #category : 'accessing' }
AIPrim >> minNode [

	| lowNode lowKey |
	lowKey := Float infinity.
	nodes do: [ :each |
		each distance < lowKey & each visited not ifTrue: [
			lowKey := each distance.
			lowNode := each ] ].
	^ lowNode
]

{ #category : 'configuration' }
AIPrim >> nodeClass [

	^ AIBFSNode
]

{ #category : 'running' }
AIPrim >> run [

	| curNode curEdge treeEdges fromNode toNode primEdge |
	nodes do: [ :each | each distance: Float infinity ].

	treeEdges := OrderedCollection new.

	nodes first
		distance: 0;
		previousNode: nil.

	nodes size timesRepeat: [
		curNode := self minNode.
		curNode visited: true.
		curNode previousNode ifNotNil: [
			primEdge := {
				            curNode previousNode model.
				            curNode model.
				            curNode distance }.
			treeEdges add: (self findEdge: primEdge) ].

		edges do: [ :edge |
			curEdge := edge asTuple.
			fromNode := self findNode: curEdge first.
			toNode := self findNode: curEdge second.
			fromNode == curNode & (curEdge third < toNode distance)
			& toNode visited not ifTrue: [
				toNode previousNode: curNode.
				toNode distance: curEdge third ] ] ].

	^ treeEdges
]
