Class {
	#name : 'AIDinicTest',
	#superclass : 'TestCase',
	#instVars : [
		'dinic'
	],
	#category : 'AI-Algorithms-Graph-Tests-Maximum Flow Tests',
	#package : 'AI-Algorithms-Graph-Tests',
	#tag : 'Maximum Flow Tests'
}

{ #category : 'running' }
AIDinicTest >> setUp [

	super setUp.
	dinic := AIDinic new.
]

{ #category : 'tests' }
AIDinicTest >> testComplexFlow [

	| graphType graph value |
	graphType := AIWeightedDAGFixture new.
	graph := graphType withoutCyclesComplexWeightedGraph.
	dinic nodes: graph nodes.
	dinic
		edges: graph edges
		from: [ :each | each first ]
		to: [ :each | each second ]
		capacity: [ :each | each third ].
	dinic
		setStartNode: (dinic findNode: $b)
		sinkNode: (dinic findNode: $r).

	value := dinic run.
	self assert: value equals: 2.
]

{ #category : 'tests' }
AIDinicTest >> testSimpleFlow [

	| graphType graph value |
	graphType := AIWeightedDAGFixture new.
	graph := graphType weightedDAG.
	dinic nodes: graph nodes.
	dinic
		edges: graph edges
		from: [ :each | each first ]
		to: [ :each | each second ]
		capacity: [ :each | each third ].
	dinic
		setStartNode: (dinic findNode: $B)
		sinkNode: (dinic findNode: $E).

	value := dinic run.
	self assert: value equals: 17.
]
