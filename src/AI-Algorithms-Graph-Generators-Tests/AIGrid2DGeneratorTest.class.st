"
A MalGrid2DGeneratorTest is a test class for testing the behavior of MalGrid2DGenerator
"
Class {
	#name : #AIGrid2DGeneratorTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Generators-Tests'
}

{ #category : #tests }
AIGrid2DGeneratorTest >> testNumberOfNodes [
	| g |
	g := AIGrid2DGenerator new.
	g
		height: 10;
		width: 5;
		neighborhood: #vonNeumann.
	g run.
	self assert: g nodes size equals: 50
]
