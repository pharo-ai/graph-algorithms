Class {
	#name : #AIDinic,
	#superclass : #AIGraphAlgorithm,
	#category : #'AI-Algorithms-Graph'
}

{ #category : #configuration }
AIDinic >> edgeClass [

	^ AINetworkFLowEdge
]

{ #category : #configuration }
AIDinic >> nodeClass [

	^ AIDinicNode
]

{ #category : #running }
AIDinic >> run [

	Transcript show: 'Hi'; cr.
]
