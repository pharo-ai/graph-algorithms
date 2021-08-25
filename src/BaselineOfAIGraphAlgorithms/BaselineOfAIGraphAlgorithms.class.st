Class {
	#name : #BaselineOfAIGraphAlgorithms,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIGraphAlgorithms
}

{ #category : #baselines }
BaselineOfAIGraphAlgorithms >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Packages"
		spec package: 'AI-Algorithms-Graph'.
		spec
			package: 'AI-Algorithms-Graph-Components'
			with: [ spec requires: #( 'AI-Algorithms-Graph' ) ].
		spec package: 'AI-Algorithms-Graph-Tests' with: [ 
			spec requires:
				#( 'AI-Algorithms-Graph' 'AI-Algorithms-Graph-Components' ) ] ]
]
