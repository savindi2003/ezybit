package lk.jiat.ee.core.model;

import java.io.Serializable;

public class Product implements Serializable {
    private Integer id;
    private String name;
    private String description;
    private Double price;
    private Integer quantity;

    public Product() {
    }

    public Product(Integer id, Integer quantity, Double price, String description, String name) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.description = description;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
