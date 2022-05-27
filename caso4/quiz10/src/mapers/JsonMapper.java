package mapers;

import java.io.IOException;    
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.mapred.MapReduceBase;    
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;    
import org.apache.hadoop.mapred.Reporter;
import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.apache.hadoop.io.Text;

public class JsonMapper extends MapReduceBase implements Mapper<LongWritable,Text,Text,Text> { 

    public void map(LongWritable key, Text value, OutputCollector<Text, Text> output, Reporter reporter) throws  JSONException, IOException {    
    	try {    
    		

    		String line = value.toString();// Pasear a Json
			JSONObject currentJson = (JSONObject) new JSONParser().parse(line);
			
			String age = currentJson.get("age").toString();
			String gender = currentJson.get("gender").toString();
			String posttime = currentJson.get("posttime").toString();
			String tag1 = currentJson.get("tag1").toString();
			String action = currentJson.get("actiontype").toString();
			String[] parts = posttime.split("-");
			String year = parts[0];
			String month = parts[1];

			Text Key = new Text(year+"-"+month +"-"+tag1 +"-" + action);
			String js = "{\"age\":\""+ age + "\",	\"gender\":\""+ gender +"\", \"year\":\""+ year +"\",\"month\":\""+ month+ "\"}";
			Text data = new Text (js);

			// Salida
			output.collect(Key, data);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	
    }
}
