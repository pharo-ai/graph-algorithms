Class {
	#name : #AIDijkstraTest,
	#superclass : #TestCase,
	#instVars : [
		'dijsktra'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AIDijkstraTest >> setUp [
	super setUp.
	dijsktra := AIDijkstra new
]

{ #category : #tests }
AIDijkstraTest >> testAseBasicCircuit [

	AIGraphFixture aseCircuitGraph: dijsktra.

	self assert: 1 equals: (dijsktra runFrom: $a to: $b).
	dijsktra reset.
	self assert: 3 equals: (dijsktra runFrom: $a to: $e).
	dijsktra reset.
	self assert: 2 equals: (dijsktra runFrom: $c to: $b).
	dijsktra reset.
	self assert: 5 equals: (dijsktra runFrom: $a to: $h).
	dijsktra reset.
	self assert: Float infinity equals: (dijsktra runFrom: $h to: $a)
]

{ #category : #tests }
AIDijkstraTest >> testAseBasicCircuitBacktrack [

	AIGraphFixture aseCircuitGraph: dijsktra.

	self assert: (#( $a $b ) hasEqualElements: (dijsktra
				  runFrom: $a to: $b;
				  backtrack)).
	dijsktra reset.
	self assert: (#( $a $b $d $e ) hasEqualElements: (dijsktra
				  runFrom: $a to: $e;
				  backtrack)).
	dijsktra reset.
	self assert: (#( $c $d $b ) hasEqualElements: (dijsktra
				  runFrom: $c to: $b;
				  backtrack)).
	dijsktra reset.
	self assert: (#( $a $b $c $f $g $h ) hasEqualElements: (dijsktra
				  runFrom: $a to: $h;
				  backtrack)).
	dijsktra reset.
	self assert: (#(  ) hasEqualElements: (dijsktra
				  runFrom: $h to: $a;
				  backtrack))
]
