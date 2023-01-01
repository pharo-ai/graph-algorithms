"
A MalTopologicalSortingTest is a test class for testing the behavior of MalTopologicalSorting
"
Class {
	#name : #AITopologicalSortingTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AITopologicalSortingTest >> setUp [
	super setUp.
	sorter := AITopologicalSorting new
]

{ #category : #tests }
AITopologicalSortingTest >> testSimpleGraph [

	| sortedItems |
	AIGraphFixture simpleGraph: sorter.
	sorter run.
	sortedItems := sorter topologicalSortedElements.
	"First level: A, D
	second level: B
	third level: C
	First level comes first, then second level..."
	self assert: sortedItems asArray equals: #( $a $d $b $c )
]

{ #category : #tests }
AITopologicalSortingTest >> testSortStringHierarchy [

	| result topologicalOrder |
	sorter
		addNodesFrom: String
		childrenBlock: [ :class | class subclasses ].
	result := sorter run asArray.
	"This is one of the topological orders of the String hierarchy"
	topologicalOrder := {
		                    String.
		                    ByteString.
		                    Symbol.
		                    WideString.
		                    ByteSymbol.
		                    WideSymbol }.
	self assertCollection: result equals: topologicalOrder
]

{ #category : #tests }
AITopologicalSortingTest >> testSortWithCycle [

	AIGraphFixture cycleGraph: sorter.
	self should: [ sorter run ] raise: Error
]

{ #category : #tests }
AITopologicalSortingTest >> testSortWithReducedGraph [

	| graphReducer result |
	graphReducer := AIGraphReducer new.
	AIGraphFixture complexCycleGraph2: graphReducer.
	sorter addNodesFromDifferentGraph: graphReducer run.
	result := sorter run.

	self assert: (result at: 1) equals: $c.
	self assert: (result at: 2) equals: $g.
	self assert: (result at: 3) equals: $a.
	self assert: (result at: 4) equals: $i.
	self
		assertCollection: (result at: 5) asArray
		hasSameElements: #( $e $b $d $f ).
	self assert: (result at: 6) equals: $h
]

{ #category : #tests }
AITopologicalSortingTest >> testWithoutCyclesComplexGraph [

	| sortedItems |
	AIGraphFixture withoutCyclesComplexGraph: sorter.
	sorter run.
	sortedItems := sorter topologicalSortedElements.
	"There are several possible topological orders with this combinations:
	First level: A, B, J
	second level: L, K, G, H, C, E
	third level: M, N D, O, Q
	fourth level: F, P
	fifth level: I
	sixth level: R
	seventh level: S
	So, the first nodes are the ones in the first level. Then comes the second level, etc."
	self
		assert: sortedItems asArray
		equals:
		#( $a $b $j $e $g $c $h $k $l $o $q $d $m $n $p $f $i $r $s )
]

{ #category : #tests }
AITopologicalSortingTest >> testWithoutCyclesMediumGraph [

	| sortedItems |
	AIGraphFixture withoutCyclesMediumGraph: sorter.
	sorter run.
	sortedItems := sorter topologicalSortedElements.
	"A, B must come first. E and G come after A. C and H come after B. D comes after H. F comes after D and G."
	self assert: sortedItems asArray equals: #( $a $b $e $g $c $h $d $f )
]
