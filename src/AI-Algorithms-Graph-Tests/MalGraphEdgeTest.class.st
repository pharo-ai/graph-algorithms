Class {
	#name : #MalGraphEdgeTest,
	#superclass : #TestCase,
	#category : #'AI-Algorithms-Graph-Tests-Nodes Tests'
}

{ #category : #tests }
MalGraphEdgeTest >> testPrintString [
	self
		assert: (AIGraphEdge with: 'model' from: 'from' to: 'to') printString
		equals:  '''from'' -> ''to'''.
]
