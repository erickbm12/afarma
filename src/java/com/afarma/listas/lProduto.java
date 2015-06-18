/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.afarma.listas;

/**
 *
 * @author Erick Medeiros
 */
public class lProduto {
private int idProduto;
    private String nome;
    private String descricao;
    private Double valor_venda;
    private String lab;
    private int quantidade;

public lProduto(int idProduto, String nome, String descricao, Double valor_venda ) {

this.idProduto  = idProduto;
this.nome       = nome;
this.descricao  = descricao;
this.valor_venda= valor_venda;

}

public lProduto() {

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
     * @return the descricao
     */
    public String getDescricao() {
        return descricao;
    }

    /**
     * @param descricao the descricao to set
     */
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    /**
     * @return the valor_venda
     */
    public Double getValor_venda() {
        return valor_venda;
    }

    /**
     * @param valor_venda the valor_venda to set
     */
    public void setValor_venda(Double valor_venda) {
        this.valor_venda = valor_venda;
    }

    /**
     * @return the lab
     */
    public String getLab() {
        return lab;
    }

    /**
     * @param lab the lab to set
     */
    public void setLab(String lab) {
        this.lab = lab;
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

}
