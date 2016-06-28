## Get Modified Records

The aim of this class is to provide easy way to get records with specified
field modified. Useful in triggers if you found yourself doing a lot of:

`for ( account a: trigger.new )
    	if ( a.name != trigger.oldMap.get( a.id ).name )
        	system.debug('name '+ a.name );`
          
Instead, why not use this way:

`system.debug( 'modified '+ xu.getModifiedRecords ( 
  trigger.newMap, 
  trigger.oldMap, 
  new set<string> {'Name', 'Description' } ).keySet()  );`
  
Which will return:
`10:32:04:499 USER_DEBUG [7]|DEBUG|modified {0012400000gfLgxAAE, 0012400000gfLgyAAE}`