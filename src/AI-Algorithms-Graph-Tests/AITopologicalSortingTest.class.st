"
A MalTopologicalSortingTest is a test class for testing the behavior of MalTopologicalSorting
"
Class {
	#name : #AITopologicalSortingTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter'
	],
	#category : #'AI-Algorithms-Graph-Tests'
}

{ #category : #running }
AITopologicalSortingTest >> setUp [
	super setUp.
	sorter := AITopologicalSorting new
]

{ #category : #tests }
AITopologicalSortingTest >> testSortStringHierarchy [

	| result topologicalOrder |
	sorter
		addNodesFrom: String
		childrenBlock: [ :class | class subclasses ].

	result := sorter run asArray.
	"This is one of the topological orders of the String hierarchy"
	topologicalOrder := { String . ByteString . Symbol . WideString . ByteSymbol . WideSymbol }.
	self assertCollection: result equals: topologicalOrder.
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
	sorter nodesFromGraph: graphReducer run.
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
AITopologicalSortingTest >> testSortWithoutCyclesComplexGraph [

	AIGraphFixture withoutCyclesComplexGraph: sorter.
	self
		assertCollection: sorter run asArray
		equals:
		#( $a $b $j $e $g $c $h $k $l $o $q $d $m $n $p $f $i $r $s )
]
