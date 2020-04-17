Class {
	#name : #OrderedIntegerPair,
	#superclass : #Object,
	#instVars : [
		'word1',
		'word2'
	],
	#category : #NLP
}

{ #category : #'as yet unclassified' }
OrderedIntegerPair class >> withWord1: anInteger word2: anotherInteger [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| anOrdIntPair |
	anOrdIntPair := OrderedIntegerPair new.
	anOrdIntPair := anOrdIntPair word1: anInteger.
	anOrdIntPair := anOrdIntPair word2: anotherInteger.
		
	^ anOrdIntPair
]

{ #category : #comparing }
OrderedIntegerPair >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ word2 = anObject word2 and: [ word1 = anObject word1 ]
]

{ #category : #comparing }
OrderedIntegerPair >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	| temp aHash |
	temp := 3.
	aHash := temp * 47 + (word1 hash).
	aHash := aHash * 47 + (word2 hash).
	^ aHash
]

{ #category : #printing }
OrderedIntegerPair >> toString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ 'WordPair{' , 'word1=' , (word1 asString) , ', word2=' , (word2 asString) , '}'
]

{ #category : #accessing }
OrderedIntegerPair >> word1 [

	^ word1
]

{ #category : #accessing }
OrderedIntegerPair >> word1: anInteger [

	word1 := anInteger
]

{ #category : #accessing }
OrderedIntegerPair >> word2 [

	^ word2
]

{ #category : #accessing }
OrderedIntegerPair >> word2: anInteger [

	word2 := anInteger
]
