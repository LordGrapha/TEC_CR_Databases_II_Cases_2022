package mapr;

import java.io.IOException;   
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.MapWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.FileInputFormat;    
import org.apache.hadoop.mapred.FileOutputFormat;    
import org.apache.hadoop.mapred.JobClient;    
import org.apache.hadoop.mapred.JobConf;    
import org.apache.hadoop.mapred.TextInputFormat;    
import org.apache.hadoop.mapred.TextOutputFormat;

import mappers.OccupationsMapper;
import reducers.OccupationsReducer;


public class maprunner {
	public static void main(String[] args) throws IOException{  
	    JobConf conf = new JobConf(mapr.maprunner.class);    
	    conf.setJobName("Occupations MapReduce");    
	    conf.setOutputKeyClass(IntWritable.class);      
	    conf.setOutputValueClass(FloatWritable.class);
	    conf.setMapOutputKeyClass(IntWritable.class);
	    conf.setMapOutputValueClass(FloatWritable.class);	    
	    conf.setMapperClass(OccupationsMapper.class); 
	    conf.setReducerClass(OccupationsReducer.class);         
	    conf.setInputFormat(TextInputFormat.class);  // el formato de la fuente  
	    conf.setOutputFormat(TextOutputFormat.class);   // el formato con que lo paso al mapper
	    conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem");
	    FileInputFormat.setInputPaths(conf,new Path("/data/sample.db"));    
	    FileOutputFormat.setOutputPath(conf,new Path("/metaverse"));
	    JobClient.runJob(conf); // indicamos a yarn que ponga en cola este job
	}    
}
