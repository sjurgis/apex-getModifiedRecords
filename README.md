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
    system.debug( 'modified '+ xu.getModifiedRecords ( trigger.newMap, trigger.oldMap, new set<string> {'Name', 'Description' } ).keySet()  );
}
```

Simple test case:

```java
delete[select id from account];
for ( integer i = 0; i<4; i++)
    insert new account ( 
        name = 'number '+i, 
        tradestyle = 'none', 
        description = 'test-description');

account[] acc = [select id, name,description from account limit 4];
acc[0].name = 'bob';
acc[1].description = 'buy-a-lot';
acc[2].tradestyle = 'swag';
update acc;
```

Will output:

`10:32:04:499 USER_DEBUG [7]|DEBUG|modified {0012400000gfLgxAAE, 0012400000gfLgyAAE}`


Potential for improvements:
* Return map< string, set<id> > where string is field name which can then be easily iterated.
