Class {
	#name : #Vocabulary,
	#superclass : #Object,
	#instVars : [
		'wordToId',
		'idToWord',
		'wordFreqs',
		'currentSize',
		'ready',
		'announcer'
	],
	#category : #NLP
}

{ #category : #'as yet unclassified' }
Vocabulary class >> withCapacity: anInteger [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| aVocab |
	aVocab := Vocabulary new.
	aVocab := aVocab wordToId: (Dictionary new: anInteger).
	aVocab := aVocab idToWord: (Dictionary new: anInteger).
	aVocab := aVocab wordFreqs: (Dictionary new: anInteger).
	
	^ aVocab
]

{ #category : #adding }
Vocabulary >> add: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| assignedId |
	assignedId := self currentSize.
	self incrementCurrentSize.
	self wordToId at: aString put: assignedId.
	self idToWord at: assignedId put: aString.
	self wordFreqs at: aString put: 1.
]

{ #category : #adding }
Vocabulary >> addOrUpdate: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| get |
	get := self getWordId: aString.
	get ifNil: [ self add: aString ] 
	ifNotNil: [ self update: aString ]
]

{ #category : #accessing }
Vocabulary >> announcer [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
Vocabulary >> currentSize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ currentSize
]

{ #category : #accessing }
Vocabulary >> currentSize: anInteger [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	currentSize := anInteger.
]

{ #category : #'as yet unclassified' }
Vocabulary >> getWord: anInteger [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ idToWord at: anInteger
]

{ #category : #'as yet unclassified' }
Vocabulary >> getWordFreq: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ wordFreqs at: aString
]

{ #category : #'as yet unclassified' }
Vocabulary >> getWordId: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ wordToId at: aString ifAbsent: [ nil ]
]

{ #category : #accessing }
Vocabulary >> idToWord [

	^ idToWord
]

{ #category : #accessing }
Vocabulary >> idToWord: aDictionary [

	idToWord := aDictionary
]

{ #category : #'as yet unclassified' }
Vocabulary >> incrementCurrentSize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	currentSize := currentSize + 1.
]

{ #category : #initialization }
Vocabulary >> initialize [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
	
	self idToWord: (OrderPreservingDictionary new: 20000).
	self wordToId: (OrderPreservingDictionary new: 20000).
	self wordFreqs: (OrderPreservingDictionary new: 20000).
	self currentSize: 1.
	self ready: false.
]

{ #category : #'as yet unclassified' }
Vocabulary >> iterate [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| words |
	words := OrderedCollection new: (wordToId size).
	self wordToId associations do: [ :each |
		| word |
		word := Word new.
		word text: each key.
		word id: each value.
		word frequency: (wordFreqs at: each key).
		words add: word.
	 ].
	^ words
]

{ #category : #actions }
Vocabulary >> merge: aVocabulary [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	aVocabulary wordToId associations collect: [ :aWord |
		| freq |
		freq := (aVocabulary wordFreqs) at: (aWord key).
		
		self wordToId at: (aWord key)
			ifPresent: [ :wordFreq |
				self wordFreqs at: (aWord key) put: (wordFreq + freq) ]
			ifAbsent: [ 
				self idToWord at: (self currentSize) put: (aWord key).
				self wordFreqs at: (aWord key) put: freq.
				self wordToId at: (aWord key) put: (self currentSize).
				self incrementCurrentSize. ]
		 ].
	 
]

{ #category : #printing }
Vocabulary >> print [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| words txt|
	txt := '\n'.
	words := OrderedCollection new.
	self wordToId associations do: [ :each |
		| word |
		word := Word new.
		word text: each key.
		word id: each value.
		word frequency: (wordFreqs at: each key).
		words add: word.
	 ].
	words do: [ :each |
		txt := '' join: {txt , (each toString) , '\n'}.
		 ].
	^ txt
	





]

{ #category : #accessing }
Vocabulary >> ready [
	^ ready
]

{ #category : #accessing }
Vocabulary >> ready: anObject [
	ready := anObject
]

{ #category : #'as yet unclassified' }
Vocabulary >> recoverIds: aCollection [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	| ids |
	ids := OrderedCollection new: (aCollection size).
	aCollection do: [ :each |
		wordToId at: each ifPresent:  [ :id | ids add: id ]
	].
	^ ids
]

{ #category : #initialization }
Vocabulary >> size [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	^ wordToId size
]

{ #category : #adding }
Vocabulary >> update: aString [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	

	| freq |
	freq := self getWordFreq: aString.
	freq := freq + 1.
	self wordFreqs at: aString put: freq.
]

{ #category : #accessing }
Vocabulary >> wordFreqs [

	^ wordFreqs
]

{ #category : #accessing }
Vocabulary >> wordFreqs: aDictionary [

	wordFreqs := aDictionary
]

{ #category : #accessing }
Vocabulary >> wordToId [

	^ wordToId
]

{ #category : #accessing }
Vocabulary >> wordToId: aDictionary [

	wordToId := aDictionary
]
