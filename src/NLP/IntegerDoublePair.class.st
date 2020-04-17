Class {
	#name : #IntegerDoublePair,
	#superclass : #Magnitude,
	#instVars : [
		'id',
		'val'
	],
	#category : #NLP
}

{ #category : #'as yet unclassified' }
IntegerDoublePair class >> withId: anInteger val: aFloat [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| anIntDoublePair |
	anIntDoublePair := IntegerDoublePair new.
	anIntDoublePair := anIntDoublePair id: anInteger.
	anIntDoublePair := anIntDoublePair val: aFloat.
		
	^ anIntDoublePair
]

{ #category : #'as yet unclassified' }
IntegerDoublePair class >> withWord: anInteger val: anotherInteger [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	| anIntDoublePair |
	anIntDoublePair := IntegerDoublePair new.
	anIntDoublePair := anIntDoublePair word: anInteger.
	anIntDoublePair := anIntDoublePair val: anotherInteger.
		
	^ anIntDoublePair
]

{ #category : #testing }
IntegerDoublePair >> < anIntegerDoublePair [

	^ self val < anIntegerDoublePair val
]

{ #category : #accessing }
IntegerDoublePair >> id [
	^ id
]

{ #category : #accessing }
IntegerDoublePair >> id: anInteger [
	id := anInteger
]

{ #category : #accessing }
IntegerDoublePair >> val [
	^ val
]

{ #category : #accessing }
IntegerDoublePair >> val: aFloat [
	val := aFloat
]
