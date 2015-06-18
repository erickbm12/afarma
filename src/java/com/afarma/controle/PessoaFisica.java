/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.controle;

/**
 *
 * @author Erick Medeiros
 */
public class PessoaFisica extends Pessoa {
    private String CPF;
    private String RG;

    /**
     * @return the CPF
     */
    public String getCPF() {
        return CPF;
    }

    /**
     * @param CPF the CPF to set
     */
    public void setCPF(String pCPF) {
        this.CPF = pCPF;
    }

    /**
     * @return the RG
     */
    public String getRG() {
        return RG;
    }

    /**
     * @param RG the RG to set
     */
    public void setRG(String pRG) {
        this.RG = pRG;
    }
}
