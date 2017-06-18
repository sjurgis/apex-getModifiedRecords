public class xu {
	public static sobject[] getModifiedRecords(
		map<id, sobject> newMap,
		map<id, sobject> oldMap,
		set<string> triggerFields,
		set<string> returnFields ){
		sobject[] ret;
		for ( sobject i : newMap.values() ) {
			map<string, object> newFields = i.getPopulatedFieldsAsMap();
			map<string, object> oldFields = oldMap.get(i.id).getPopulatedFieldsAsMap();
			sobject sob = getRecord( i, newFields, oldFields, new set<string>( triggerFields ), returnFields);
			if ( sob != null ) {
				if ( ret == null ) ret = new sobject[] {};
				ret.add( sob );
			}
		}
		return ret;
	}
	static sobject getRecord(
		sobject i,
		map<string, object> newFields,
		map<string, object> oldFields,
		final set<string> fields,
		set<string> returnFields){
		SObject sob;
		for ( string s : fields ) {
			if ( newFields.get(s) == oldFields.get(s) ) {
				fields.remove(s);
			} else {
				if ( sob == null ) sob = i.getSObjectType().newSObject();
				for ( string j : returnFields )
					sob.put( j, newFields.get(j));
			}
		}
		return sob;
	}
}
