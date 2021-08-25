Class {
	#name : #AIDAGPath,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'start'
	],
	#category : #'AI-Algorithms-Graph-Path in DAG'
}

{ #category : #running }
AIDAGPath >> initializePathWeights [

	nodes do: [ :node | node pathWeight: Float infinity ].
	start pathWeight: 0
]

{ #category : #running }
AIDAGPath >> run [

	| topSorter stack sortedNode |
	self initializePathWeights.
	topSorter := AITopologicalSorting new
		             addNodesFromDifferentGraph: nodes;
		             yourself.
	topSorter run.
	"Sort the nodes in topological order"
	stack := topSorter topologicalSortedElements.
	[ stack isNotEmpty ] whileTrue: [ 
		sortedNode := self findNode: stack removeFirst.
		sortedNode outgoingEdges do: [ :nextEdge |
			"If the pathWeight of the outgoing node (adjacent node) is greater than the cost of the current pathWeight + 
			the weight of the edge, then update the pathWeight of the outgoing node with smaller cost."
			[ nextEdge to pathWeight > (sortedNode weight + nextEdge weight) ] 
				ifTrue: [ 
					nextEdge to pathWeight: sortedNode weight + nextEdge weight.
					"The previousNode is useful for retrieving the path"
					nextEdge to previousNode: sortedNode ] ] ]
]
