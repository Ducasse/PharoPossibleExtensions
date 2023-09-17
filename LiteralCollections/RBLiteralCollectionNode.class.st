Class {
	#name : 'RBLiteralCollectionNode',
	#superclass : 'RBArrayNode',
	#instVars : [
		'collectionClass'
	],
	#category : 'LiteralCollections',
	#package : 'LiteralCollections'
}

{ #category : 'accessing' }
RBLiteralCollectionNode >> collectionClass [

	^ collectionClass
]

{ #category : 'accessing' }
RBLiteralCollectionNode >> collectionClass: anObject [

	collectionClass := anObject
]
