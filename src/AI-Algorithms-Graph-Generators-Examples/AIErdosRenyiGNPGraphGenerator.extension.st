Extension { #name : #AIErdosRenyiGNPGraphGenerator }

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIErdosRenyiGNPGraphGenerator class >> example1 [

	| g |
	g := self new
		     nodes: (1 to: 30);
		     probability: 0.1.
	g run.
	
	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]
