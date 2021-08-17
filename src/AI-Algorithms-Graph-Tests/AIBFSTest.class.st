Class {
	#name : #AIBFSTest,
	#superclass : #TestCase,
	#instVars : [
		'bfsp'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIBFSTest >> setUp [
	super setUp.
	bfsp := AIBFS new
]

{ #category : #tests }
AIBFSTest >> testAseGraph [

	AIGraphFixture aseCircuitGraph: bfsp.
	self assert: (#( $a $b $c ) hasEqualElements: (bfsp runFrom: $a to: $c)).
	self assert: (#( $d $b $c ) hasEqualElements: (bfsp runFrom: $d to: $c)).
	self assert: (#( $e $a ) hasEqualElements: (bfsp runFrom: $e to: $a)).
	self assert: (#( $a $b $c $f $g $h ) hasEqualElements: (bfsp runFrom: $a to: $h)).
	self assert: (#( $a $b $d $e ) hasEqualElements: (bfsp runFrom: $a to: $e)).
	self assert: (#( $a $b $d ) hasEqualElements: (bfsp runFrom: $a to: $d)).
	self assert: (#( $d $b $c $f ) hasEqualElements: (bfsp runFrom: $d to: $f)).
	"Empty list means path doesn't exist"
	self assert: (#() hasEqualElements: (bfsp runFrom: $f to: $a))
]

{ #category : #tests }
AIBFSTest >> testAseSccGraph [

	AIGraphFixture aseCircuitGraph: bfsp.
	self assert: (#( $a $b $d $e ) hasEqualElements: (bfsp runFrom: $a to: $e)).
	self assert: (#( $b $d ) hasEqualElements: (bfsp runFrom: $b to: $d)).
	self assert: (#( $a $b $d ) hasEqualElements: (bfsp runFrom: $a to: $d))
]

{ #category : #tests }
AIBFSTest >> testComplexUndirectedGraph [

	AIGraphFixture complexUndirectedGraph: bfsp.
	self assert: (#( 10 8 0 7 3 ) hasEqualElements: (bfsp runFrom: 10 to: 3)).
	self assert: (bfsp runFrom: 10 to: 12) size equals: 4.
	self assert: (#( 10 8 0 11 ) hasEqualElements: (bfsp runFrom: 10 to: 11)).
	self assert: (#( 5 6 7 0 ) hasEqualElements: (bfsp runFrom: 5 to: 0)).
	self assert: (#( 8 0 7 3 ) hasEqualElements: (bfsp runFrom: 8 to: 3)).
	self assert: (#( 6 7 0 8 10 ) hasEqualElements: (bfsp runFrom: 6 to: 10)).
	self assert: (#( 4 3 2 12 9 ) hasEqualElements: (bfsp runFrom: 4 to: 9))
]

{ #category : #tests }
AIBFSTest >> testSimpleGraph [

	AIGraphFixture simpleGraph: bfsp.
	self assert: (#( $a $b $c ) hasEqualElements: (bfsp runFrom: $a to: $c)).
	self assert: (#( $d $c ) hasEqualElements: (bfsp runFrom: $d to: $c))
]

{ #category : #tests }
AIBFSTest >> testWithoutCyclesComplexGraph [

	AIGraphFixture withoutCyclesComplexGraph: bfsp.
	self assert: (#( $b $c $o $p $s ) hasEqualElements: (bfsp runFrom: $b to: $s)).
	self assert: (#( $b $h $d $i $r ) hasEqualElements: (bfsp runFrom: $b to: $r))
]
