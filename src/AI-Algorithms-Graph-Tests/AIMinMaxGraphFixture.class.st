Class {
	#name : 'AIMinMaxGraphFixture',
	#superclass : 'Object',
	#instVars : [
		'standardGraph',
		'branchingGraph',
		'amplifyingCycleGraph',
		'harmlessCycleGraph',
		'linearDAG',
		'disconnectedGraph',
		'multipleBranchingGraph',
		'overlappingPathsGraph'
	],
	#category : 'AI-Algorithms-Graph-Tests-Fixture',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Fixture'
}

{ #category : 'accessing' }
AIMinMaxGraphFixture >> amplifyingCycleGraph [

	^ amplifyingCycleGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> amplifyingCycleGraph: anObject [

	amplifyingCycleGraph := anObject
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> branchingGraph [

	^ branchingGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> branchingGraph: anObject [

	branchingGraph := anObject
]

{ #category : 'as yet unclassified' }
AIMinMaxGraphFixture >> buildAmplifyingCycleGraph [
	| nodes edges graph |
	nodes := #(1 2 3 4).
	edges := #( #(1 2 10) #(2 3 -5) #(3 2 -5) #(2 4 10) ).
	
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'as yet unclassified' }
AIMinMaxGraphFixture >> buildBranchingGraph [
	| nodes edges graph |
	nodes := #(1 2 3 4 5 6 7 8).
	edges := #( #(1 2 5) #(1 3 10) #(2 4 0) #(3 4 0) #(1 5 15) #(1 6 20) #(5 7 0) #(6 7 0) #(4 8 0) #(7 8 0) ).
	
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'initialization' }
AIMinMaxGraphFixture >> buildDisconnectedGraph [
	| nodes edges graph |
	nodes := #(1 2 3 4).
	edges := #( #(1 2 5) #(3 4 10) ).
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'as yet unclassified' }
AIMinMaxGraphFixture >> buildHarmlessCycleGraph [
	| nodes edges graph |
	nodes := #(1 2 3 4).
	edges := #( #(1 2 10) #(2 3 5) #(3 2 5) #(2 4 10) ).
	
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'initialization' }
AIMinMaxGraphFixture >> buildLinearDAG [
	| nodes edges graph |
	nodes := #(1 2 3 4).
	edges := #( #(1 2 5) #(2 3 5) #(3 4 5) ).
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'initialization' }
AIMinMaxGraphFixture >> buildMultipleBranchingGraph [
	| nodes edges graph |
	nodes := #(1 2 3 4 5).
	edges := #( #(1 2 5) #(1 3 10) #(1 5 15) #(2 4 0) #(3 4 0) #(5 4 0) ).
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'initialization' }
AIMinMaxGraphFixture >> buildOverlappingPathsGraph [
	| nodes edges graph |
	nodes := #(1 2 3 4 5).
	edges := #( #(1 2 5) #(1 3 5) #(2 4 5) #(3 4 5) #(4 5 5) ).
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'as yet unclassified' }
AIMinMaxGraphFixture >> buildStandardGraph [
	| nodes edges graph |
	nodes := #(1 2 3).
	edges := #( #(1 2 5) #(1 3 2) #(3 2 1) ).
	
	graph := AIGraphWeightedFixtureStructure new.
	graph nodes: nodes.
	graph edges: edges.
	^ graph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> disconnectedGraph [

	^ disconnectedGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> disconnectedGraph: anObject [

	disconnectedGraph := anObject
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> harmlessCycleGraph [

	^ harmlessCycleGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> harmlessCycleGraph: anObject [

	harmlessCycleGraph := anObject
]

{ #category : 'initialization' }
AIMinMaxGraphFixture >> initialize [
	super initialize.
	standardGraph := self buildStandardGraph.
	branchingGraph := self buildBranchingGraph.
	amplifyingCycleGraph := self buildAmplifyingCycleGraph.
	harmlessCycleGraph := self buildHarmlessCycleGraph.
	linearDAG := self buildLinearDAG.
	disconnectedGraph := self buildDisconnectedGraph.
	multipleBranchingGraph := self buildMultipleBranchingGraph.
	overlappingPathsGraph := self buildOverlappingPathsGraph.
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> linearDAG [

	^ linearDAG
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> linearDAG: anObject [

	linearDAG := anObject
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> multipleBranchingGraph [

	^ multipleBranchingGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> multipleBranchingGraph: anObject [

	multipleBranchingGraph := anObject
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> overlappingPathsGraph [

	^ overlappingPathsGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> overlappingPathsGraph: anObject [

	overlappingPathsGraph := anObject
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> standardGraph [

	^ standardGraph
]

{ #category : 'accessing' }
AIMinMaxGraphFixture >> standardGraph: anObject [

	standardGraph := anObject
]
