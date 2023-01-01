Class {
	#name : #AITarjanTest,
	#superclass : #TestCase,
	#instVars : [
		'tarjan'
	],
	#category : #'AI-Algorithms-Graph-Tests-Tests'
}

{ #category : #running }
AITarjanTest >> setUp [
	super setUp.
	tarjan := AITarjan new
]

{ #category : #tests }
AITarjanTest >> testComplexCycle [

	| a b c d f e g h |
	AIGraphFixture complexCycleGraph: tarjan.
	tarjan run.
	a := tarjan findNode: $a.
	b := tarjan findNode: $b.
	c := tarjan findNode: $c.
	d := tarjan findNode: $d.
	e := tarjan findNode: $e.
	f := tarjan findNode: $f.
	g := tarjan findNode: $g.
	h := tarjan findNode: $h.
	self assert: tarjan stronglyConnectedComponents size equals: 5.
	self assert: tarjan circuits size equals: 2.

	self deny: a isInCycle.
	self deny: b isInCycle.
	self deny: e isInCycle.
	self assert: c isInCycle.
	self assert: d isInCycle.
	self assert: f isInCycle.
	self assert: g isInCycle.
	self assert: h isInCycle.

	self
		assertCollection: c cycleNodes
		hasSameElements: (Array with: d with: f).
	self assertCollection: g cycleNodes hasSameElements: (Array with: h).
	self assertCollection: h cycleNodes hasSameElements: (Array with: g)
]

{ #category : #tests }
AITarjanTest >> testComplexCycle2 [

	AIGraphFixture complexCycleGraph2: tarjan.
	tarjan run.
	#( $a $c $g $h $i ) do: [ :each |
		self deny: (tarjan findNode: each) isInCycle ].
	self assert: tarjan stronglyConnectedComponents size equals: 6.
	self assert: tarjan circuits size equals: 1.
	self
		assertCollection: tarjan circuits first
		hasSameElements: #( $b $e $d $f )
]

{ #category : #tests }
AITarjanTest >> testCycle [

	| a b c cycleNodesOfA |
	AIGraphFixture cycleGraph: tarjan.
	tarjan run.
	a := tarjan findNode: $a.
	b := tarjan findNode: $b.
	c := tarjan findNode: $c.
	cycleNodesOfA := Set with: b with: c.
	self assert: a isInCycle.
	self assert: b isInCycle.
	self assert: c isInCycle.
	self deny: (tarjan findNode: $d) isInCycle.
	self assert: (a cycleNodes includesAll: cycleNodesOfA)
]

{ #category : #tests }
AITarjanTest >> testNestedCycle [

	| a b c cycleNodesOfC d f e g h cycleNodesOfI i |
	AIGraphFixture nestedCycleGraph: tarjan.
	tarjan run.
	a := tarjan findNode: $a.
	b := tarjan findNode: $b.
	c := tarjan findNode: $c.
	d := tarjan findNode: $d.
	e := tarjan findNode: $e.
	f := tarjan findNode: $f.
	g := tarjan findNode: $g.
	h := tarjan findNode: $h.
	i := tarjan findNode: $i.
	cycleNodesOfC := Set
		                 with: a
		                 with: b
		                 with: d
		                 with: e.
	cycleNodesOfI := Set with: f with: g with: h.
	self assert: tarjan stronglyConnectedComponents size equals: 2.
	self assert: tarjan circuits size equals: 2.
	tarjan nodes do: [ :n | self assert: n isInCycle ].
	self assert: (c cycleNodes includesAll: cycleNodesOfC).
	self assert: (i cycleNodes includesAll: cycleNodesOfI)
]

{ #category : #tests }
AITarjanTest >> testNoCycle [

	AIGraphFixture simpleGraph: tarjan.
	tarjan run.
	tarjan nodes do: [ :n | self deny: n isInCycle ]
]

{ #category : #tests }
AITarjanTest >> testStronglyConnectedGraph [

	| nodeA nodeD nodeF nodeB nodeC nodeE nodeG nodeH |
	AIGraphFixture stronglyConnectedGraph: tarjan.
	tarjan run.
	nodeA := tarjan findNode: $a.
	nodeB := tarjan findNode: $b.
	nodeC := tarjan findNode: $c.
	nodeD := tarjan findNode: $d.
	nodeE := tarjan findNode: $e.
	nodeF := tarjan findNode: $f.
	nodeG := tarjan findNode: $g.
	nodeH := tarjan findNode: $h.
	self assert: tarjan stronglyConnectedComponents size equals: 4.
	self assert: tarjan circuits size equals: 3.
	self assertCollection: nodeA cycleNodes hasSameElements: {
			nodeB.
			nodeC }.
	self assertCollection: nodeD cycleNodes hasSameElements: { nodeE }.
	self assertCollection: nodeF cycleNodes hasSameElements: {
			nodeG.
			nodeH }
]

{ #category : #tests }
AITarjanTest >> testStronglyConnectedGraphWithObjects [

	| persons nodeA nodeD nodeF nodeB nodeC nodeE nodeG nodeH |
	persons := DummyTestingPerson generateNinePersonArray.
	AIGraphFixture stronglyConnectedGraph: tarjan withObjects: persons.
	tarjan run.
	nodeA := tarjan findNode: (persons at: 1).
	nodeB := tarjan findNode: (persons at: 2).
	nodeC := tarjan findNode: (persons at: 3).
	nodeD := tarjan findNode: (persons at: 4).
	nodeE := tarjan findNode: (persons at: 5).
	nodeF := tarjan findNode: (persons at: 6).
	nodeG := tarjan findNode: (persons at: 7).
	nodeH := tarjan findNode: (persons at: 8).
	self assert: tarjan stronglyConnectedComponents size equals: 4.
	self assert: tarjan circuits size equals: 3.
	self assertCollection: nodeA cycleNodes hasSameElements: {
			nodeB.
			nodeC }.
	self assertCollection: nodeD cycleNodes hasSameElements: { nodeE }.
	self assertCollection: nodeF cycleNodes hasSameElements: {
			nodeG.
			nodeH }
]
