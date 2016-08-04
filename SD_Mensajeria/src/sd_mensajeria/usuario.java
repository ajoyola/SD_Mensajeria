/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sd_mensajeria;

import java.awt.Image;
import java.sql.Timestamp;
import javax.swing.ImageIcon;

/**
 *
 * @author JoycePC
 */
public class usuario {
    private int ID;
    public String nombre;
    public String apellido;
    public String user;
    public String ciudad;
    public char est_conexion;
    public Timestamp fecha_ult_conexion;
    public ImageIcon foto;

    public usuario() {
    }

    public usuario(String nombre, String apellido, String user, String ciudad) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.user = user;
        this.ciudad = ciudad;
    }
    public char getEst_conexion() {
        return est_conexion;
    }

    public void setEst_conexion(char est_conexion) {
        this.est_conexion = est_conexion;
    }

    public Timestamp getFecha_ult_conexion() {
        return fecha_ult_conexion;
    }

    public void setFecha_ult_conexion(Timestamp fecha_ult_conexion) {
        this.fecha_ult_conexion = fecha_ult_conexion;
    }
    
    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public ImageIcon getFoto() {
        return foto;
    }

    public void setFoto(ImageIcon foto) {
        this.foto = foto;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
    
    
}
