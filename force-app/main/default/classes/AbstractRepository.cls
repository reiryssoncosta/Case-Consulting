/*
 * @description: Abstract repository basead in https://sfdclesson.com/2023/12/13/code-like-a-pro-with-apex-design-patterns/
 * @author Reirysson Costa
**/
public abstract class AbstractRepository {

    virtual
    public SObject save (SObject aggregate) {

        if (aggregate == null) return null;

        upsert aggregate;

        return aggregate;
    }

    virtual
    public List<SObject> save (List<SObject> aggregates) {

        if (aggregates == null) return new List<SObject>();

        if (aggregates.isEmpty()) return aggregates;

        upsert aggregates;

        return aggregates;

    }
    
}