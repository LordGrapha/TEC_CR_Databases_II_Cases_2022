package reducers;
import java.io.IOException;    
import org.apache.hadoop.mapred.MapReduceBase;    
import org.apache.hadoop.mapred.OutputCollector;    
import org.apache.hadoop.mapred.Reducer;    
import org.apache.hadoop.mapred.Reporter;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.util.ArrayList;
import java.util.Iterator;    
import org.apache.hadoop.io.Text;

public class JsonReducer extends MapReduceBase implements Reducer<Text,Text,Text,Text> {	 
	
	static int key = 0;
	
	public void reduce(Text keyText, Iterator<Text> values, OutputCollector<Text,Text> output, Reporter reporter) throws IOException {    


		
		//  year+"-"+month +"-"+tag +"-" + action
//		{
//			  'age': '1',
//			  'gender': 'f',
//			  'year': 'year',
//			  'month': 'month',
//			}
		
		int people = 0;
		int genderF = 0;
		int genderM = 0;
		int age = 0;
		ArrayList<Integer> ages = new ArrayList<Integer>(); 
		int ageStand = 0;
			
		String[] parts = keyText.toString().split("-");
		String year = parts[0];
		String month = parts[1];
		
		try {
			
			while (values.hasNext()) {
				people++;
	
					
				String line = values.next().toString();
				JSONObject currentJson;
	
				currentJson = (JSONObject) new JSONParser().parse(line);
			
				
//				if(true) throw new Exception(currentJson.get("age").toString());
				
				int currentAge = Integer.parseInt(currentJson.get("age").toString());
				age += currentAge;
				ages.add(currentAge);
				
				if(currentJson.get("gender").toString().equalsIgnoreCase("female")) genderF++;
				else genderM++;
			}

			int avaregeAge = age / people;
			
			for(int i = 0; i < ages.size(); i++) {
				int resta = (ages.get(i) - avaregeAge);
				ageStand += resta*resta;
			}
			
			ageStand = ageStand / people;
			String m = ""+(genderM * 100.0 / people);
			String f = ""+(genderF * 100.0 / people);

			// String dataString = "{	'people':'"+ people + "',	'year':'"+ year +"', 'month':'"+ month +"',		'%M':'"+ m +"',		'%F':'"+ f + "',	'ageAv':'"+ ageAv +"',		'ageStand':'"+ ageStand+ "', 'profesion':'"+profesion+"'		    }";
			String dataString = ","+people+","+year+","+month+","+m+","+f+","+avaregeAge+","+ageStand+","+parts[2] +","+ parts[3];
				
			// #people, year, month, %M, %F, Age (mean), variance(age)
//			Text data = new Text(dataString);
			Text newKey = new Text((key++)+"");
			output.collect(newKey, new Text(dataString));
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			output.collect(keyText, new Text(e.toString()));
		} 

	}    
}
