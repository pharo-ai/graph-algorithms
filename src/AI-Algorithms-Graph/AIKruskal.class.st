"
Kruskal's algorithm is a greedy algorithm in graph theory that finds a minimum spanning tree for a connected weighted graph. This means it finds a subset of the edges that forms a tree that includes every vertex, where the total weight of all the edges in the tree is minimized. If the graph is not connected, then it finds a minimum spanning forest (a minimum spanning tree for each connected component).

See https://en.wikipedia.org/wiki/Kruskal%27s_algorithm

For having the time complexity of O(E log E) this algorithm uses the disjoint-set data structure. See the node class of this algorithm for more information about that data structure. Uses the disjoint-set to check, in linear time, if a cycle will be formed when joining two edges.
"
Class {
	#name : #AIKruskal,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'sortBlock'
	],
	#category : #'AI-Algorithms-Graph-Kruskal'
}

{ #category : #configuration }
AIKruskal >> edgeClass [

	^ AIWeightedEdge
]

{ #category : #initialization }
AIKruskal >> initialize [

	super initialize.
	self minSpanningTree
]

{ #category : #configuration }
AIKruskal >> maxSpanningTree [

	sortBlock := [ :e1 :e2 | e1 weight > e2 weight ]
]

{ #category : #configuration }
AIKruskal >> minSpanningTree [

	sortBlock := [ :e1 :e2 | e1 weight < e2 weight ]
]

{ #category : #configuration }
AIKruskal >> nodeClass [

	^ AIDisjointSetNode
]

{ #category : #running }
AIKruskal >> run [

	| treeEdges sortedEdges |
	treeEdges := OrderedCollection new.
	nodes do: [ :each | each makeSet ].
	sortedEdges := edges asSortedCollection: sortBlock.
	sortedEdges
		reject: [ :edge | "Only join the two nodes if they don't belong to the same component"
			edge from find = edge to find ]
		thenDo: [ :edge |
			edge from union: edge to.
			treeEdges add: edge ].
	^ treeEdges
]
