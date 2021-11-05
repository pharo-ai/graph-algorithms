"
Node type used by the Tarjan algorithm. We just keep a list of next nodes (neighbours).

I also have variables to track the lowest my link value and the tarjan index. I have an instance variable `inStack` to check if I am or not in the stack of the Tarjan algorithm.

Tha instance variable `cycleNodes` is a list that contains all the other nodes that are in my same strongly connected component. If I am the only node in the strongly connected component the list will be empty.

"
Class {
	#name : #AITarjanNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'index',
		'lowlink',
		'inStack',
		'cycleNodes'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
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
	adjacentNodes := Set new.
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

	inStack := false
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
