"
A MalGraphAlgorithmTest is a test class for testing the behavior of MalGraphAlgorithm
"
Class {
	#name : #AIGraphAlgorithmTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #tests }
AIGraphAlgorithmTest >> testAddNodesFromChildrenBlock [

	| builder |
	builder := AIGraphReducer new.
	builder
		addNodesFrom: String
		childrenBlock: [ :parent | parent subclasses ].

	self assert: builder nodes size equals: 6.
	self
		assertCollection: (builder nodes collect: [ :each | each model ])
		hasSameElements: (String allSubclasses copyWith: String).
	self
		assertCollection:
			((builder findNode: Symbol) adjacentNodes collect: [ :each |
				 each model ])
		hasSameElements: {
				ByteSymbol.
				WideSymbol }.
	self assert: (builder findNode: ByteSymbol) adjacentNodes isEmpty
]
