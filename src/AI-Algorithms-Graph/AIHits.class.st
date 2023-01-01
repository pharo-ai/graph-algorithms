"
From wikipedia:

Hyperlink-Induced Topic Search (HITS; also known as hubs and authorities) is a link analysis algorithm that rates Web pages, developed by Jon Kleinberg. The idea behind Hubs and Authorities stemmed from a particular insight into the creation of web pages when the Internet was originally forming; that is, certain web pages, known as hubs, served as large directories that were not actually authoritative in the information that they held, but were used as compilations of a broad catalog of information that led users direct to other authoritative pages. In other words, a good hub represents a page that pointed to many other pages, while a good authority represents a page that is linked by many different hubs.
"
Class {
	#name : #AIHits,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'k'
	],
	#category : #'AI-Algorithms-Graph-Hits'
}

{ #category : #running }
AIHits >> computeAuthoritiesFor: aNode [

	aNode auth:
		(aNode incomingNodes
			inject: 0
			into: [ :sum :node | sum + node hub ])
]

{ #category : #running }
AIHits >> computeHubsFor: aNode [

	aNode hub:
		(aNode adjacentNodes
			inject: 0
			into: [ :sum :node | sum + node auth ])
]

{ #category : #initialization }
AIHits >> initialize [

	super initialize.
	k := 20
]

{ #category : #running }
AIHits >> initializeNodes [

	nodes do: [ :n |
		n auth: 1.0.
		n hub: 1.0 ]
]

{ #category : #configuration }
AIHits >> k [

	"Number of iterations"

	^ k
]

{ #category : #configuration }
AIHits >> k: aNumberOfIterations [

	k := aNumberOfIterations
]

{ #category : #configuration }
AIHits >> nodeClass [

	^ AIHitsNode
]

{ #category : #running }
AIHits >> normalizeScores [

	| authNorm hubNorm |
	authNorm := 0.
	hubNorm := 0.

	nodes do: [ :node |
		authNorm := authNorm + node auth squared.
		hubNorm := hubNorm + node hub squared ].

	authNorm := authNorm sqrt.
	hubNorm := hubNorm sqrt.

	"To avoid dividing by 0"
	authNorm = 0 ifTrue: [ authNorm := 1.0 ].
	hubNorm = 0 ifTrue: [ hubNorm := 1.0 ].

	nodes do: [ :n |
		n auth: n auth / authNorm.
		n hub: n hub / hubNorm ]
]

{ #category : #running }
AIHits >> run [

	self initializeNodes.
	k timesRepeat: [
		nodes do: [ :node | self computeAuthoritiesFor: node ].
		nodes do: [ :node | self computeHubsFor: node ].
		self normalizeScores ].
	^ nodes
]
