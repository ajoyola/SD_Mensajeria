package sd_activeMQ;

import java.util.Properties;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.QueueSender;
import javax.jms.DeliveryMode;
import javax.jms.QueueSession;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.Topic;
import javax.jms.TopicConnection;
import javax.jms.TopicConnectionFactory;
import javax.jms.TopicPublisher;
import javax.jms.TopicSession;
import sd_mensajeria.usuario;

public class SenderGrupo {

    public String origen = null;
    
    public SenderGrupo(String origen) {
        this.origen = origen;
    }

	public void sendMessage(String msg) throws Exception {
		Properties env = new Properties();
		env.put(Context.INITIAL_CONTEXT_FACTORY,
				"org.apache.activemq.jndi.ActiveMQInitialContextFactory");
		env.put(Context.PROVIDER_URL, "tcp://localhost:61616");
		env.put("topic.topicSampleTopic", "Topic");
		// get the initial context
		InitialContext ctx = new InitialContext(env);
                
                Topic messageTopic = (Topic) ctx.lookup("topicSampleTopic");

                TopicConnectionFactory tConFactory = (TopicConnectionFactory) ctx.lookup("TopicConnectionFactory"); 

                TopicConnection tCon = tConFactory.createTopicConnection();

                TopicSession session = tCon.createTopicSession(
                  false, /* not a transacted session */
                  Session.AUTO_ACKNOWLEDGE 
                 );
                
                TopicPublisher publisher = session.createPublisher(messageTopic);

                TextMessage message = session.createTextMessage( msg);

                message.setText("Hello");
                publisher.publish(message);
               
                
                
                
	}
}