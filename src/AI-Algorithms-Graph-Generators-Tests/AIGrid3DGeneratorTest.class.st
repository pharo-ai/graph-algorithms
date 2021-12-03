Class {
	#name : #AIGrid3DGeneratorTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Generators-Tests'
}

{ #category : #tests }
AIGrid3DGeneratorTest >> testNumberOfNodes [
	| g |
	g := AIGrid3DGenerator new.
	g
		length: 3;
		height: 3;
		width: 3;
		neighborhood: #vonNeumann.
	g run.
	self assert: g nodes size equals: 27
]
