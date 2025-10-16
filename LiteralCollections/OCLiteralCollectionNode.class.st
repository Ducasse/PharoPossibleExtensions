Class {
	#name : 'OCLiteralCollectionNode',
	#superclass : 'OCArrayNode',
	#instVars : [
		'collectionClass'
	],
	#category : 'LiteralCollections',
	#package : 'LiteralCollections'
}

{ #category : 'accessing' }
OCLiteralCollectionNode >> acceptVisitor: aProgramNodeVisitor [
	^ aProgramNodeVisitor visitLiteralCollectionNode: self
]

{ #category : 'accessing' }
OCLiteralCollectionNode >> collectionClass [

	^ collectionClass
]

{ #category : 'accessing' }
OCLiteralCollectionNode >> collectionClass: anObject [

	collectionClass := anObject
]
