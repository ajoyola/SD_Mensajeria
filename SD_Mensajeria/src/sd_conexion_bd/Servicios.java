/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sd_conexion_bd;

/**
 *
 * @author joyce-adri
 */

import java.awt.Image;
import java.awt.Rectangle;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultListModel;
import javax.swing.ImageIcon;
import javax.imageio.ImageIO;
import javax.swing.DefaultListCellRenderer.UIResource;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.SwingConstants;
import org.apache.commons.codec.digest.DigestUtils;
import sd_mensajeria.usuario;

public class Servicios extends SQLQuery{ 
    //CONSULTAS A LA BASE
    
    public boolean validar_userName(String userName, String password, usuario u) throws IOException{
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            ////this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            //System.out.println("\n" + userName+ " " + password + "\n");
            this.consulta=this.conexion.prepareStatement("call buscar_por_user(\""+userName+"\",\""+password+"\");");
            this.datos=this.consulta.executeQuery();
            while(this.datos.next()){
                u.setID(datos.getInt("id"));
                u.setNombre(datos.getString("nombre"));
                u.setApellido(datos.getString("apellido"));
                u.setUser(userName);
                Blob imagen = datos.getBlob("foto");
                Image im = javax.imageio.ImageIO.read(imagen.getBinaryStream());
                if (im != null){
                
                ImageIcon i = new ImageIcon(im.getScaledInstance(100,120, 0));
                u.setFoto(i);
                
                }
                this.desconectar();
                return true;
            }
            this.desconectar();
            return false;  
        }  
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "--No se pudo conectar correctamente a la base de datos");
            System.exit(0);
        }
        return false;               
    }
          
    /**
      * Cargar la lista de los contactos del usuario de la base de datos y mostararla como lista en el tab contactos
      * lista es la lista donde se va a presentar los contactos del usuario
    */
    public void cargar_contactos(JList lista, String userName, int u_id){
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            ////this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call consultar_contactos(\""+userName+"\",\""+u_id+"\");");
            this.datos=this.consulta.executeQuery();
            DefaultListModel modelo = new DefaultListModel();
            while(this.datos.next()){
                modelo.addElement(datos.getString("nombre")+" "+datos.getString("apellido"));
            }
            lista.setModel(modelo);
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }        
    }
    
     public void registrar_usuario(String nombre, String apellido, String ciudad, String user, String pass,  String foto) throws ClassNotFoundException, SQLException, FileNotFoundException{
         
         
        //System.out.println(nombre + apellido + ciudad + user + pass + foto);
        this.conectar("localhost:3306", "mensajeria","root","");
         //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
        String sql = "{call registrar_usuario(?, ?, ?, ?, ?, ?)}";
        CallableStatement cstmt = conexion.prepareCall(sql);     
        cstmt.setString(1, nombre);
        cstmt.setString(2, apellido);
        cstmt.setString(3, ciudad);
        cstmt.setString(4, user);
        cstmt.setString(5, pass);
        File file= new File(foto);
        FileInputStream inputStream= new FileInputStream(file);
        
        cstmt.setBinaryStream(6, inputStream, (int) file.length());
        //cstmt.setBlob(6, inputStream);
        cstmt.execute();
           
    }
    //------------
    /**
      * funcion para obtener los datos del contacto del usuario del chat
    */
    public boolean dato_contacto(String nombre, String apellido, usuario u) throws IOException{
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call obtener_info_contacto(\""+nombre+"\",\""+apellido+"\");");
            this.datos=this.consulta.executeQuery();
            while(this.datos.next()){
                u.setID(datos.getInt("id"));
                u.setNombre(nombre);
                u.setApellido(apellido);
                u.setUser(datos.getString("user"));
                u.setEst_conexion(datos.getString("estado_conexion").charAt(0));
                u.setFecha_ult_conexion(datos.getTimestamp("fecha_ult_conexion"));
                Blob imagen = datos.getBlob("foto");
                if (imagen != null){
                    Image im = javax.imageio.ImageIO.read(imagen.getBinaryStream());
                    ImageIcon i = new ImageIcon(im.getScaledInstance(100,120, 0));
                    u.setFoto(i);                
                }
                return true;
            }return false;  
        }catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
            System.exit(0);
        }return false;              
    }
    
    /**
     * procedimiento que agrega a una lista el historial de mensajes del chat entre dos personas     
     */
    public void obtener_historial_msj(JList lista, int user_id, int contacto_id, String nombre){
        String str;
        //UIResource posicion = new UIResource();
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call obtener_historial_msj(\""+user_id+"\",\""+contacto_id+"\");");
            this.datos=this.consulta.executeQuery();
            DefaultListModel modelo = new DefaultListModel();
            while(this.datos.next()){
                if(datos.getInt("emisor_id")==user_id){
                    str ="Tu: "+datos.getString("texto");
                    modelo.addElement(str);  
                }else{
                    //posicion.setHorizontalAlignment(SwingConstants.CENTER);
                    str =nombre+": "+datos.getString("texto");
                    modelo.addElement(str);
                }
            }
            lista.setModel(modelo);
            //lista.setCellRenderer(posicion);
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }        
    }
    
     /**
     * procedimiento que permite al usuario crear un nuevo grupo   
     */
    public boolean registrar_grupo(String nombre,String descripcion, JList integrantes_lista, int creadorID) throws ClassNotFoundException{
        //registrar grupo
        int id_grupo=0;
        String nomb_apellido;
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            String sql = "{call registrar_grupo(?, ?, ?, ?)}";
            CallableStatement cstmt = conexion.prepareCall(sql);     
            cstmt.setString(1, nombre);
            cstmt.setString(2, descripcion);
            cstmt.setInt(3, creadorID);
            // Because parameter is OUT so register it
            cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
            cstmt.execute();//retorna el id del grupo por el parametro tipo out del procedure
            id_grupo = cstmt.getInt(4);
            if(id_grupo!=0){
                //agregar uno a uno los integrantes con el id respectivo (while)
                for(int i=0; i<integrantes_lista.getModel().getSize(); i++){
                    nomb_apellido = (String)integrantes_lista.getModel().getElementAt(i);
                    this.consulta=this.conexion.prepareStatement("call registrar_integrante(\""+nomb_apellido+"\",\""+creadorID+"\",\""+id_grupo+"\");");
                    this.consulta.executeUpdate();//ingresa uno a uno los integrantes
                }
            }else{
                JOptionPane.showMessageDialog(null, "No se pudo registrar el grupo");
            }            //no se ingreso el grupo
            this.conexion.close();
            return true;
        }catch (SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }        
        return false;    
    }
    
    //------------
    /**
      * funcion para obtener usuarios mas frecuentes del chat
    */
    public void usuarios_frecuentes(int user_id, JList topFiveList){
    int id_temp=0;
    String msj;
    ArrayList<Integer> id_user_conv = new ArrayList<>();     
    ArrayList<String> user_data = new ArrayList<>(); 
    try{
        this.conectar("localhost:3306", "mensajeria","root","");
        //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
        this.consulta=this.conexion.prepareStatement("call obtener_users_frecs(\""+user_id+"\");");
        this.datos=this.consulta.executeQuery();
        while(this.datos.next()){
            id_temp = datos.getInt("destinatario_id");
            id_user_conv.add(id_temp);
            //System.out.println(id_temp + "  contador: " +id_temp_count);

        } 

        DefaultListModel modelo = new DefaultListModel();

        for (int a=0; a<id_user_conv.size(); a++) {
            int id_userFav = id_user_conv.get(a);
            this.consulta=this.conexion.prepareStatement("call obtener_usuario_porID(\""+id_userFav+"\");");
            this.datos=this.consulta.executeQuery();
            while(this.datos.next()) {
                String nombre = datos.getString("nombre");
                String apellido = datos.getString("apellido");
                String usuario = datos.getString("user");
                user_data.add(nombre + " " + apellido + " @" + usuario);
            }
        }
        for (int b=0; b<user_data.size();b++) {
            modelo.addElement(user_data.get(b));
        }
        topFiveList.setModel(modelo);          
    }
    catch (ClassNotFoundException | SQLException ex) {
        Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
        JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
    }        
}
        
    public void buscarPorUser( int user_id, String texto, DefaultListModel model){
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call buscar_contacto_porUser(\""+user_id+"\",\""+texto+"\");");
            this.datos=this.consulta.executeQuery();
            while(this.datos.next()){
                model.addElement(datos.getString("nombreCompleto") +"    >>> "+" User: "+datos.getString("user"));
            }
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }        
    }
    
    public void buscarPorCiudad( int user_id, String texto, DefaultListModel model){
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call buscar_contacto_porCiudad(\""+user_id+"\",\""+texto+"\");");
            this.datos=this.consulta.executeQuery();
            while(this.datos.next()){
                model.addElement(datos.getString("nombreCompleto") +"    >>> "+" Ciudad: "+datos.getString("ciudad"));
            }
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }        
    }
    
    public void cargar_chats_grupo(JList chat_lista, int user_id){
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call consultar_chatsEnGrupo(\""+user_id+"\");");
            this.datos=this.consulta.executeQuery();
            DefaultListModel modelo = new DefaultListModel();
            while(this.datos.next()){
                modelo.addElement(datos.getString("nombre"));
            }
            chat_lista.setModel(modelo);
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        } 
    }
    
    public void cargar_chats_personales(JList lista, int user_id){
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            //this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call consultar_chatsPersonales(\""+user_id+"\");");
            this.datos=this.consulta.executeQuery();
            DefaultListModel modelo = new DefaultListModel();
            while(this.datos.next()){
                modelo.addElement(datos.getString("nombreCompleto"));
            }
            lista.setModel(modelo);
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        } 
    }
    
    public void obtener_historial_ChatsGrupo(JList lista, int user_id, String nombre_grupo){
        String str;
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            ////this.conectar("192.168.43.21:3306", "mensajeria","mensajeria","1234");
            this.consulta=this.conexion.prepareStatement("call historial_chatsEnGrupo(\""+user_id+"\",\""+nombre_grupo+"\");");
            this.datos=this.consulta.executeQuery();
            DefaultListModel modelo = new DefaultListModel();
            while(this.datos.next()){
                if(datos.getInt("emisor_id")==user_id){
                    str ="Tu: "+datos.getString("texto");
                    modelo.addElement(str);  
                }else{
                    //posicion.setHorizontalAlignment(SwingConstants.CENTER);
                    str =datos.getString("nombreCompleto")+": "+datos.getString("texto");
                    modelo.addElement(str);
                }
            }
            lista.setModel(modelo);
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }        
    }
    /**
      * funcion para obtener ultimos chats del usuario
    */
    public void ultimos_msjs(int user_id, JList msjList){
        int id_dest=0;
        String msj;
        ArrayList<Integer> id_user_lastconv = new ArrayList<>();     
        ArrayList<String> msjs = new ArrayList<>(); 
        ArrayList<String> msjUser = new ArrayList<>();
        try{
            this.conectar("localhost:3306", "mensajeria","root","");
            this.consulta=this.conexion.prepareStatement("call obtener_ultimos_msj(\""+user_id+"\");");
            this.datos=this.consulta.executeQuery();
            while(this.datos.next()){
                id_dest = datos.getInt("destinatario_id");
                msj = datos.getString("texto");
                id_user_lastconv.add(id_dest);
                msjs.add(msj);
                System.out.println(id_dest);
                System.out.println(msj);
            } 
            
            DefaultListModel modelo = new DefaultListModel();
            
            for (int a=0; a<id_user_lastconv.size(); a++) {
                int id_user = id_user_lastconv.get(a);
                this.consulta=this.conexion.prepareStatement("call obtener_usuario_porID(\""+id_user+"\");");
                this.datos=this.consulta.executeQuery();
                while(this.datos.next()) {
                    //String nombre = datos.getString("nombre");
                    //String apellido = datos.getString("apellido");
                    String usuario = datos.getString("user");
                    msjUser.add(a+1 + ")  "+msjs.get(a) + "   - @" + usuario);
                }
            }
            for (int b=0; b<msjUser.size();b++) {
                modelo.addElement(msjUser.get(b));
            }
            msjList.setModel(modelo);      
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }
    }
    
    public boolean ingresarNuevoMensaje(int emiID, int destID, char tipoGrupo, Date fechaMensaje, String mensaje, int gID){
        try{
            //this.conectar("localhost:3306", "mensajeria","root","12345");
            this.conectar("localhost:3306", "mensajeria","root","");
            this.consulta=this.conexion.prepareStatement("call ingresarMensaje(\""+emiID+"\",\""+destID+"\",\""+tipoGrupo+"\",\""+fechaMensaje+"\",\""+mensaje+"\",\""+gID+"\");");
            this.datos=this.consulta.executeQuery();
            return true;
        }
        catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Servicios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "No se pudo conectar correctamente a la base de datos");
        }
        return false; 
    }
    
}
