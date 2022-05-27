package common;

import java.io.* ;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class CsvReader {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) throws Exception {
		Map<String, ArrayList<String>> occupationsxtags = new HashMap<String, ArrayList<String>>();
		ArrayList<String> tags = new ArrayList<String>();
		Scanner sc = new Scanner(new File("C:\\tags_action.csv"));
		//parsing a CSV file into the constructor of Scanner class 
		sc.useDelimiter("\n");
		//setting comma as delimiter pattern
		sc.next();
		while (sc.hasNext()) {
			String values[] = sc.next().split(",");
	    	String occupation = values[0];
	    	
	    	for(int tag = 1; tag < values.length; tag++) {
	    		tags.add(values[tag]);
		    }
	    	occupationsxtags.put(occupation, (ArrayList<String>)tags.clone());
	    	tags.clear();
		}
		sc.close();
		//closes the scanner 
		System.out.println(occupationsxtags.get("Engineers"));
	}

}
