"
The reduced graph of G is the graph G where each strongly connected components was merged into one vertice / node.

circuitsNodes instance variable will collect all nodes created by merging nodes in a circuit.
"
Class {
	#name : #AIGraphReducer,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'circuits',
		'circuitNodes'
	],
	#category : #'AI-Algorithms-Graph-Graph Reducer'
}

{ #category : #updating }
AIGraphReducer >> addCircuitNodes [

	nodes addAll: circuitNodes
]

{ #category : #running }
AIGraphReducer >> findCircuits [

	| tarjanCircuits |
	tarjanCircuits := AITarjan new
		                  nodesAndNextFrom: nodes;
		                  run;
		                  circuits.
	circuits := tarjanCircuits collect: [ :circuit | 
		            circuit collect: [ :each | self findNode: each ] ]
]

{ #category : #initialization }
AIGraphReducer >> initialize [
	super initialize.
	circuitNodes := OrderedCollection new.
	circuits := OrderedCollection new
]

{ #category : #merging }
AIGraphReducer >> mergeNodesInCircuit: aCircuit [

	| sortedNodes |
	"ensure that we get the same order in nodes part of a cycle. Tarjan uses a dictionary and order depends on model hash that can differ from a machine to another one."
	sortedNodes := aCircuit sort: [ :one :other | 
		               one model < other model ].
	circuitNodes add: (self nodeClass new
			 mergedNodes: sortedNodes;
			 model: (sortedNodes collect: [ :each | each model ]);
			 adjacentNodes: (self nextNodesFor: sortedNodes);
			 previousNodes: (self previousNodesFor: sortedNodes);
			 yourself)
]

{ #category : #merging }
AIGraphReducer >> mergeNodesInCircuits [

	circuits do: [ :each | self mergeNodesInCircuit: each ].
	self removeReferencesToMergedNodes.
	self removeMergedNodes.
	self addCircuitNodes
]

{ #category : #computing }
AIGraphReducer >> nextNodesFor: aNodeList [

	"compute next nodes for the future node replacing aNodeList"

	^ ((aNodeList flatCollect: #nextNodes as: Set) difference: aNodeList)
		  asOrderedCollection
]

{ #category : #configuration }
AIGraphReducer >> nodeClass [
	^ AIReducedGraphNode
]

{ #category : #computing }
AIGraphReducer >> previousNodesFor: aNodeList [

	"compute previous nodes for the future node replacing aNodeList"

	^ ((aNodeList flatCollect: #previousNodes as: Set) difference:
		   aNodeList) asOrderedCollection
]

{ #category : #updating }
AIGraphReducer >> removeCircularDependenciesFrom: circuitNode [

	circuitNode adjacentNodes removeAllSuchThat: [ :each | 
		each = circuitNode ].
	circuitNode previousNodes removeAllSuchThat: [ :each | 
		each = circuitNode ]
]

{ #category : #updating }
AIGraphReducer >> removeMergedNodes [

	nodes removeAll: (circuitNodes flatCollect: #mergedNodes)
]

{ #category : #updating }
AIGraphReducer >> removeReferencesToMergedNodes [

	circuitNodes do: [ :circuitNode | 
		self updateReferencesTo: circuitNode mergedNodes by: circuitNode.
		self removeCircularDependenciesFrom: circuitNode ]
]

{ #category : #running }
AIGraphReducer >> run [

	self findCircuits.
	self mergeNodesInCircuits.
	^ self nodes
]

{ #category : #updating }
AIGraphReducer >> updateNextNodesOf: mergedNode replacing: aNodeList by: anotherNode [

	mergedNode adjacentNodes do: [ :node | 
		node previousNodes
			removeAllFoundIn: aNodeList;
			addIfNotPresent: anotherNode ]
]

{ #category : #updating }
AIGraphReducer >> updatePreviousNodesOf: mergedNode replacing: aNodeList by: anotherNode [

	mergedNode previousNodes do: [ :node | 
		node adjacentNodes
			removeAllFoundIn: aNodeList;
			addIfNotPresent: anotherNode ]
]

{ #category : #updating }
AIGraphReducer >> updateReferencesTo: aNodeListOfMergedNodes by: anotherNode [

	aNodeListOfMergedNodes do: [ :mergedNode | 
		self
			updatePreviousNodesOf: mergedNode
			replacing: aNodeListOfMergedNodes
			by: anotherNode.
		self
			updateNextNodesOf: mergedNode
			replacing: aNodeListOfMergedNodes
			by: anotherNode ]
]
