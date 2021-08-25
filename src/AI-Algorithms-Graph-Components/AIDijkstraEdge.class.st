"
I am an edge that is used for the AIDijktra algorithm. I have a visited intance variable to see if I were visited.
"
Class {
	#name : #AIDijkstraEdge,
	#superclass : #AIWeightedEdge,
	#instVars : [
		'visited'
	],
	#category : #'AI-Algorithms-Graph-Components-Edges'
}

{ #category : #initialization }
AIDijkstraEdge >> initialize [ 

	super initialize.
	weight := 1.
	visited := false
]

{ #category : #accessing }
AIDijkstraEdge >> isVisited [

	^ visited
]

{ #category : #accessing }
AIDijkstraEdge >> visited: aBoolean [

	visited := aBoolean 
]
