/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

/**
 *
 * @author Erick Medeiros
 */
public class Pessoa {
    private int idPessoa;
    private String nome;
    private String telefone;
    private String email;

    /**
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String pNome) {
        nome = pNome;
    }

    /**
     * @return the telefone
     */
    public String getTelefone() {
        return telefone;
    }

    /**
     * @param telefone the telefone to set
     */
    public void setTelefone(String pTelefone) {
        this.telefone = pTelefone;
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
    public void setEmail(String pEmail) {
        this.email = pEmail;
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
