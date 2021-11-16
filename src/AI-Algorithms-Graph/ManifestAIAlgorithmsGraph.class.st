"
I am the manifest of the package.
"
Class {
	#name : #ManifestAIAlgorithmsGraph,
	#superclass : #PackageManifest,
	#category : #'AI-Algorithms-Graph-Manifest'
}

{ #category : #'code-critics' }
ManifestAIAlgorithmsGraph class >> ruleModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AITarjan #addNewSccForNode: #false)) #'2021-08-17T12:43:07.085916+02:00') )
]

{ #category : #'code-critics' }
ManifestAIAlgorithmsGraph class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AITarjan #addNewSccForNode: #false)) #'2021-08-17T12:43:10.336858+02:00') )
]
