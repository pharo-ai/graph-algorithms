"
A MalErdosRenyiGNPGraphGeneratorTest is a test class for testing the behavior of MalErdosRenyiGNPGraphGenerator
"
Class {
	#name : #AIErdosRenyiGNPGraphGeneratorTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Generators-Tests'
}

{ #category : #tests }
AIErdosRenyiGNPGraphGeneratorTest >> testNumberOfNodes [
	| g |
	g := AIErdosRenyiGNPGraphGenerator new.
	g
		nodes: (1 to: 30);
		probability: 0.5.
	g run.
	self assert: g nodes size equals: 30
]
