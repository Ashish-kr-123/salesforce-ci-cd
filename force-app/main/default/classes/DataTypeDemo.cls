public class DataTypeDemo {
    Boolean a;
    public static void methodDemo(){
        
       Map<Integer, String> m1 = new Map<Integer, String>();
m1.put(1, 'First item');
m1.put(2, 'Second item');
Map<Integer, String> m2 = new Map<Integer, String>(m1);
// The map elements of m2 are copied from m1
System.debug(m2);
       
        
    } 
}