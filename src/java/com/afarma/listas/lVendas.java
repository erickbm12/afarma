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
public class lVendas {

    private int idVenda;
    private String dataVenda;
    private int idCliente;
    private int idFuncionario;
    private String nome;
    private int nItens;
    private double tItens;
    private double desconto;


public lVendas(){
    this.idVenda = 0;
    this.idCliente = 0;
    this.nome = "";
    this.nItens = 0;
    this.tItens = 0;
    this.desconto = 0;

}


    /**
     * @return the dataVenda
     */
    public String getDataVenda() {
        return dataVenda;
    }

    /**
     * @param dataVenda the dataVenda to set
     */
    public void setDataVenda(String dataVenda) {
        this.dataVenda = dataVenda;
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
     * @return the tItens
     */
    public double gettItens() {
        return this.tItens;
    }

    /**
     * @param tItens the tItens to set
     */
    public void settItens(double tItens) {
        this.tItens = tItens;
    }

    /**
     * @return the idVenda
     */
    public int getIdVenda() {
        return idVenda;
    }

    /**
     * @param idVenda the idVenda to set
     */
    public void setIdVenda(int idVenda) {
        this.idVenda = idVenda;
    }

    /**
     * @return the idCliente
     */
    public int getIdCliente() {
        return idCliente;
    }

    /**
     * @param idCliente the idCliente to set
     */
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    /**
     * @return the desconto
     */
    public double getDesconto() {
        return desconto;
    }

    /**
     * @param desconto the desconto to set
     */
    public void setDesconto(double desconto) {
        this.desconto = desconto;
    }

    /**
     * @return the tVendas
     */
    public double gettVendas() {
        return this.tItens-this.desconto;
    }


}
