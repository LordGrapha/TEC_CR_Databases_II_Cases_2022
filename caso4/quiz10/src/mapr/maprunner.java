package mapr;

import java.io.IOException;   
import org.apache.hadoop.fs.Path;    
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.FileInputFormat;    
import org.apache.hadoop.mapred.FileOutputFormat;    
import org.apache.hadoop.mapred.JobClient;    
import org.apache.hadoop.mapred.JobConf;    
import org.apache.hadoop.mapred.TextInputFormat;    
import org.apache.hadoop.mapred.TextOutputFormat;
import mapers.JsonMapper;
import reducers.JsonReducer;


public class maprunner {
	public static void main(String[] args) throws IOException{    
	    JobConf conf = new JobConf(mapr.maprunner.class);    
	    conf.setJobName("Quiz 9 y 10");    
	    conf.setOutputKeyClass(Text.class); // Key Metaverso y anio
	    conf.setOutputValueClass(Text.class);
	    conf.setMapperClass(JsonMapper.class);
	    conf.setReducerClass(JsonReducer.class);       
	    conf.setInputFormat(TextInputFormat.class);  
	    conf.setOutputFormat(TextOutputFormat.class);
	    conf.set("fs.hdfs.impl", "org.apache.hadoop.hdfs.DistributedFileSystem");
	    FileInputFormat.setInputPaths(conf,new Path("/datainput/sample.db")); 
	    FileOutputFormat.setOutputPath(conf,new Path("/dataoutput"));
	    JobClient.runJob(conf);
	}    
}
