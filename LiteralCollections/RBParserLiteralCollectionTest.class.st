Class {
	#name : 'RBParserLiteralCollectionTest',
	#superclass : 'TestCase',
	#category : 'LiteralCollections',
	#package : 'LiteralCollections'
}

{ #category : 'tests' }
RBParserLiteralCollectionTest >> testParseDynamicArray [


	self assert: { 1 . 2 } equals: #(1 2).
]

{ #category : 'tests' }
RBParserLiteralCollectionTest >> testParseDynamicSet [


	self assert: { ':Set' . 1 . 2 } equals: #(1 2) asSet.
]
