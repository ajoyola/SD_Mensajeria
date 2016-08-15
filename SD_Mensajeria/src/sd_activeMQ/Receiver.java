package sd_activeMQ;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Properties;
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
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.swing.JList;
import sd_mensajeria.GUI.Chat;
import sun.java2d.SurfaceData;


public class Receiver implements MessageListener{

    String nombre = null;
    String selector = null;
    private QueueConnection queueConn = null;    
    private QueueSession queueSession = null;
    private Queue queue = null;
    ArrayList <Chat> chatsActivos = new ArrayList <Chat> ();
    
    
    public Receiver(String nombre,  ArrayList <Chat> chats) throws Exception  {
        
        this.nombre = nombre;
        this.selector = ("destinatario = '" + nombre + "' ");
        chatsActivos = chats; //seteo lista de chats activos para poder mostrar mensajes
        
        Properties env = new Properties();
        env.put(Context.INITIAL_CONTEXT_FACTORY,
                        "org.apache.activemq.jndi.ActiveMQInitialContextFactory");
        env.put(Context.PROVIDER_URL, "tcp://localhost:61616");
        env.put("queue.queueSampleQueue","Queue");
        // get the initial context
        InitialContext ctx = new InitialContext(env);

        // lookup the queue object
        queue = (Queue) ctx.lookup("queueSampleQueue");

        // lookup the queue connection factory
        QueueConnectionFactory connFactory = (QueueConnectionFactory) ctx.lookup("QueueConnectionFactory");

        // create a queue connection
        queueConn = connFactory.createQueueConnection();

        // create a queue session
        queueSession = queueConn.createQueueSession(false,Session.AUTO_ACKNOWLEDGE);

        // create a queue receiver
        QueueReceiver queueReceiver = queueSession.createReceiver(queue, selector);
        //QueueReceiver queueReceiver = queueSession.createReceiver(queue, "destinatario = 'Angely' ");

        // start the connection
        queueConn.start();

         // Create the message listener
        queueReceiver.setMessageListener(this);

		
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
         String[] mensajeSplit = msg.getText().split(",,,");
         // print the message
        System.out.println("Emisor: " + mensajeSplit[0] + "\n" + "Mensaje: " + mensajeSplit[1]);
        //busco chat abierto
        Chat c = searchChat( mensajeSplit[0]); // envío el emisor del chat
        c.addChatToList(mensajeSplit[1]); // agrego mensaje a la lista
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