"
Dinic's algorithm is a graph algorithm used to solve the maximum flow problem efficiently. It is an improvement over the Ford-Fulkerson algorithm and is based on the concept of layering in the residual graph.

Here's a summary of Dinic's algorithm:

- Start with an initial flow of zero and create the residual graph from the given network.

- Construct a level graph using breadth-first search (BFS) on the residual graph. The level graph assigns levels or distances to each vertex, indicating the shortest path from the source.

- While there exists an augmenting path (a path from the source to the sink in the level graph), do the following steps:

	a. Use depth-first search (DFS) to find a blocking flow along the augmenting path. This flow is 		the maximum amount of flow that can be sent through the path.

	b. Update the residual graph by subtracting the blocking flow from forward edges and adding it to 		backward edges.

- Finally, the maximum flow is obtained by summing up the flows on all outgoing edges from the source.

Dinic's algorithm is efficient due to the concept of layering. The algorithm increases the flow in the network by finding multiple disjoint augmenting paths in each iteration, resulting in faster convergence compared to the Ford-Fulkerson algorithm.

The time complexity of Dinic's algorithm is O(V^2E), where V is the number of vertices and E is the number of edges. However, with the use of advanced data structures like dynamic trees, the time complexity can be improved to O(V^2E log(V)).

Overall, Dinic's algorithm is a powerful method for solving the maximum flow problem, particularly for large-scale networks.

Here's an example code snippet to run the Dinic's Algorithm:

|nodes edges dinic value|

nodes := #( $1 $2 $3 $4 $5 $6 ).
edges := #( #( $1 $2 10 ) #( $1 $3 10 ) 
#( $2 $3 2 ) #( $2 $4 4 ) #( $2 $5 8 ) 
#( $3 $5 9 ) #( $4 $6 10 )
#( $5 $4 6 ) #( $5 $6 10 )).

dinic := AIDinic new.
dinic nodes: nodes.
dinic
    edges: edges
    from: [ :each | each first ]
    to: [ :each | each second ]
    capacity: [ :each | each third ].

dinic setStartNode: (dinic findNode: $1) sinkNode: (dinic findNode: $6).

value:= dinic run.

value.
"
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
	"This method uses bfs on the residual graph to construct a level graph.
	The level graph assigns levels or distances to each node, indicating the shortest path from the source.
	The ret boolean indicates if there exists and augmenting path(path from source to sink) in the residual level graph."

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
	"This method uses DFS-style algorithm to find a blocking flow (A blocking flow is a flow that saturates all the edges on the path, preventing any further flow) along the augmenting path.
This performs a series of depth-first searches on the residual graph, exploring the edges with positive residual capacity."

	| arr cid id edg reverseEdg toNode tr min |
	p == 0 ifTrue: [ ^ 0 ].
	fromNode == sink ifTrue: [ ^ p ].

	arr := mapping at: fromNode.
	cid := fromNode currentIndex.
	tr := 0.

	[ cid <= arr size ] whileTrue: [
		id := arr at: cid.
		edg := edges at: id.
		toNode := edg to.
		"Checking if the TO NODE is one level greater than FROM NODE, and for positive residual capacity"
		fromNode level + 1 == toNode level & (edg capacity - edg flow >= 1)
			ifTrue: [
				fromNode currentIndex: cid.
				"Calculating the minimum value between the current positive residual capacity and the pushed value from previous iterations"
				min := self minimumValue: edg capacity - edg flow compare: p.
				"The recursive call of DFS"
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
AIDinic >> initializeAndBfs [
	"This method 
 - Initialises all the levels and current index of the nodes
 - Runs the bfs method to get the level graph
 - Returns a boolean based on whether the there exists an augmenting path or not."

	| bfsBool |
	self levelSetup.
	self currentIndexSetup.
	start level: 0.
	queue addLast: start.
	bfsBool := self bfs.
	^ bfsBool
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

	| finalFlow bfsBool pushed maxValue breakLoop |
	self mapConfig.
	maxValue := SmallInteger maxVal.
	finalFlow := 0.
	breakLoop := true.

	bfsBool := self initializeAndBfs.
	bfsBool ifTrue: [ ^ 0 ].

	[ breakLoop ] whileTrue: [
		pushed := self dfs: start pushed: maxValue.
		[ pushed == 0 ] whileFalse: [
			finalFlow := finalFlow + pushed.
			pushed := self dfs: start pushed: maxValue ].

		bfsBool := self initializeAndBfs.
		bfsBool ifTrue: [ breakLoop := false ] ].
	^ finalFlow
]

{ #category : #initialization }
AIDinic >> setStartNode: startNode sinkNode: sinkNode [

	start := startNode.
	sink := sinkNode
]
