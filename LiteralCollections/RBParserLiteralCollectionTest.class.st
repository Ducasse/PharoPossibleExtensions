Class {
	#name : 'RBParserLiteralCollectionTest',
	#superclass : 'TestCase',
	#category : 'LiteralCollections',
	#package : 'LiteralCollections'
}

{ #category : 'tests' }
RBParserLiteralCollectionTest >> testDynamicArrayIsWorking [

	self assert: { } equals: #().
	self assert: { 1 . 2 } equals: #(1 2).
]

{ #category : 'tests' }
RBParserLiteralCollectionTest >> testParseDynamicArrayAgain [

	| arrayNode |
	arrayNode := (RBParserLiteralCollection parseExpression: '{  1 . 2 }').
	self assert: arrayNode class equals: RBArrayNode.
	self assert: arrayNode statements first value equals: 1.
	self assert: arrayNode statements second value equals: 2.
]

{ #category : 'tests' }
RBParserLiteralCollectionTest >> testParseDynamicSet [

	| literalCollectionNode |
	literalCollectionNode := (RBParserLiteralCollection parseExpression: '{ :Set  1 . 2 }').
	self assert: literalCollectionNode class  equals: RBLiteralCollectionNode.
]
