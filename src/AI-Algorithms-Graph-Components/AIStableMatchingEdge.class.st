"
I am pairing an element in group A with an element in group B.

Instantiate me with class method ```#contenderInGroupA:contenderInGroupB:```.
"
Class {
	#name : 'AIStableMatchingEdge',
	#superclass : 'AIGraphEdge',
	#category : 'AI-Algorithms-Graph-Components-Edges',
	#package : 'AI-Algorithms-Graph-Components',
	#tag : 'Edges'
}

{ #category : 'instance creation' }
AIStableMatchingEdge class >> contenderInGroupA: contenderInGroupA contenderInGroupB: contenderInGroupB [
"Answer a new instance of mine with the given AIStableMatchingNodes."

	^ self new
		  from: contenderInGroupA;
		  to: contenderInGroupB;
		  yourself
]

{ #category : 'comparing' }
AIStableMatchingEdge >> = anObject [
	^ self class = anObject class
			and: [ self contenderInGroupA = anObject contenderInGroupA
						and: [ self contenderInGroupB = anObject contenderInGroupB ] ]
]

{ #category : 'accessing' }
AIStableMatchingEdge >> contenderInGroupA [

	^ from
]

{ #category : 'accessing' }
AIStableMatchingEdge >> contenderInGroupB [

	^ to
]

{ #category : 'comparing' }
AIStableMatchingEdge >> hash [
	^ self contenderInGroupA hash bitXor: self contenderInGroupB hash
]
