Extension { #name : #AIHexagonalLatticeGenerator }

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIHexagonalLatticeGenerator class >> example1 [

	| g nbNodes |
	nbNodes := 20.
	g := self new
		     n: 20;
		     m: 20.
	g run.

	AIGraphGeneratorExampleHelper new
		nodes: g activeNodes edges: g edges;
		gridLayout: nbNodes;
		run
]

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIHexagonalLatticeGenerator class >> example2 [

	| g |
	g := self new
		     n: 6;
		     m: 6.
	g run.
	
	AIGraphGeneratorExampleHelper new
		nodes: g activeNodes edges: g edges;
		animatedLayout;
		run
]
