Class {
	#name : #AICyclesCoverage,
	#superclass : #AITarjan,
	#traits : 'MalTNormalize',
	#classTraits : 'MalTNormalize classTrait',
	#instVars : [
		'circuits',
		'sccExtractorClass'
	],
	#category : #'AI-Algorithms-Graph-Tarjan'
}

{ #category : #accessing }
AICyclesCoverage >> circuits [
	^ circuits
]

{ #category : #running }
AICyclesCoverage >> directCircuit: aCollection [

	^ self normalize: (OrderedCollection 
		with: aCollection first model 
		with: aCollection second model)
]

{ #category : #initialization }
AICyclesCoverage >> initialize [

	super initialize.
	self useNodeDecomposition 
]

{ #category : #accessing }
AICyclesCoverage >> retrieveCircuitsFromSccExtractor: sccExtractor [

	sccExtractor circuits do: [:c |
		circuits add: (c collect: [:n| n model]) ]
]

{ #category : #running }
AICyclesCoverage >> run [

	super run.
	circuits := OrderedCollection new.
	self stronglyConnectedComponents do: [:scc|
		(scc size > 2) ifTrue: [|sccExtractor|
			sccExtractor := sccExtractorClass new.
			sccExtractor nodes: scc.
			"graph injection remove outgoing edges from SCC"
			sccExtractor edges: scc from: #yourself toAll: #nextNodes.
			sccExtractor run.
			self retrieveCircuitsFromSccExtractor: sccExtractor ].
		(scc size = 2) ifTrue: [
			circuits add: (self directCircuit: scc) ]. "direct circuit"
		]
]

{ #category : #running }
AICyclesCoverage >> useCircuitSpan [

	sccExtractorClass := MalCircuitSpanningEdges  
]

{ #category : #running }
AICyclesCoverage >> useEdgeDecomposition [

	sccExtractorClass := MalSccEdgeDecomposition 
]

{ #category : #running }
AICyclesCoverage >> useNodeDecomposition [

	sccExtractorClass := MalSccNodeDecomposition 
]
