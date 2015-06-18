/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

/**
 *
 * @author Erick Medeiros
 */
public class PessoaJuridica extends Pessoa {
    private String CNPJ;
    private String razaoSocial;

    /**
     * @return the CNPJ
     */
    public String getCNPJ() {
        return CNPJ;
    }

    /**
     * @param CNPJ the CNPJ to set
     */
    public void setCNPJ(String pCNPJ) {
        CNPJ = pCNPJ;
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
    public void setRazaoSocial(String pNome) {
        razaoSocial = pNome;
    }
}
