Class {
	#name : #AIWaltzStrogatzGraphGenerator,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'k'
	],
	#category : #'AI-Algorithms-Graph-Generators'
}

{ #category : #running }
AIWaltzStrogatzGraphGenerator >> buildRegularLattice [
	| graph n |
	graph := self nodes.
	n := graph size.
	1 to: n do: [ :i | |e|
		e := k /2.
		(i - e - 1)  to: (i + e - 1)
			do: [ :j |
				self
					addEdge:
						{(graph at: i) model.
						(graph at: j \\ n +1) model}
					from: #first
					to: #second ] ]
]

{ #category : #configuration }
AIWaltzStrogatzGraphGenerator >> edgeClass [
	^ AIGraphEdge
]

{ #category : #accessing }
AIWaltzStrogatzGraphGenerator >> k: aValue [
	k := aValue
]

{ #category : #running }
AIWaltzStrogatzGraphGenerator >> rewireRandomly [
	" | numberOfNodes |
numberOfNodes := self nodes size.
	self edges
		do: [ :e |
			100 atRandom / 100 < beta
				ifTrue: [
					[ k := numberOfNodes atRandom  ] repeatUntil: (true).

					 ] ]"
]

{ #category : #running }
AIWaltzStrogatzGraphGenerator >> run [
	self buildRegularLattice.
	self rewireRandomly
]
