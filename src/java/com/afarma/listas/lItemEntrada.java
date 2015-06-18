/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.listas;
/**
 *
 * @author Erick Medeiros
 */
public class lItemEntrada {
    private int idProduto;
    private String nome;
    private int quantidade;
    private double valor_compra;
    private double total_itens;


    public lItemEntrada(int idProduto, String nome, int quantidade, double valor_compra  ){
     this.idProduto = idProduto;
     this.nome      = nome;
     this.quantidade= quantidade;
     this.valor_compra=valor_compra;
    }

public lItemEntrada(){

    }
    /**
     * @return the idProduto
     */
    public int getIdProduto() {
        return idProduto;
    }

    /**
     * @param idProduto the idProduto to set
     */
    public void setIdProduto(int idProduto) {
        this.idProduto = idProduto;
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
     * @return the quantidade
     */
    public int getQuantidade() {
        return quantidade;
    }

    /**
     * @param quantidade the quantidade to set
     */
    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    /**
     * @return the valor_compra
     */
    public double getValor_compra() {
        return valor_compra;
    }

    /**
     * @param valor_compra the valor_compra to set
     */
    public void setValor_compra(double valor_compra) {
        this.valor_compra = valor_compra;
    }

    /**
     * @return the total_itens
     */
    public double getTotal_itens() {
        return this.quantidade*this.valor_compra;
    }



}
