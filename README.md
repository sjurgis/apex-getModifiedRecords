## Get Modified Records

API version 37.0.

Makes use of new Apex methods sobject.getPopulatedFieldsAsMap().

The aim of this class is to provide easy way to get records with specified
field modified. Useful in triggers if you found yourself doing a lot of:

```java
for ( account a: trigger.new )
    	if ( a.name != trigger.oldMap.get( a.id ).name )
        	system.debug('name '+ a.name );
```
          
Instead, why not use this way:

```java
trigger AccountTrigger on Account (before update) {
    system.debug(
      xu.getModifiedRecords ( 
        trigger.newMap, 
        trigger.oldMap, 
        new set<string> {'Name', 'Description' },
        new set<string> {'Id', 'Name' }) );
}
```
This will return Id and Name fields, whenever Name or Description fields have been modified. Useful to use with Platform Events where you just want to publish deltas. You can store fields in some custom settings to provide maximum configurability.

**Important**: This doesn't work with system fields like CreatedDate as you cannot construct sobject with this field specified.

