"
This algorithms need the Formal Concept Analysis algos from MooseAlgos https://github.com/moosetechnology/MooseAlgos

AILattice on: MalFormalContext mammals2.

AILattice new viewLattice: (AILattice on: MalFormalContext mammals2)


| data fca context lattice |
	data := #(#(#Cat #(#fourlegs #hair)) #(#Dog #(#smart #fourlegs #hair)) #(#Dolphin #(#smart #marine)) #(#Gibbon #(#hair #smart #thumbed)) #(#Man #(#smart #thumbed)) #(#Whale #(#smart #marine))).
	fca := LatticeFormalContext new.
	context := fca with: data using: #first using: #last.
	MalLatticePatterns on: (AILattice new viewLattice: (AILattice on: context)) 
"
Class {
	#name : #AILattice,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'layers'
	],
	#category : #'AI-Algorithms-Lattice'
}

{ #category : #'instance creation' }
AILattice class >> on: formalContext [
	^ self new onConstruct: formalContext
]

{ #category : #accessing }
AILattice >> addNode: aNode [
	self findNode: aNode ifAbsent: [self nodes add: aNode]
]

{ #category : #enumerating }
AILattice >> bottom [
	"Any node without descendants, and which is not a top is a bottom"

	"self nodes do: [:node | (node descendants isEmpty and: [node ~= self top]) ifTrue: [^node]]."

	^ layers last first
]

{ #category : #construction }
AILattice >> computeLabels [
	"Starting from top node compute lables for all nodes according to the intent and extents of their dependendants, for each node having common attributes with descendant, keep that attribute ... push the common objects to the labels of the dependendants"

	layers do: [ :n | n do: [ :aNode | aNode computeLabel ] ]
]

{ #category : #construction }
AILattice >> connectBottom [
	self nodes
		do: [ :node | 
			(node descendants isEmpty and: [ node ~= self bottom ])
				ifTrue: [ node addDescendant: self bottom ] ]
]

{ #category : #accessing }
AILattice >> filterDescendants [
	"if I have a descendant that also appears as a descendant in my descendants, remove it from the set of my descendants"

	self nodes
		do: [ :node | node descendants do: [ :desc | (desc descendants intersection: node descendants) ifNotEmpty: [ :intersect | node removeDescendant: intersect asArray ] ] ]
]

{ #category : #construction }
AILattice >> onConstruct: formalContext [
	formalContext concepts
		do: [:each | self addNode: (AILatticeNode withNew: each)].
		layers := ((self nodes asArray groupedBy: #layer) associations sort: [ :a :b | a key < b key]) collect: #value.
		layers size - 1 to: 1 by: -1 do: [ :n |
		n + 1 to: layers size -1 do: [ :m |
			(layers at: n) do: [ :each |
				(layers at: m) do: [ :child |
					each maybeAppendChild: child ]]]].
	self filterDescendants.
	self connectBottom.
	self computeLabels.
]

{ #category : #enumerating }
AILattice >> orphans [
	| allNodes diff nonEmptyDescendants nonOrphans |
	nonOrphans := OrderedCollection new.
	allNodes := self nodes asSet.
	nonEmptyDescendants := self nodes reject: [ :node | node descendants isEmpty ].
	nonOrphans := (nonEmptyDescendants flatCollect: [ :each | each descendants ]) asSet.
	diff := allNodes difference: nonOrphans.
	^ diff
]

{ #category : #enumerating }
AILattice >> top [
	^ (layers at: 1) first
]
