Class {
	#name : #VocabularyProgressAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'percentDone',
		'thread'
	],
	#category : #NLP
}

{ #category : #accessing }
VocabularyProgressAnnouncement >> percentDone [
	^ percentDone
]

{ #category : #accessing }
VocabularyProgressAnnouncement >> percentDone: anObject [
	percentDone := anObject
]

{ #category : #accessing }
VocabularyProgressAnnouncement >> thread [
	^ thread
]

{ #category : #accessing }
VocabularyProgressAnnouncement >> thread: anObject [
	thread := anObject
]
