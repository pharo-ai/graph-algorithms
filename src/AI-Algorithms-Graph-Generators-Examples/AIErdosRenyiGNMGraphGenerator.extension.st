Extension { #name : #AIErdosRenyiGNMGraphGenerator }

{ #category : #'*AI-Algorithms-Graph-Generators-Examples' }
AIErdosRenyiGNMGraphGenerator class >> example1 [

	| g |
	g := self new
		     nodes: (1 to: 1000);
		     edgesNumber: 700.
	g run.
	
	AIGraphGeneratorExampleHelper new
		nodes: g nodes edges: g edges;
		animatedLayout;
		run
]
