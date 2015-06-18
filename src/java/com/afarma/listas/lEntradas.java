/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.listas;
import java.sql.Date;

/**
 *
 * @author Erick Medeiros
 */
public class lEntradas {

    private int idEntrada;
    private String dataEntrada;
    private int idFornecedor;
    private int idFuncionario;
    private String nome;
    private int nItens;
    private double tTotal;


public lEntradas(){
    setIdEntrada(0);
    setIdFornecedor(0);
    setNome("");
    setnItens(0);
    settTotal(0);
}

    /**
     * @return the idEntrada
     */
    public int getIdEntrada() {
        return idEntrada;
    }

    /**
     * @param idEntrada the idEntrada to set
     */
    public void setIdEntrada(int idEntrada) {
        this.idEntrada = idEntrada;
    }

    /**
     * @return the dataEntrada
     */
    public String getDataEntrada() {
        return dataEntrada;
    }

    /**
     * @param dataEntrada the dataEntrada to set
     */
    public void setDataEntrada(String dataEntrada) {
        this.dataEntrada = dataEntrada;
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
     * @return the idFuncionario
     */
    public int getIdFuncionario() {
        return idFuncionario;
    }

    /**
     * @param idFuncionario the idFuncionario to set
     */
    public void setIdFuncionario(int idFuncionario) {
        this.idFuncionario = idFuncionario;
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
     * @return the nItens
     */
    public int getnItens() {
        return nItens;
    }

    /**
     * @param nItens the nItens to set
     */
    public void setnItens(int nItens) {
        this.nItens = nItens;
    }

    /**
     * @return the tTotal
     */
    public double gettTotal() {
        return tTotal;
    }

    /**
     * @param tTotal the tTotal to set
     */
    public void settTotal(double tTotal) {
        this.tTotal = tTotal;
    }


}
