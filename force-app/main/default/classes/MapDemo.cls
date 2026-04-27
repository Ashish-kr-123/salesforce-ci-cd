public class MapDemo {
    public static void mapDemoMethod(){
        Map<integer,string> instMap = new Map <integer,string>();
        instMap.put(1,'a');
        instMap.put(2,'b');
        instMap.put(3,'c');
        //system.debug('instMap ='+instMap);
        //instMap.remove(2);
        list<string> strlist = new list<string>();
        strlist = instMap.values();
        system.debug('instMap ='+instMap.keySet());
        
    }
}