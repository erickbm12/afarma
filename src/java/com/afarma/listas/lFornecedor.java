/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.listas;

/**
 *
 * @author Erick Medeiros
 */
public class lFornecedor {

    private int idFornecedor;
    private String nome;
    private String razaoSocial;
    private String email;    
    private int idPessoa;    

    public lFornecedor(int idFornecedor, String nome, String email, int idPessoa){
     this.idFornecedor    = idFornecedor;
     this.nome            = nome;
     this.email           = email;
     this.idPessoa        = idPessoa;
    }

    public lFornecedor(){

    }

    /**
     * @return the idFornecedor
     */
    public int getIdFornecedor() {
        return idFornecedor;
    }

    /**
     * @param idFornecedor the idFornecedor to set
     */
    public void setIdFornecedor(int idFornecedor) {
        this.idFornecedor = idFornecedor;
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
     * @return the razaoSocial
     */
    public String getRazaoSocial() {
        return razaoSocial;
    }

    /**
     * @param razaoSocial the razaoSocial to set
     */
    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
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
