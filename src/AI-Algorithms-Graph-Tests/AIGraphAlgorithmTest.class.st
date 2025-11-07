"
A MalGraphAlgorithmTest is a test class for testing the behavior of MalGraphAlgorithm
"
Class {
	#name : 'AIGraphAlgorithmTest',
	#superclass : 'TestCase',
	#category : 'AI-Algorithms-Graph-Tests-Basic Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Basic Tests'
}

{ #category : 'tests' }
AIGraphAlgorithmTest >> testAddNodesFromChildrenBlock [

	| builder |
	builder := AIGraphReducer new.
	builder
		addNodesFrom: String
		childrenBlock: [ :parent | parent subclasses ].

	self assert: builder nodes size equals: 6.
	self
		assertCollection: (builder nodes collect: [ :each | each model ])
		hasSameElements: (String allSubclasses copyWith: String).
	self
		assertCollection:
			((builder findNode: Symbol) adjacentNodes collect: [ :each |
				 each model ])
		hasSameElements: {
				ByteSymbol.
				WideSymbol }.
	self assert: (builder findNode: ByteSymbol) adjacentNodes isEmpty
]

{ #category : 'tests' }
AIGraphAlgorithmTest >> testingAddingNodes [

   |graphType graph dijkstra|
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType aseCircuitWeightedGraph.
	dijkstra := AIDijkstra new.
	dijkstra nodes: graph nodes.
	dijkstra  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
		
	self assert: 8 equals: (dijkstra nodes) size.
	dijkstra addNodeFor: $i.
	self assert: 9 equals: (dijkstra nodes) size.
	self assert: Float infinity equals: (dijkstra findNode: $i) pathDistance.
	
]

{ #category : 'tests' }
AIGraphAlgorithmTest >> testingFindingNodes [

   |graphType graph dijkstra|
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType aseCircuitWeightedGraph.
	dijkstra := AIDijkstra new.
	dijkstra nodes: graph nodes.
	dijkstra  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
		
	self assert: Float infinity equals: (dijkstra findNode: $g) pathDistance.
]

{ #category : 'tests' }
AIGraphAlgorithmTest >> testingNodeDictionary [

	|graphType graph dijkstra|
	graphType := AICyclicWeightedSimpleFixture new.
	graph :=graphType aseCircuitWeightedGraph.
	dijkstra := AIDijkstra new.
	dijkstra nodes: graph nodes.
	dijkstra  
	   edges: graph edges
		from: #first
		to: #second
		weight: #third.
	dijkstra runFrom: $a.
	self assert: 1 equals: (dijkstra findNode: $b) pathDistance.
	self assert: 8 equals: (dijkstra nodes) size.
	
	dijkstra addNodeFor: $i.
	self assert: 9 equals: (dijkstra nodes) size.
	self assert: Float infinity equals: (dijkstra findNode: $i) pathDistance.

	dijkstra reset.
	dijkstra runFrom: $c.
	self assert: 2 equals: (dijkstra findNode: $b) pathDistance.

	dijkstra reset.
	dijkstra runFrom: $h.
	self assert: Float infinity equals: (dijkstra findNode: $a) pathDistance
]
