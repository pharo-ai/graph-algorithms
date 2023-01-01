"
The triangular lattice graph is a two-dimensional grid graph in which each square unit has a diagonal edge (each grid unit has a chord).

- n: integer - number of rows in the lattice
- m: integer - number of columns int the lattice

The returned graph has m rows and n columns of triangles. Rows and columns include both triangles pointing up and down. Rows form a strip of constant height. Columns form a series of diamond shapes, staggered with the columns on either side. Another way to state the size is that the nodes form a grid of m+1 rows and (n + 1) // 2 columns. The odd row nodes are shifted horizontally relative to the even rows.
"
Class {
	#name : #AITriangularLatticeGenerator,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'n',
		'm',
		'activeNodes'
	],
	#category : #'AI-Algorithms-Graph-Generators'
}

{ #category : #accessing }
AITriangularLatticeGenerator >> activeNodes [
	^ activeNodes
]

{ #category : #accessing }
AITriangularLatticeGenerator >> activeNodes: anObject [
	activeNodes := anObject
]

{ #category : #running }
AITriangularLatticeGenerator >> buildLinks [
	"Connect each nodes to nodes that are in 2 steps "

	nodes
		do: [ :each |
			| links lineLinks|
			"Build chord between nodes situated on diffenents lines"
			(each x \\ 2 = 1 and: [ each y \\ 2 = 1 ])
				ifTrue: [ links := self nodesAtDistance: 2 toNode: each.
					links
						do: [ :node |
							self
								addEdge:
									{each model.
									node model}
								from: #first
								to: #second ] ].
			"Build chord between nodes on the same line"
			(each x + each y) \\ 2 = 0
				ifTrue: [ lineLinks := self nodesOnLineAtDistance: 2 toNode: each.
					lineLinks
						do: [ :node |
							self
								addEdge:
									{each model.
									node model}
								from: #first
								to: #second ] ] ]
]

{ #category : #configuration }
AITriangularLatticeGenerator >> edgeClass [
	^ AIGraphEdge
]

{ #category : #initialization }
AITriangularLatticeGenerator >> initializeNodesOnGrid [
	| nbNodes |
	nbNodes := 1.
	nodes
		do: [ :each |
			each x: (nbNodes - 1) \\ n + 1.
			each y: (nbNodes - 1 quo: n) + 1.
			nbNodes := nbNodes + 1 ]
]

{ #category : #accessing }
AITriangularLatticeGenerator >> m [
	^m
]

{ #category : #accessing }
AITriangularLatticeGenerator >> m: anInteger [
	m := anInteger
]

{ #category : #accessing }
AITriangularLatticeGenerator >> n [
	^n
]

{ #category : #accessing }
AITriangularLatticeGenerator >> n: anInteger [
	n := anInteger
]

{ #category : #configuration }
AITriangularLatticeGenerator >> nodeClass [
	^ AI2DGridNode
]

{ #category : #running }
AITriangularLatticeGenerator >> nodesAtDistance: aDistance toNode: aNode [
	"Return nodes that are at the distance p to a node"

	| i j k l |
	i := aNode x.
	j := aNode y.
	^ nodes
		select: [ :each |
			k := each x.
			l := each y.
			((k - i) raisedTo:2) + ((l - j) raisedTo:2) = aDistance ]
]

{ #category : #running }
AITriangularLatticeGenerator >> nodesOnLineAtDistance: aDistance toNode: aNode [
	"Return nodes that are at the distance p to a node"

	| i j k l |
	i := aNode x.
	j := aNode y.
	^ nodes
		select: [ :each |
			k := each x.
			l := each y.
			l = j and: [ k - i = aDistance ] ]
]

{ #category : #removing }
AITriangularLatticeGenerator >> removeUnnecessaryNodes [
	| listeActiveNodes |
	listeActiveNodes := OrderedCollection new.
	nodes
		do: [ :each |
			(each x + each y) \\ 2 = 0
				ifTrue: [ listeActiveNodes add: each ] ].
	 self activeNodes:listeActiveNodes
]

{ #category : #running }
AITriangularLatticeGenerator >> run [
	self nodes: (1 to: n * m).
	self initializeNodesOnGrid.
	self buildLinks.
	self removeUnnecessaryNodes
]
