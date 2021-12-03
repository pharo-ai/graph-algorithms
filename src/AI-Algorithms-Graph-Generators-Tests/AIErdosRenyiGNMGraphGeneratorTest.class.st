"
A MalErdosRenyiGNMGraphGeneratorTest is a test class for testing the behavior of MalErdosRenyiGNMGraphGenerator
"
Class {
	#name : #AIErdosRenyiGNMGraphGeneratorTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Generators-Tests'
}

{ #category : #tests }
AIErdosRenyiGNMGraphGeneratorTest >> testNumberOfEdges [
	| g |
	g := AIErdosRenyiGNMGraphGenerator new.
	g
		nodes: (1 to: 30);
		edgesNumber: 20.
	g run.
	self assert: g edges size equals: 20
]

{ #category : #tests }
AIErdosRenyiGNMGraphGeneratorTest >> testNumberOfNodes [
	| g |
	g := AIErdosRenyiGNMGraphGenerator new.
	g
		nodes: (1 to: 30);
		edgesNumber: 20.
	g run.
	self assert: g nodes size equals: 30
]
