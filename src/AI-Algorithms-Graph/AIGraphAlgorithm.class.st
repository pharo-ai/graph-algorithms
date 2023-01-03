"
I'm the common superclass for all graphs related algorithms.
I store edges and nodes and provides convenience methods to add, access and find nodes or edges.

Once configured, send the run message to execute the algorithm.
"
Class {
	#name : #AIGraphAlgorithm,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'edges',
		'sortingBlock'
	],
	#category : #'AI-Algorithms-Graph-Core'
}

{ #category : #testing }
AIGraphAlgorithm class >> isAbstract [

	^ self = AIGraphAlgorithm
]

{ #category : #private }
AIGraphAlgorithm >> addEdge: edgeModel from: sourceBlock to: targetBlock [

	| edge sourceNode targetNode |
	sourceNode := self findNode: (sourceBlock value: edgeModel) ifAbsent: [ ^ nil ].
	targetNode := self findNode: (targetBlock value: edgeModel) ifAbsent: [ ^ nil ].
	^ self edgeClass
		  ifNil: [
			  sourceNode to: targetNode.
			  targetNode from: sourceNode.
			  nil ]
		  ifNotNil: [
			  edge := self edgeClass with: edgeModel.
			  sourceNode to: targetNode edge: edge.
			  targetNode from: sourceNode edge: edge.
			  edge from: sourceNode.
			  edge to: targetNode.
			  self edges add: edge.
			  edge ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> addNodeFor: aModel [

	^ self
		  findNode: aModel
		  ifAbsent: [ nodes add: (self nodeClass with: aModel) ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> addNodesFrom: model childrenBlock: childrenBlock [

	"recursively add nodes from the model"

	| parent |
	model ifNil: [ ^ self ].

	self
		findNode: model
		ifFound: [
		^ self "Prevent cycles. Do not add a node already added." ].

	parent := self addNodeFor: model.
	(childrenBlock value: model) do: [ :child |
		self addNodesFrom: child childrenBlock: childrenBlock.
		self
			addEdge: { parent model. child }
			from: [ :each | each first ]
			to: [ :each | each second ] ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> addNodesFromDifferentGraph: aNodeList [

	"Adds nodes from another graph. This is useful for example when you want to add all the nodes, and its adjacencies, from one graph to another. For example, first running a graph reducing algo and then do a topological sort. First create the graph reduced graph and then add its nodes to a topological sort graph. "

	aNodeList do: [ :node | self addNodeFor: node model ].
	aNodeList do: [ :node |
		node adjacentNodes do: [ :next |
			self
				addEdge: node model -> next model
				from: [ :each | each key ]
				to: [ :each | each value ] ] ]
]

{ #category : #configuration }
AIGraphAlgorithm >> edgeClass [

	^ nil
]

{ #category : #accessing }
AIGraphAlgorithm >> edges [

	^ edges
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> edges: aCollection from: source to: target [

	aCollection do: [ :eModel |
		self addEdge: eModel from: source to: target ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> edges: aCollection from: source to: target weight: weightFunction [

	| edge |
	aCollection do: [ :eModel |
		edge := self addEdge: eModel from: source to: target.
		edge ifNotNil: [ edge weight: (weightFunction value: eModel) ] ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> edges: aCollection from: source toAll: targets [

	aCollection do: [ :eModel |
		(targets value: eModel) do: [ :target |
			self
				addEdge: {
						(source value: eModel).
						target }
				from: [ :each | each first ]
				to: [ :each | each second ] ] ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> edgesByPair: aCollection [

	" aCollection must be a collection where the incoming edge has to be in the first position and the outgoing esge has to be in the second position.

	You can use this method instead of doing
	edge: aCollection from: #first to: #second"
	aCollection do: [ :eModel |
		self addEdge: eModel
		from: [ :each | each first ]
		to: [ :each | each second ] ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> emptyGraph [

	edges := edges copyEmpty.
	nodes := nodes copyEmpty
]

{ #category : #private }
AIGraphAlgorithm >> findBinaryBlock: aModel [

	"New implementation of the algos to have better performances to find nodes. The nodes and edges are sorted from low to high according to their has number."

	^ [ :aNode | aModel hash - aNode model hash ]
]

{ #category : #accessing }
AIGraphAlgorithm >> findEdge: aModel [

	"^ edges findBinary: (self findBinaryBlock: aModel)"

	^ edges detect: [ :edge | edge model = aModel ]
]

{ #category : #accessing }
AIGraphAlgorithm >> findNode: aModel [

	"^ nodes findBinary: (self findBinaryBlock: aModel)."

	^ nodes detect: [ :node | node model = aModel ]
]

{ #category : #accessing }
AIGraphAlgorithm >> findNode: aModel ifAbsent: aBlock [

	"^ nodes findBinary: (self findBinaryBlock: aModel) ifNone: aBlock"

	^ nodes detect: [ :node | node model = aModel ] ifNone: aBlock
]

{ #category : #accessing }
AIGraphAlgorithm >> findNode: aModel ifFound: aBlock [

	"^ nodes
		  findBinary: (self findBinaryBlock: aModel)
		  do: aBlock
		  ifNone: [  ]"

	^ nodes detect: [ :aNode | aNode model = aModel ] ifFound: aBlock
]

{ #category : #accessing }
AIGraphAlgorithm >> graph [

	^ {  nodes. edges }
]

{ #category : #initialization }
AIGraphAlgorithm >> initialize [

	sortingBlock := [ :a :b | a model hash <= b model hash ].
	nodes := SortedCollection sortUsing: sortingBlock.
	edges := SortedCollection sortUsing: sortingBlock
]

{ #category : #configuration }
AIGraphAlgorithm >> nodeClass [

	^ AIGraphNode
]

{ #category : #accessing }
AIGraphAlgorithm >> nodes [

	^ nodes
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> nodes: aNodeList [

	aNodeList do: [ :model | self addNodeFor: model ]
]

{ #category : #'building - graph' }
AIGraphAlgorithm >> rawNodes: aRawNodeList [

	nodes := aRawNodeList
]

{ #category : #running }
AIGraphAlgorithm >> run [

	self subclassResponsibility
]
