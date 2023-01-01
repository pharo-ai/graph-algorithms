Class {
	#name : #AIHexagonalLatticeGenerator,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'n',
		'm',
		'activeNodes'
	],
	#category : #'AI-Algorithms-Graph-Generators'
}

{ #category : #accessing }
AIHexagonalLatticeGenerator >> activeNodes [
	^ activeNodes
]

{ #category : #accessing }
AIHexagonalLatticeGenerator >> activeNodes: anObject [
	activeNodes := anObject
]

{ #category : #running }
AIHexagonalLatticeGenerator >> buildLinks [
	"Connect each nodes to nodes that are in 2 steps "

	nodes
		do: [ :each |
			| links |
			"Build the top of hexagon"
			(each y \\ 4 = 1 and: [ each x \\ 2 = 1 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesAtDistance: 2 toNode: each.
					links
						do: [ :node |
							node y > each y
								ifTrue: [ self
										addEdge:
											{each model.
											node model}
										from: #first
										to: #second ] ] ].
			"Build the bottom of the hexagon"
			(each y \\ 4 = 3 and: [ each x \\ 2 = 0 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesAtDistance: 2 toNode: each.
					links
						do: [ :node |
							node y > each y
								ifTrue: [ self
										addEdge:
											{each model.
											node model}
										from: #first
										to: #second ] ] ].
			"Build the fisrt sides of the hexagon"
			(each y \\ 4 = 2 and: [ each x \\ 2 = 0 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesOnColumnAtDistance: 1 toNode: each.
					links
						do: [ :node |
							self
								addEdge:
									{each model.
									node model}
								from: #first
								to: #second ] ].
			"Build the other sides of the hexagon"
			(each y \\ 4 = 0 and: [ each x \\ 2 = 1 ])
				ifTrue: [ "and: [ each x \\ 2 = 1 ]"
					links := self nodesOnColumnAtDistance: 1 toNode: each.
					links
						do: [ :node |
							self
								addEdge:
									{each model.
									node model}
								from: #first
								to: #second ] ] ]
]

{ #category : #configuration }
AIHexagonalLatticeGenerator >> edgeClass [
	^ AIGraphEdge
]

{ #category : #initialization }
AIHexagonalLatticeGenerator >> initializeNodesOnGrid [
	| nbNodes |
	nbNodes := 1.
	nodes
		do: [ :each |
			each x: (nbNodes - 1) \\ n + 1.
			each y: (nbNodes - 1 quo: n) + 1.
			nbNodes := nbNodes + 1 ]
]

{ #category : #accessing }
AIHexagonalLatticeGenerator >> m [
^m
]

{ #category : #accessing }
AIHexagonalLatticeGenerator >> m: anInteger [
	m := anInteger
]

{ #category : #accessing }
AIHexagonalLatticeGenerator >> n [
	^n
]

{ #category : #accessing }
AIHexagonalLatticeGenerator >> n: anInteger [
	n := anInteger
]

{ #category : #configuration }
AIHexagonalLatticeGenerator >> nodeClass [
	^ AI2DGridNode
]

{ #category : #running }
AIHexagonalLatticeGenerator >> nodesAtDistance: aDistance toNode: aNode [
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
AIHexagonalLatticeGenerator >> nodesOnColumnAtDistance: aDistance toNode: aNode [
	"Return nodes that are at the distance p to a node"

	| i j k l |
	i := aNode x.
	j := aNode y.
	^ nodes
		select: [ :each |
			k := each x.
			l := each y.
			i = k and: [ l - j = aDistance ] ]
]

{ #category : #removing }
AIHexagonalLatticeGenerator >> removeUnnecessaryNodes [
	| listeActiveNodes |
	listeActiveNodes := OrderedCollection new.
	nodes
		do: [ :each |
			(each y \\ 4 = 0 and: [ each x \\ 2 = 1 ])
			ifTrue: [ listeActiveNodes add: each ].
			(each y \\ 4 = 1 and: [ each x \\ 2 = 1 ])
				ifTrue: [ listeActiveNodes add: each ].
			(each y \\ 4 = 2 and: [ each x \\ 2 = 0 ])
				ifTrue: [ listeActiveNodes add: each ].
			(each y \\ 4 = 3 and: [ each x \\ 2 = 0 ])
				ifTrue: [ listeActiveNodes add: each ] ].
	self activeNodes: listeActiveNodes
]

{ #category : #running }
AIHexagonalLatticeGenerator >> run [
	self nodes: (1 to: n * m).
	self initializeNodesOnGrid.
	self buildLinks.
	 self removeUnnecessaryNodes
]
