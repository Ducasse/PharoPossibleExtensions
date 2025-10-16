Extension { #name : 'ASTTypingVisitor' }

{ #category : '*LiteralCollections' }
ASTTypingVisitor >> visitLiteralCollectionNode: aLiteralNode [

	super visitLiteralCollectionNode: aLiteralNode.
	self typeNode: aLiteralNode with: aLiteralNode collectionClass
]
