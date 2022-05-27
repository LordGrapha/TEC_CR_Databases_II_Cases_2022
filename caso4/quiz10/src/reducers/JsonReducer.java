package reducers;
import java.io.IOException;    
import org.apache.hadoop.mapred.MapReduceBase;    
import org.apache.hadoop.mapred.OutputCollector;    
import org.apache.hadoop.mapred.Reducer;    
import org.apache.hadoop.mapred.Reporter;
import java.util.Iterator;    
import org.apache.hadoop.io.Text;

public class JsonReducer extends MapReduceBase implements Reducer<Text,Text,Text,Text> {	        
	public void reduce(Text keyText, Iterator<Text> values, OutputCollector<Text,Text> output, Reporter reporter) throws IOException {    
		int time = 0;
		int coin = 0;
		
		while (values.hasNext()) {
			String line = values.next().toString();
			String[] parts = line.split(",");
			time += Integer.parseInt(parts[0]);
			coin += Integer.parseInt(parts[1]);
		}
		String timetext = time + "";//Lo paso a texto para cvs
		String cointext = coin + "";
		
		Text data = new Text(timetext + "," + cointext);
	
		output.collect(keyText, data);
	}    
}
