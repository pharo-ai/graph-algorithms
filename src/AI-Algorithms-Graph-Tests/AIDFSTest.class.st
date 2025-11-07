"
Test suite for the AIDFS (Depth-First Search) implementation.
These tests verify the correct functionality of the DFS algorithm and the AIDFSNode class.
"
Class {
	#name : 'AIDFSTest',
	#superclass : 'TestCase',
	#instVars : [
		'dfsp'
	],
	#category : 'AI-Algorithms-Graph-Tests-Shortest Path Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Shortest Path Tests'
}

{ #category : 'running' }
AIDFSTest >> setUp [ 

	super setUp.
    dfsp := AIDFS new
]

{ #category : 'tests' }
AIDFSTest >> testAseCircuitGraph [

	"Tests DFS on a cyclic graph with multiple paths"
	| graph graphType |
	graphType := AICyclicNonWeightedSimpleFixture new.
	graph := graphType aseCircuitGraph.
	dfsp nodes: graph nodes.
	dfsp edges: graph edges from: #first to: #second.

	"Test basic path finding"
	self assert:
		(#( $a $b $c ) hasEqualElements: (dfsp runFrom: $a to: $c)).
	dfsp resetValues.

	self assert:
		(#( $d $b $c ) hasEqualElements: (dfsp runFrom: $d to: $c)).
	dfsp resetValues.

	self assert: (#( $e $a ) hasEqualElements: (dfsp runFrom: $e to: $a)).
	dfsp resetValues.

	"Test longer path"
	self assert:
		(#( $a $b $c $f $g $h ) hasEqualElements: (dfsp runFrom: $a to: $h)).
	dfsp resetValues.

	"Test no path"
	self assert: (#(  ) hasEqualElements: (dfsp runFrom: $f to: $a)).
	dfsp resetValues.

	"Test start equals end"
	self assert: (#( $a ) hasEqualElements: (dfsp runFrom: $a to: $a)).
	dfsp resetValues.
]

{ #category : 'tests' }
AIDFSTest >> testComplexCycleGraph [

	"Tests DFS on a complex cyclic graph"
	| graph graphType |
	graphType := AICyclicNonWeightedComplexFixture new.
	graph := graphType complexCycleGraph.
	dfsp nodes: graph nodes.
	dfsp edges: graph edges from: #first to: #second.

	"Test basic path finding"
	self assert:
		(#( $a $b $e ) hasEqualElements: (dfsp runFrom: $a to: $e)).
	dfsp resetValues.

	self assert:
		(#( $a $c $d $f ) hasEqualElements: (dfsp runFrom: $a to: $f)).
	dfsp resetValues.

	"Test no path"
	self assert: (#(  ) hasEqualElements: (dfsp runFrom: $h to: $a)).
	dfsp resetValues.

	"Test start equals end"
	self assert: (#( $a ) hasEqualElements: (dfsp runFrom: $a to: $a)).
	dfsp resetValues.
]

{ #category : 'tests' }
AIDFSTest >> testSimpleGraph [

	"Tests DFS on a simple directed acyclic graph (DAG)"
	| graph graphType |
	graphType := AINonWeightedDAGFixture new.
	graph := graphType simpleGraph.
	dfsp nodes: graph nodes.
	dfsp edges: graph edges from: #first to: #second.

	"Test basic path finding"
	self assert:
		(#( $a $b $c ) hasEqualElements: (dfsp runFrom: $a to: $c)).
	dfsp resetValues.

	self assert: (#( $d $c ) hasEqualElements: (dfsp runFrom: $d to: $c)).
	dfsp resetValues.

	"Test start equals end"
	self assert: (#( $a ) hasEqualElements: (dfsp runFrom: $a to: $a)).
	dfsp resetValues.

	"Test no path"
	self assert: (#(  ) hasEqualElements: (dfsp runFrom: $c to: $a)).
	dfsp resetValues.
]

{ #category : 'tests' }
AIDFSTest >> testWithoutCyclesMediumGraph [

	"Tests DFS on a medium-sized DAG without cycles"
	| graph graphType |
	graphType := AINonWeightedDAGFixture new.
	graph := graphType withoutCyclesMediumGraph.
	dfsp nodes: graph nodes.
	dfsp edges: graph edges from: #first to: #second.

	"Test basic path finding"
	self assert: (#( $a $e ) hasEqualElements: (dfsp runFrom: $a to: $e)).
	dfsp resetValues.

	self assert: (#( $b $c ) hasEqualElements: (dfsp runFrom: $b to: $c)).
	dfsp resetValues.

	"Test longer path"
	self assert:
		(#( $b $h $d $f ) hasEqualElements: (dfsp runFrom: $b to: $f)).
	dfsp resetValues.

	"Test no path"
	self assert: (#(  ) hasEqualElements: (dfsp runFrom: $f to: $a)).
	dfsp resetValues.

	"Test start equals end"
	self assert: (#( $a ) hasEqualElements: (dfsp runFrom: $a to: $a)).
	dfsp resetValues.
]
