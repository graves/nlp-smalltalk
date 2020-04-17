Class {
	#name : #WordPair,
	#superclass : #Object,
	#instVars : [
		'word1',
		'word2'
	],
	#category : #NLP
}

{ #category : #'as yet unclassified' }
WordPair class >> withWord1: aString word2: anotherString [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| aWordPair |
	aWordPair := WordPair new.
	aWordPair := aWordPair word1: aString.
	aWordPair := aWordPair word2: anotherString.
		
	^ aWordPair
]

{ #category : #comparing }
WordPair >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ word2 = anObject word2 and: [ word1 = anObject word1 ]
]

{ #category : #comparing }
WordPair >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	| temp aHash |
	temp := 3.
	aHash := temp * 47 + (word1 hash).
	aHash := aHash * 47 + (word2 hash).
	^ aHash
]

{ #category : #printing }
WordPair >> toString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ 'WordPair{' , 'word1=' , word1 , ', word2=' , word2 , '}'
]

{ #category : #accessing }
WordPair >> word1 [

	^ word1
]

{ #category : #accessing }
WordPair >> word1: anInteger [

	word1 := anInteger
]

{ #category : #accessing }
WordPair >> word2 [

	^ word2
]

{ #category : #accessing }
WordPair >> word2: anInteger [

	word2 := anInteger
]
