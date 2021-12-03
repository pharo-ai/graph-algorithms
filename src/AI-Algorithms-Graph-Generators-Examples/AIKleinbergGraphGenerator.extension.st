Extension { #name : #AIKleinbergGraphGenerator }

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIKleinbergGraphGenerator class >> example1 [

	| g nbNodes |
	nbNodes := 10.
	g := self new
		     nodes: (1 to: nbNodes * nbNodes);
		     n: nbNodes;
		     p: 1;
		     q: 1;
		     r: 3.0.
	g run.

	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		gridLayout: nbNodes;
		run
]

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIKleinbergGraphGenerator class >> example2 [

	| g |
	g := self new
		     nodes: (1 to: 9);
		     n: 3;
		     p: 1;
		     q: 2;
		     r: 2.0.
	g run.

	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		gridLayout: 3;
		run
]

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIKleinbergGraphGenerator class >> example3 [

	| g nbNodes |
	nbNodes := 10.
	g := self new
		     nodes: (1 to: nbNodes * nbNodes);
		     n: nbNodes;
		     p: 1;
		     q: 4;
		     r: 3.0.
	g run.

	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		gridLayout: nbNodes;
		run
]
