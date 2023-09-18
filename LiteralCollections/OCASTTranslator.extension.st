Extension { #name : 'OCASTTranslator' }

{ #category : '*LiteralCollections' }
OCASTTranslator >> visitLiteralCollectionNode: aLiteralCollectionNode [

	
	methodBuilder pushLiteralVariable: aLiteralCollectionNode collectionClass binding.
	self visitArrayNode: aLiteralCollectionNode.
	methodBuilder send: #withAll:
]
