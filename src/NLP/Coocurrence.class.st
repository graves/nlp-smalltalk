Class {
	#name : #Coocurrence,
	#superclass : #Magnitude,
	#instVars : [
		'main',
		'context',
		'xij'
	],
	#category : #NLP
}

{ #category : #'as yet unclassified' }
Coocurrence class >> withMain: anInteger context: anotherInteger xij: aFloat [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| aCoocurrence |
	aCoocurrence := Coocurrence new.
	aCoocurrence := aCoocurrence main: anInteger.
	aCoocurrence := aCoocurrence context: anotherInteger.
	aCoocurrence := aCoocurrence xij: aFloat.
		
	^ aCoocurrence
]

{ #category : #testing }
Coocurrence >> < aCoocurrence [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
	(self main < aCoocurrence main) ifTrue: [ ^ true ].
	(self context < aCoocurrence context) ifTrue: [ ^ true ].
	^ false
]

{ #category : #comparing }
Coocurrence >> = aCoocurrence [
	"Answer whether the receiver and anObject represent the same object."

	self == aCoocurrence
		ifTrue: [ ^ true ].
	self class = aCoocurrence class
		ifFalse: [ ^ false ].
	(self main < aCoocurrence main) ifTrue: [ ^ false].
	(self main > aCoocurrence main) ifTrue: [ ^ false].
	(self main < aCoocurrence context) ifTrue: [ ^ false].
	(self main > aCoocurrence context) ifTrue: [ ^ false].
	^ context = aCoocurrence context or: [ main = aCoocurrence main ]
]

{ #category : #accessing }
Coocurrence >> context [

	^ context
]

{ #category : #accessing }
Coocurrence >> context: anInteger [

	context := anInteger
]

{ #category : #comparing }
Coocurrence >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ context hash bitXor: main hash
]

{ #category : #accessing }
Coocurrence >> main [

	^ main
]

{ #category : #accessing }
Coocurrence >> main: anInteger [

	main := anInteger
]

{ #category : #accessing }
Coocurrence >> xij [

	^ xij
]

{ #category : #accessing }
Coocurrence >> xij: aFloat [

	xij := aFloat
]
