Extension { #name : 'EFFormatter' }

{ #category : '*LiteralCollections' }
EFFormatter >> visitLiteralCollectionNode: aLiteralCollectionNode [
	self 
		bracketWith: '{}' 
		around: [ 
			codeStream space; nextPutAll: ':', aLiteralCollectionNode collectionClass name. 
			self formatArray: aLiteralCollectionNode ]
]
