/**
 * @description: Class to filter ContentDocumentLink collections
 * @author: Reirysson Costa
 */
public with sharing class ContentDocumentLinkFilter {

    public Set<Id> byOpportunities( List<ContentDocumentLink> contentDocuments ) {

        Set<Id> opportunitiesIdsWithContentDocument = new Set<Id>();

        for( ContentDocumentLink contentDocumentLink : contentDocuments ) {
        
            if(contentDocumentLink.LinkedEntityId == null) continue;
            
            opportunitiesIdsWithContentDocument.add(contentDocumentLink.LinkedEntityId);
        }

        return opportunitiesIdsWithContentDocument;
    }
}