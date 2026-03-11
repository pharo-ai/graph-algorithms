Class {
	#name : 'AIHopcroftKarpTest',
	#superclass : 'TestCase',
	#category : 'AI-Algorithms-Graph-Tests-Graph Matching Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Graph Matching Tests'
}

{ #category : 'tests' }
AIHopcroftKarpTest >> testAsymmetricGraph [
	| algo nodes edges |
	nodes := #(1 2 $A $B $C $D).
	edges := #( #(1 $A) #(1 $B) #(2 $C) #(2 $D) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testBottleneckAndIsolatedEdge [
	| algo nodes edges |
	nodes := #(1 2 3 99 $A $B $C $Z).
	edges := #( #(1 $A) #(2 $A) #(3 $A) #(99 $Z) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testCompleteBipartite2x2 [
	| algo nodes edges |
	nodes := #(1 2 $A $B).
	edges := #( #(1 $A) #(1 $B) #(2 $A) #(2 $B) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testCompleteBipartite3x3 [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( 
		#(1 $A) #(1 $B) #(1 $C) 
		#(2 $A) #(2 $B) #(2 $C) 
		#(3 $A) #(3 $B) #(3 $C) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testCrownGraph [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( 
		#(1 $B) #(1 $C) 
		#(2 $A) #(2 $C) 
		#(3 $A) #(3 $B) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testDenseAsymmetric [

	| algo nodes edges |
	nodes := #( 1 2 3 4 5 $A $B $C ).
	edges := OrderedCollection new.

	#( 1 2 3 4 5 ) do: [ :u |
			edges addAll: (#( $A $B $C ) collect: [ :v |
						 {
							 u.
							 v } ]) ].

	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].

	self assert: algo run equals: 3
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testDenseMinusOneEdge [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( 
		#(1 $A) #(1 $B) #(1 $C) 
		#(2 $A) #(2 $B) #(2 $C) 
		#(3 $A) #(3 $B) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testDisconnectedComponents [
	| algo nodes edges |
	nodes := #(1 2 $A $B).
	edges := #( #(1 $A) #(2 $B) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testDisjointCompleteGraphs [
	| algo nodes edges |
	nodes := #(1 2 3 4 $A $B $C $D).
	edges := #(
		#(1 $A) #(1 $B) #(2 $A) #(2 $B) 
		#(3 $C) #(3 $D) #(4 $C) #(4 $D) 
	).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 4.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testEmptyGraph [

	| algo |
	algo := AIHopcroftKarp new.
	algo nodes: #(  ).
	algo edges: #(  ) from: [ :e | e first ] to: [ :e | e second ].

	self assert: algo run equals: 0.
	self assert: algo matchingEdgeTuples isEmpty
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testEvenCycle [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( #(1 $A) #(1 $B) #(2 $B) #(2 $C) #(3 $C) #(3 $A) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testGreedyTrap [
	| algo nodes edges |
	nodes := #(1 2 3 4 $A $B $C $D).
	edges := #( 
		#(1 $A) #(1 $D) 
		#(2 $B) #(2 $A) 
		#(3 $C) #(3 $B) 
		#(4 $A) #(4 $B) #(4 $C) ).
		
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 4.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testHallsViolationBottleneck [
	| algo nodes edges |
	nodes := #(1 2 3 4 $A $B).
	edges := #( #(1 $A) #(1 $B) #(2 $A) #(2 $B) #(3 $A) #(3 $B) #(4 $A) #(4 $B) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testIndependentSubgraphs [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C $D $E).
	edges := #( 
		#(1 $A) #(1 $B) #(2 $A) #(2 $B)  
		#(3 $C) #(3 $D) #(3 $E)          
	).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testInverseStarGraph [
	| algo nodes edges |
	nodes := #(1 2 3 4 5 $A).
	edges := #( #(1 $A) #(2 $A) #(3 $A) #(4 $A) #(5 $A) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 1.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testIsolatedNodes [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( #(1 $A) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 1.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testLargeEvenCycle [
	| algo nodes edges |
	nodes := (1 to: 10).
	edges := OrderedCollection new.
	
	1 to: 5 do: [ :i | 
		| u v1 v2 |
		u := i.
		v1 := i + 5.
		v2 := (i \\ 5) + 1 + 5.
		edges add: {u . v1}.
		edges add: {u . v2} ].
		
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 5.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testLargeSparseMatching [
	| algo nodes edges |
	nodes := (1 to: 1000) asOrderedCollection.
	edges := OrderedCollection new.
	
	1 to: 500 do: [ :i | edges add: {i . i + 500} ].
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 500.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testMassiveStarGraph [
	| algo nodes edges |
	nodes := (1 to: 1001) asOrderedCollection.
	edges := OrderedCollection new.
	
	2 to: 1001 do: [ :i | edges add: {1 . i} ]. 
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 1.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testMaximumMatching [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( #(1 $A) #(1 $B) #(2 $A) #(3 $C) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testMixedObjectTypes [
	| algo nodes edges |
	nodes := #(1 'Node2' $C 3.14 'Target1' $Z 42.0).
	edges := #( 
		#(1 'Target1') 
		#('Node2' $Z) 
		#($C 42.0) 
		#(3.14 'Target1') ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testNoEdges [

	| algo |
	algo := AIHopcroftKarp new.
	algo nodes: #( 1 2 3 $A $B $C ).
	algo edges: #(  ) from: [ :e | e first ] to: [ :e | e second ].

	self assert: algo run equals: 0.
	self assert: algo matchingEdgeTuples isEmpty
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testPathGraph [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C).
	edges := #( #(1 $A) #(2 $A) #(2 $B) #(3 $B) #(3 $C) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testPerformanceDenseGraph [
	| algo nodes edges |
	nodes := (1 to: 100).
	edges := OrderedCollection new.
	
	1 to: 50 do: [ :u |
		51 to: 100 do: [ :v |
			edges add: {u . v} ] ].
			
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 50.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testReassignmentPath [
	| algo nodes edges |
	nodes := #(1 2 $A $B).
	edges := #( #(1 $A) #(2 $A) #(2 $B) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testRegressionDeepAugmentingPaths [
	| algo nodes edges |
	nodes := (1 to: 400).
	edges := OrderedCollection new.
	
	1 to: 199 do: [ :i | 
		edges add: {i . i + 200}.     
		edges add: {i . i + 201} ].    
		
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 199.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testRegressionIdentityCheck [
	| algo nodes edges u1 u2 v1 |
	u1 := 'DuplicateName' copy.
	u2 := 'DuplicateName' copy.
	v1 := 'TargetNode'.
	
	nodes := { u1 . u2 . v1 }.
	edges := { {u1 . v1} . {u2 . v1} }.
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 1.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testStaircaseGraph [
	| algo nodes edges |
	nodes := #(1 2 3 4 5 $A $B $C $D $E).
	edges := #( 
		#(1 $A) 
		#(2 $A) #(2 $B) 
		#(3 $B) #(3 $C) 
		#(4 $C) #(4 $D) 
		#(5 $D) #(5 $E) ).
		
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 5.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testStarGraph [
	| algo nodes edges |
	nodes := #(1 $A $B $C $D $E).
	edges := #( #(1 $A) #(1 $B) #(1 $C) #(1 $D) #(1 $E) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 1.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testStringNodes [
	| algo nodes edges |
	nodes := #('Alice' 'Bob' 'Charlie' 'Math' 'Physics' 'Biology').
	edges := #( 
		#('Alice' 'Math') 
		#('Bob' 'Physics') 
		#('Charlie' 'Biology') 
		#('Alice' 'Physics') ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testTreeStructure [
	| algo nodes edges |
	nodes := #(1 2 3 4 $A $B $C $D).
	edges := #( #(1 $A) #(1 $B) #(1 $C) #(2 $D) #(3 $D) #(4 $D) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 2.
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testUniquePerfectMatching [

	| algo nodes edges |
	nodes := #( 1 2 3 $A $B $C ).
	edges := #( #( 1 $A ) #( 2 $A ) #( 2 $B ) #( 3 $A ) #( 3 $B ) #( 3 $C ) ).

	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].

	self assert: algo run equals: 3.
	self assert: algo matchingEdgeTuples asSet equals: #( #( 1 $A ) #( 2 $B ) #( 3 $C ) ) asSet
]

{ #category : 'tests' }
AIHopcroftKarpTest >> testWGraph [
	| algo nodes edges |
	nodes := #(1 2 3 $A $B $C $D).
	edges := #( #(1 $A) #(1 $B) #(2 $B) #(2 $C) #(3 $C) #(3 $D) ).
	
	algo := AIHopcroftKarp new.
	algo nodes: nodes.
	algo edges: edges from: [ :e | e first ] to: [ :e | e second ].
	
	self assert: algo run equals: 3.
]
