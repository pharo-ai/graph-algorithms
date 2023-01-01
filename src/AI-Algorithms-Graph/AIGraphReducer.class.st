"
The reduced graph of G is the graph G where each strongly connected components was merged into one vertice / node.

circuitsNodes instance variable will collect all nodes created by merging nodes in a circuit.

This algorithm is not merging the weights of the graph. However, reducing a weighted graphs needs an specific way of doing it according to the use case.
"
Class {
	#name : #AIGraphReducer,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'circuits',
		'collapsedNodes'
	],
	#category : #'AI-Algorithms-Graph-Strongly Connected Components'
}

{ #category : #updating }
AIGraphReducer >> addCollapsedNodes [

	nodes addAll: collapsedNodes
]

{ #category : #actions }
AIGraphReducer >> adjacenciesFor: aMergedNodeList [

	"Obtains the adjacent nodes of the merged nodes. Then removes the references to the same merged nodes (to avoid referencing a merged node). Because all the merged nodes are now a same 'reduced' node"

	^ ((aMergedNodeList
		    flatCollect: [ :each | each adjacentNodes ]
		    as: Set) difference: aMergedNodeList) asOrderedCollection
]

{ #category : #running }
AIGraphReducer >> findCircuits [

	| tarjanCircuits |
	tarjanCircuits := AITarjan new
		                  addNodesFromDifferentGraph: nodes;
		                  run;
		                  circuits.
	circuits := tarjanCircuits collect: [ :circuit |
		            circuit collect: [ :each | self findNode: each ] ]
]

{ #category : #initialization }
AIGraphReducer >> initialize [
	super initialize.
	collapsedNodes := OrderedCollection new.
	circuits := OrderedCollection new
]

{ #category : #configuration }
AIGraphReducer >> nodeClass [

	^ AIReducedGraphNode
]

{ #category : #reducing }
AIGraphReducer >> reduceGraph [

	circuits do: [ :each | self reduceNodesInCircuit: each ].
	self removeMergedNodes.
	self addCollapsedNodes.
	self replaceReferencesToMergedNodes
]

{ #category : #reducing }
AIGraphReducer >> reduceNodesInCircuit: aCircuit [

	"This method created a reduced node (called circuit node) that contains all the nodes that are inside a circuit inside a strongly connected component that the Tarjan algorithm found."

	collapsedNodes add: (self nodeClass new
			 mergedNodes: aCircuit;
			 model: (aCircuit collect: [ :each | each model ]);
			 adjacentNodes: (self adjacenciesFor: aCircuit);
			 yourself)
]

{ #category : #updating }
AIGraphReducer >> removeMergedNodes [

	nodes removeAll:
		(collapsedNodes flatCollect: [ :each | each mergedNodes ])
]

{ #category : #reducing }
AIGraphReducer >> replaceReferencesToMergedNode: aReducedNode [

	"Replace the adjacencies of aReducedNode to merged nodes to reference the reduced node instead. For example, is aReducedNode has an an adjacency to node A, but node A has been reduced to node R, replace the adjacency of A with R."

	| newAdjacencies adjacenciesToRemove |
	newAdjacencies := OrderedCollection empty.
	adjacenciesToRemove := OrderedCollection empty.
	aReducedNode adjacentNodes do: [ :anAdjacentNode |
		"Iterate through all the circuitNodes to see if the adjacent node was merged.
		If that is the case (if we found the adjacent node merged), then we need to remove the reference to that node and reference to the new merged node instead. "
		collapsedNodes do: [ :aNode |
			(aNode mergedNodes includes: anAdjacentNode) ifTrue: [
				newAdjacencies add: aNode.
				adjacenciesToRemove add: anAdjacentNode ] ] ].
	aReducedNode adjacentNodes
		removeAllFoundIn: adjacenciesToRemove;
		"We use a set to avoid referencing multiple times to the same reduced node"
		addAll: newAdjacencies asSet
]

{ #category : #reducing }
AIGraphReducer >> replaceReferencesToMergedNodes [

	nodes do: [ :reducedNode |
		self replaceReferencesToMergedNode: reducedNode ]
]

{ #category : #running }
AIGraphReducer >> run [

	self findCircuits.
	self reduceGraph.
	^ nodes
]
