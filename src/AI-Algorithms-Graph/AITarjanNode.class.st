"
Node type used by the Tarjan algorithm.
We just keep a list of next nodes (neighbours)
"
Class {
	#name : #AITarjanNode,
	#superclass : #AINodeWithNext,
	#instVars : [
		'index',
		'lowlink',
		'inStack',
		'cycleNodes'
	],
	#category : #'AI-Algorithms-Graph-Nodes'
}

{ #category : #accessing }
AITarjanNode >> cycleNodes [

	^ cycleNodes
]

{ #category : #setting }
AITarjanNode >> cycleNodes: anObject [

	cycleNodes := anObject copy.
	cycleNodes remove: self
]

{ #category : #accessing }
AITarjanNode >> inStack [

	^ inStack
]

{ #category : #setting }
AITarjanNode >> inStack: aBoolean [

	inStack := aBoolean
]

{ #category : #initialization }
AITarjanNode >> initialize [

	super initialize.
	nextNodes := Set new.
	index := -1.
	inStack := false
]

{ #category : #testing }
AITarjanNode >> isInCycle [

	^ self cycleNodes isNotEmpty
]

{ #category : #testing }
AITarjanNode >> isTarjanUndefined [

	^ index = -1
]

{ #category : #accessing }
AITarjanNode >> label [

	^ 'Tarjan Node: '
]

{ #category : #actions }
AITarjanNode >> popped [

	self inStack: false
]

{ #category : #accessing }
AITarjanNode >> tarjanIndex [

	^ index
]

{ #category : #setting }
AITarjanNode >> tarjanIndex: anInteger [

	index := anInteger
]

{ #category : #accessing }
AITarjanNode >> tarjanLowlink [

	^ lowlink
]

{ #category : #setting }
AITarjanNode >> tarjanLowlink: anInteger [

	lowlink := anInteger
]
