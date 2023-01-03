"
From wikipedia:
A disjoint-set data structure, also called a union–find data structure or merge–find set, is a data structure that stores a collection of disjoint (non-overlapping) sets. Equivalently, it stores a partition of a set into disjoint subsets. It provides operations for adding new sets, merging sets (replacing them by their union), and finding a representative member of a set. The last operation allows to find out efficiently if any two elements are in the same or different sets. 

I have this time complexities for my operations:
		
Space:		O(n)	
Search:	O(α(n)
Merge:		O(α(n))
α = amortized time complexity
But, when you call the method `find` I path compress the nodes to make all the nodes in the same component point to the same parent. That means that the find and union operations will eventually take a time complexity of O(1). 

I am used by the Kruskal's algorithm to find cycles in a graph with a constant time.
"
Class {
	#name : #AIDisjointSetNode,
	#superclass : #AIGraphNode,
	#instVars : [
		'parent'
	],
	#category : #'AI-Algorithms-Graph-Components-Nodes'
}

{ #category : #accessing }
AIDisjointSetNode >> find [

	| root next node |
	"Find the root of the component"
	node := self.
	root := node.
	[ root = root parent ] whileFalse: [ root := root parent ].

	"Compress the path leading back to the root.
	This is the path compression operation that gives the linear amortized time complexity"
	[ node = root ] whileFalse: [
		next := node parent.
		node parent: root.
		node := next ].

	"Return the root of the component"
	^ root
]

{ #category : #initialization }
AIDisjointSetNode >> initialize [

	super initialize.
	self makeSet
]

{ #category : #accessing }
AIDisjointSetNode >> label [

	^ 'DSN '
]

{ #category : #accessing }
AIDisjointSetNode >> makeSet [

	parent := self
]

{ #category : #'private - accessing' }
AIDisjointSetNode >> parent [

	^ parent
]

{ #category : #'private - accessing' }
AIDisjointSetNode >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
AIDisjointSetNode >> union: aDSNode [

	| root1 root2 |
	root1 := aDSNode find.
	root2 := self find.
	"The nodes already belong to the same component"
	root1 = root2 ifTrue: [ ^ self ].
	root1 parent: root2
]
