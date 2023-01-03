"
Nodes with a 2D position in a grid with x and y.
"
Class {
	#name : #AI2DGridNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'x',
		'y'
	],
	#category : #'AI-Algorithms-Graph-Generators'
}

{ #category : #accessing }
AI2DGridNode >> x [
^x
]

{ #category : #accessing }
AI2DGridNode >> x: anInteger [
	x := anInteger
]

{ #category : #accessing }
AI2DGridNode >> y [
	^ y
]

{ #category : #accessing }
AI2DGridNode >> y: anInteger [
	y := anInteger
]
