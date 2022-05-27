package mappers;
import java.io.IOException;

import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;   
import org.apache.hadoop.io.MapWritable;   
import org.apache.hadoop.io.Text;    
import org.apache.hadoop.mapred.MapReduceBase;    
import org.apache.hadoop.mapred.Mapper;    
import org.apache.hadoop.mapred.OutputCollector;    
import org.apache.hadoop.mapred.Reporter;  
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

//sacar el total de tipos de empleo por año
//sacar el total de ocupaciones por año


public class OccupationsMapper extends MapReduceBase implements Mapper<LongWritable,Text,IntWritable,FloatWritable> { 
    /*
     * Mapper <LongWritable,Text,Text,MapWritable>: Classifies data
     * 
     * Inputs:
     * 		LongWritable: Id for Batch that is being processed from dataset
     * 		Text: Text format for each line from batch, see runner
     * Outputs:
     * 		IntWritable: Integer for year
     * 		FloatWritable: Float for quantity of jobs
     * 
     * Shuffle: joins all years together
     */
	
	
    public void map(LongWritable key, Text value, OutputCollector<IntWritable,FloatWritable> output, Reporter reporter) throws IOException{    
        String line = value.toString();
        String values[] = line.split(",");
        String year = values[0].split("/")[2];        
        IntWritable intYear = new IntWritable(Integer.valueOf(year));
        FloatWritable amount = new FloatWritable(Integer.valueOf(values[1]));
        
        output.collect(intYear, amount); 
    }
}
