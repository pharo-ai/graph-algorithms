"
A MalWaltzStrogatzGraphGeneratorTest is a test class for testing the behavior of MalWaltzStrogatzGraphGenerator
"
Class {
	#name : #AIWaltzStrogatzGraphGeneratorTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Generators-Tests'
}

{ #category : #tests }
AIWaltzStrogatzGraphGeneratorTest >> testNumberOfNodes [
	| g |
	g := AIWaltzStrogatzGraphGenerator new.
	g
		nodes: (1 to: 30);
		k: 10.
	g run.
	self assert: g nodes size equals: 30
]
