Extension { #name : 'OCTypingVisitor' }

{ #category : '*LiteralCollections' }
OCTypingVisitor >> visitLiteralCollectionNode: aLiteralNode [

	super visitLiteralCollectionNode: aLiteralNode.
	self typeNode: aLiteralNode with: aLiteralNode collectionClass
]
