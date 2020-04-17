Class {
	#name : #ManifestNLP,
	#superclass : #PackageManifest,
	#category : #NLP
}

{ #category : #'code-critics' }
ManifestNLP class >> ruleRBCollectSelectNotUsedRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Vocabulary #merge: #false)) #'2020-04-06T23:22:35.662678-04:00') )
]

{ #category : #'code-critics' }
ManifestNLP class >> ruleRBModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#Vocabulary #merge: #false)) #'2020-04-06T23:22:08.353678-04:00') )
]
