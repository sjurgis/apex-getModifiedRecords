public class xu {
    
    public static map<id, sobject> getModifiedRecords( map<id, sobject> nm, map<id, sobject> om, set<string> fields){
        return getModifiedRecords ( nm, om, fields, new map<id, sobject>() );
    }
    
    public static map<id, sobject> getModifiedRecords( map<id, sobject> nm, map<id, sobject> om, set<string> fields, map<id, sobject> ret ){
        for ( sobject n: nm.values() ){
            map<string, object> nv = n.getPopulatedFieldsAsMap();
            set<string> modifiedFields = getModifiedFields ( nv, om.get(n.id).getPopulatedFieldsAsMap(), new set<string>(fields) );
            if ( ! modifiedFields.isEmpty() ){
                if ( ret.containsKey( n.id ) )
                    for ( string s : fields )
                    	ret.get(n.id).put(s, nv.get(s) );
                else
                    ret.put( n.id, n );
            }   
        }    
        return ret;
    }
    
    static set<string> getModifiedFields( map<string, object> nm, map<string, object> om, final set<string> fields ){
        for (string s: fields){
            if ( nm.get(s) == om.get(s) )
                fields.remove(s);
        }        
        return fields;
    }
}