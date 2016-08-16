package sd_activeMQ;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueReceiver;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnection;
import javax.jms.TopicConnectionFactory;
import javax.jms.TopicSession;
import javax.jms.TopicSubscriber;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.swing.JList;
import sd_mensajeria.GUI.Chat;
import sun.java2d.SurfaceData;


public class ReceiverGrupo implements MessageListener{

    String nombre = null;
    String selector = null;
    private QueueConnection queueConn = null;    
    private QueueSession queueSession = null;
    private Queue queue = null;
    ArrayList <Chat> chatsActivos = new ArrayList <Chat> ();
    
    
    public ReceiverGrupo(String nombre,  ArrayList <Chat> chats) throws Exception  {
        
        this.nombre = nombre;
        this.selector = ("destinatario = '" + nombre + "' ");
        chatsActivos = chats; //seteo lista de chats activos para poder mostrar mensajes
        
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

        TopicSubscriber subscriber = session.createSubscriber(messageTopic);

        subscriber.setMessageListener(this);

        tCon.start();
        
		
	}
    
    public Chat searchChat(String Contacto){
        for(Chat c: chatsActivos){
            if(c.getContacto().getUser().equals(Contacto)) //si encuentra chat abierto dirigido al emisor del mensaje
            {
                return c;
            }           
        }
        return null; // se debe retornar nuevo chat con datos de construcutor de chat
    }
    
    @Override
     public void onMessage(Message message) {

        
    try {
         // Get the data from the message
         TextMessage msg = (TextMessage)message;
         // Split el mensaje para sacar el emisor userName
         //String[] mensajeSplit = msg.getText().split(",,,");
         // print the message
//        System.out.println("Emisor: " + mensajeSplit[0] + "\n" + "Mensaje: " + mensajeSplit[1]);
         System.out.println("Emisor: " + "Mensaje: " + msg.getText());
        //busco chat abierto
        //Chat c = searchChat( mensajeSplit[0]); // envío el emisor del chat
        Chat c = searchChat("lorenita"); // envío el emisor del chat
        c.addChatToList("lorenita", msg.getText()); // agrego mensaje a la lista
        c.setVisible(true);
        
     } catch (JMSException jmse) {
         jmse.printStackTrace(); 
         System.exit(1);
      } catch (Exception jmse) {
         jmse.printStackTrace(); 
         System.exit(1);
      }
    }
}