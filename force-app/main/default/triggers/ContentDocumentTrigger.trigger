trigger ContentDocumentTrigger on ContentDocumentLink (after insert) {
    new ContentDocumentHandler().run();
}