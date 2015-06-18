/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.listas;

/**
 *
 * @author Erick Medeiros
 */
public class lCliente {
    private int id_Cliente;
    private String nome;
    private String email;
    private int idPessoa;

    public lCliente(int idCliente, String nome, String email, int idPessoa){
     this.id_Cliente    = idCliente;
     this.nome          = nome;
     this.email         = email;
     this.idPessoa      = idPessoa;
    }

    public lCliente(){

    }

    /**
     * @return the id_Cliente
     */
    public int getId_Cliente() {
        return id_Cliente;
    }

    /**
     * @param id_Cliente the id_Cliente to set
     */
    public void setId_Cliente(int id_Cliente) {
        this.id_Cliente = id_Cliente;
    }

    /**
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the idPessoa
     */
    public int getIdPessoa() {
        return idPessoa;
    }

    /**
     * @param idPessoa the idPessoa to set
     */
    public void setIdPessoa(int idPessoa) {
        this.idPessoa = idPessoa;
    }



}
