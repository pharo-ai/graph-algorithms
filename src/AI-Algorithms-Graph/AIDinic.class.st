Class {
	#name : #AIDinic,
	#superclass : #AIGraphAlgorithm,
	#instVars : [
		'mapping',
		'queue',
		'start',
		'sink'
	],
	#category : #'AI-Algorithms-Graph'
}

{ #category : #backtracking }
AIDinic >> bfs [

	| node ind ret |
	[ queue isNotEmpty ] whileTrue: [
		node := queue removeFirst.
		ind := mapping at: node.
		ind do: [ :i |
			| e n |
			e := edges at: i.
			n := e to.
			e capacity - e flow >= 1 & (n level = -1) ifTrue: [
				n level: node level + 1.
				queue addLast: n ] ] ].
	ret := sink level == -1.
	^ ret
]

{ #category : #configuration }
AIDinic >> currentIndexSetup [

	| nod |
	nod := self nodes.
	nod do: [ :n | n currentIndex: 1 ]
]

{ #category : #backtracking }
AIDinic >> dfs: fromNode pushed: p [

	| arr cid id edg reverseEdg toNode tr min |
	p == 0 ifTrue: [ ^ 0 ].
	fromNode == sink ifTrue: [ ^ p ].

	arr := mapping at: fromNode.
	cid := fromNode currentIndex.

	[ cid <= arr size ] whileTrue: [
		id := arr at: cid.
		edg := edges at: id.
		toNode := edg to.

		fromNode level + 1 == toNode level & (edg capacity - edg flow >= 1)
			ifTrue: [
				fromNode currentIndex: cid.
				min := self minimumValue: edg capacity - edg flow compare: p.
				tr := self dfs: toNode pushed: min ].

		tr == 0 ifFalse: [
			edg flow: edg flow + tr.
			reverseEdg := self reverseEdge: toNode to: fromNode.
			reverseEdg flow: reverseEdg flow - tr.
			^ tr ].
		cid := cid + 1.
		fromNode currentIndex: cid ].
	^ 0
]

{ #category : #configuration }
AIDinic >> edgeClass [

	^ AINetworkFLowEdge
]

{ #category : #initialization }
AIDinic >> initialize [ 
	super initialize.
	mapping:= Dictionary new.
	queue := LinkedList new.
]

{ #category : #configuration }
AIDinic >> levelSetup [

	| nod |
	nod := self nodes.
	nod do: [ :n | n level: -1 ]
]

{ #category : #configuration }
AIDinic >> mapConfig [

	| edg nod arr fromNode |
	edg := self edges.
	nod := self nodes.
	nod do: [ :n | mapping at: n put: OrderedCollection new ].
	edg doWithIndex: [ :e :i |
		fromNode := e from.
		arr := mapping at: fromNode.
		arr add: i ]
]

{ #category : #accessing }
AIDinic >> mapping [

	^ mapping
]

{ #category : #utilities }
AIDinic >> minimumValue: firstNumber compare: secondNumber [

	firstNumber > secondNumber ifTrue: [ ^ secondNumber ].
	^ firstNumber
]

{ #category : #configuration }
AIDinic >> nodeClass [

	^ AIDinicNode
]

{ #category : #utilities }
AIDinic >> reverseEdge: fromNode to: toNode [

	| arr e |
	arr := mapping at: fromNode.
	arr do: [ :i |
		e := edges at: i.
		e to == toNode & (e capacity == 0) ifTrue: [ ^e ] ].
]

{ #category : #running }
AIDinic >> run [

	| finalFlow bfsBool pushed maxValue |
	maxValue := SmallInteger maxVal.
	finalFlow := 0.
	true whileTrue: [
		self levelSetup.
		start level: 0.
		queue addLast: start.
		bfsBool := self bfs.
		bfsBool ifFalse: [ ^ 0 ].
		self currentIndexSetup.
		pushed := self dfs: start pushed: maxValue.
		pushed == 0 whileFalse: [
			finalFlow := finalFlow + pushed.
			pushed := self dfs: start pushed: maxValue ] ].
	^ finalFlow
]

{ #category : #running }
AIDinic >> run: startNode to: sinkNode [

	| finalFlow bfsBool pushed maxValue |
	start := startNode.
	sink := sinkNode.
	self mapConfig.
	maxValue := SmallInteger maxVal.
	finalFlow := 0.
	[ true ] whileTrue: [
		self levelSetup.
		start level: 0.
		queue addLast: start.
		bfsBool := self bfs.
		bfsBool ifTrue: [ ^ 0 ].
		self currentIndexSetup.
		pushed := self dfs: start pushed: maxValue.
		pushed == 0 whileFalse: [
			finalFlow := finalFlow + pushed.
			pushed := self dfs: start pushed: maxValue ] ].
	^ finalFlow
]
