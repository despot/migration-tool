package org.example.model;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Persistent country entity with JPA markup.
 *
 * @author Despot Jakimovski
 */
@Entity
@Table(name = "T_COUNTRY")
public class Country implements Serializable {

    private static final long  serialVersionUID = 1L;

    @Id @GeneratedValue
    protected Long id;

    @Column(nullable = false)
    protected String name;

    protected BigDecimal oneTenIndex;

    public Country() {
    }

    public Country(String name, BigDecimal oneTenIndex) {
        this.name = name;
        this.oneTenIndex = oneTenIndex;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getOneTenIndex() {
        return oneTenIndex;
    }

    public void setOneTenIndex(BigDecimal oneTenIndex) {
        this.oneTenIndex = oneTenIndex;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Country country = (Country) o;

        if (!id.equals(country.id)) return false;
        if (!name.equals(country.name)) return false;
        return oneTenIndex != null ? oneTenIndex.equals(country.oneTenIndex) : country.oneTenIndex == null;
    }

    @Override
    public int hashCode() {
        int result = id.hashCode();
        result = 31 * result + name.hashCode();
        result = 31 * result + (oneTenIndex != null ? oneTenIndex.hashCode() : 0);
        return result;
    }
}
