"
A MalGraphAlgorithmTest is a test class for testing the behavior of MalGraphAlgorithm
"
Class {
	#name : #AIGraphAlgorithmTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #tests }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
AIGraphAlgorithmTest >> testingInsertGraphLayout [

	|gr v1 v2 v3 v4 layout used bfsp|
	gr := Graph new.
	v1 := gr addVertexWithValue: 1.
	v2 := gr addVertexWithValue: 2.
	v2 setNewHeight: 10.
	v3 := gr addVertexWithValue: 3.
	v3 setNewHeight: 30.
	v4 := gr addVertexWithValue: 4.
	v4 setNewHeight: 20.
	gr addEdgeFrom: v3 to: v1;
		addEdgeFrom: v3 to: v4;
		addEdgeFrom: v4 to: v2.
	used := LinkedList new.
	used add: v1;
		add: v2;
		add: v3;
		add: v4.
	layout :=GraphWeightedCircleLayout  new.
	layout doExecute: (used).


	bfsp := AIBFS new.
	bfsp insertGraphLayout: gr.
	self assert: 4 equals: (bfsp nodes) size.
	self assert: (#( 3 4 2 ) hasEqualElements: (bfsp
				  runFrom: 3 to: 2;
				  reconstructPath)).
]

{ #category : #'as yet unclassified' }
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
