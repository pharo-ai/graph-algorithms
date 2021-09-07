"
This is a variation of the normal Hits algorithm. It runs on a weighted graph. There are cases where the Hits algorithm not behaves as expected and sometimes the Hits algorithm puts 0 as values for the hubs and authorities. To bypass this problem a weighted graph can be used. The weights can represent several things and it's a responsibilty of the user to establish those weights.

For more information, refer to this papers:
- https://cnls.lanl.gov/External/people/highlights/sigir_JMiller.pdf
- https://ieeexplore.ieee.org/document/4392647

Where is detailed how using a weighted graph can improve the results of the Hits algorithm.
"
Class {
	#name : #AIWeightedHits,
	#superclass : #AIHits,
	#category : #'AI-Algorithms-Graph-Hits'
}

{ #category : #running }
AIWeightedHits >> computeAuthoritiesFor: aNode [

	aNode auth: (aNode incomingEdges
			 inject: 0
			 into: [ :sum :edge | sum + (edge weight * edge from hub) ])
]

{ #category : #running }
AIWeightedHits >> computeHubsFor: aNode [

	aNode hub: (aNode outgoingEdges
			 inject: 0
			 into: [ :sum :edge | sum + (edge weight * edge to auth) ])
]

{ #category : #configuration }
AIWeightedHits >> edgeClass [

	^ AIWeightedEdge
]

{ #category : #configuration }
AIWeightedHits >> nodeClass [

	^ AIWeightedHitsNode
]
