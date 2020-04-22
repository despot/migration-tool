package org.example.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Persistent country entity with JPA markup.
 *
 * @author Despot Jakimovski
 */
@Entity
@Table(name = "country")
public class Country implements Serializable {

    private static final long  serialVersionUID = 1L;

    @Id
    @GeneratedValue(
            strategy= GenerationType.AUTO,
            generator="native"
    )
    @GenericGenerator(//to handle hibernate+mysql sequence issue.
            name = "native",
            strategy = "native"
    )
    protected Long id;

    @Column(nullable = false)
    protected String name;

    @Column(name = "educationRankingsByPopulation")
    protected BigDecimal educationRankingsByPopulation;

    @Column(name = "averageHighestAndLowestTemperatureDifference")
    protected BigDecimal averageHighestAndLowestTemperatureDifference;

    @Column(name = "averageYearlySunshineHours")
    protected BigDecimal averageYearlySunshineHours;

    @Column(name = "hoursReturnTravelFromOriginToDestination")
    protected BigDecimal hoursReturnTravelFromOriginToDestination;

    @Column(name = "priceEurOfTravelReturnFromOriginToDestination")
    protected BigDecimal priceEurOfTravelReturnFromOriginToDestination;

    @Transient
    protected BigDecimal oneTenIndex;

    public Country() {
    }

    public Country(Long id, String name, BigDecimal educationRankingsByPopulation, BigDecimal averageHighestAndLowestTemperatureDifference, BigDecimal averageYearlySunshineHours, BigDecimal hoursReturnTravelFromOriginToDestination, BigDecimal priceEurOfTravelReturnFromOriginToDestination, BigDecimal oneTenIndex) {
        this.id = id;
        this.name = name;
        this.educationRankingsByPopulation = educationRankingsByPopulation;
        this.averageHighestAndLowestTemperatureDifference = averageHighestAndLowestTemperatureDifference;
        this.averageYearlySunshineHours = averageYearlySunshineHours;
        this.hoursReturnTravelFromOriginToDestination = hoursReturnTravelFromOriginToDestination;
        this.priceEurOfTravelReturnFromOriginToDestination = priceEurOfTravelReturnFromOriginToDestination;
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

    public BigDecimal getAverageHighestAndLowestTemperatureDifference() {
        return averageHighestAndLowestTemperatureDifference;
    }

    public void setAverageHighestAndLowestTemperatureDifference(BigDecimal averageHighestAndLowestTemperatureDifference) {
        this.averageHighestAndLowestTemperatureDifference = averageHighestAndLowestTemperatureDifference;
    }

    public BigDecimal getAverageYearlySunshineHours() {
        return averageYearlySunshineHours;
    }

    public void setAverageYearlySunshineHours(BigDecimal averageYearlySunshineHours) {
        this.averageYearlySunshineHours = averageYearlySunshineHours;
    }

    public BigDecimal getHoursReturnTravelFromOriginToDestination() {
        return hoursReturnTravelFromOriginToDestination;
    }

    public void setHoursReturnTravelFromOriginToDestination(BigDecimal hoursReturnTravelFromOriginToDestination) {
        this.hoursReturnTravelFromOriginToDestination = hoursReturnTravelFromOriginToDestination;
    }

    public BigDecimal getPriceEurOfTravelReturnFromOriginToDestination() {
        return priceEurOfTravelReturnFromOriginToDestination;
    }

    public void setPriceEurOfTravelReturnFromOriginToDestination(BigDecimal priceEurOfTravelReturnFromOriginToDestination) {
        this.priceEurOfTravelReturnFromOriginToDestination = priceEurOfTravelReturnFromOriginToDestination;
    }

    public BigDecimal getOneTenIndex() {
        return oneTenIndex;
    }

    public void setOneTenIndex(BigDecimal oneTenIndex) {
        this.oneTenIndex = oneTenIndex;
    }

    public BigDecimal getEducationRankingsByPopulation() {
        return educationRankingsByPopulation;
    }

    public void setEducationRankingsByPopulation(BigDecimal educationRankingsByPopulation) {
        this.educationRankingsByPopulation = educationRankingsByPopulation;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Country country = (Country) o;

        if (id != null ? !id.equals(country.id) : country.id != null) return false;
        if (name != null ? !name.equals(country.name) : country.name != null) return false;
        if (educationRankingsByPopulation != null ? !educationRankingsByPopulation.equals(country.educationRankingsByPopulation) : country.educationRankingsByPopulation != null)
            return false;
        if (averageHighestAndLowestTemperatureDifference != null ? !averageHighestAndLowestTemperatureDifference.equals(country.averageHighestAndLowestTemperatureDifference) : country.averageHighestAndLowestTemperatureDifference != null)
            return false;
        if (averageYearlySunshineHours != null ? !averageYearlySunshineHours.equals(country.averageYearlySunshineHours) : country.averageYearlySunshineHours != null)
            return false;
        if (hoursReturnTravelFromOriginToDestination != null ? !hoursReturnTravelFromOriginToDestination.equals(country.hoursReturnTravelFromOriginToDestination) : country.hoursReturnTravelFromOriginToDestination != null)
            return false;
        if (priceEurOfTravelReturnFromOriginToDestination != null ? !priceEurOfTravelReturnFromOriginToDestination.equals(country.priceEurOfTravelReturnFromOriginToDestination) : country.priceEurOfTravelReturnFromOriginToDestination != null)
            return false;
        return oneTenIndex != null ? oneTenIndex.equals(country.oneTenIndex) : country.oneTenIndex == null;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (educationRankingsByPopulation != null ? educationRankingsByPopulation.hashCode() : 0);
        result = 31 * result + (averageHighestAndLowestTemperatureDifference != null ? averageHighestAndLowestTemperatureDifference.hashCode() : 0);
        result = 31 * result + (averageYearlySunshineHours != null ? averageYearlySunshineHours.hashCode() : 0);
        result = 31 * result + (hoursReturnTravelFromOriginToDestination != null ? hoursReturnTravelFromOriginToDestination.hashCode() : 0);
        result = 31 * result + (priceEurOfTravelReturnFromOriginToDestination != null ? priceEurOfTravelReturnFromOriginToDestination.hashCode() : 0);
        result = 31 * result + (oneTenIndex != null ? oneTenIndex.hashCode() : 0);
        return result;
    }


    public static final class CountryBuilder {
        protected Long id;
        protected String name;
        protected BigDecimal educationRankingsByPopulation;
        protected BigDecimal averageHighestAndLowestTemperatureDifference;
        protected BigDecimal averageYearlySunshineHours;
        protected BigDecimal hoursReturnTravelFromOriginToDestination;
        protected BigDecimal priceEurOfTravelReturnFromOriginToDestination;
        protected BigDecimal oneTenIndex;

        private CountryBuilder() {
        }

        public static CountryBuilder aCountry() {
            return new CountryBuilder();
        }

        public CountryBuilder withId(Long id) {
            this.id = id;
            return this;
        }

        public CountryBuilder withName(String name) {
            this.name = name;
            return this;
        }

        public CountryBuilder withEducationRankingsByPopulation(BigDecimal educationRankingsByPopulation) {
            this.educationRankingsByPopulation = educationRankingsByPopulation;
            return this;
        }

        public CountryBuilder withAverageHighestAndLowestTemperatureDifference(BigDecimal averageHighestAndLowestTemperatureDifference) {
            this.averageHighestAndLowestTemperatureDifference = averageHighestAndLowestTemperatureDifference;
            return this;
        }

        public CountryBuilder withAverageYearlySunshineHours(BigDecimal averageYearlySunshineHours) {
            this.averageYearlySunshineHours = averageYearlySunshineHours;
            return this;
        }

        public CountryBuilder withHoursReturnTravelFromOriginToDestination(BigDecimal hoursReturnTravelFromOriginToDestination) {
            this.hoursReturnTravelFromOriginToDestination = hoursReturnTravelFromOriginToDestination;
            return this;
        }

        public CountryBuilder withPriceEurOfTravelReturnFromOriginToDestination(BigDecimal priceEurOfTravelReturnFromOriginToDestination) {
            this.priceEurOfTravelReturnFromOriginToDestination = priceEurOfTravelReturnFromOriginToDestination;
            return this;
        }

        public CountryBuilder withOneTenIndex(BigDecimal oneTenIndex) {
            this.oneTenIndex = oneTenIndex;
            return this;
        }

        public CountryBuilder but() {
            return aCountry().withId(id).withName(name).withEducationRankingsByPopulation(educationRankingsByPopulation).withAverageHighestAndLowestTemperatureDifference(averageHighestAndLowestTemperatureDifference).withAverageYearlySunshineHours(averageYearlySunshineHours).withHoursReturnTravelFromOriginToDestination(hoursReturnTravelFromOriginToDestination).withPriceEurOfTravelReturnFromOriginToDestination(priceEurOfTravelReturnFromOriginToDestination).withOneTenIndex(oneTenIndex);
        }

        public Country build() {
            Country country = new Country();
            country.setId(id);
            country.setName(name);
            country.setEducationRankingsByPopulation(educationRankingsByPopulation);
            country.setAverageHighestAndLowestTemperatureDifference(averageHighestAndLowestTemperatureDifference);
            country.setAverageYearlySunshineHours(averageYearlySunshineHours);
            country.setHoursReturnTravelFromOriginToDestination(hoursReturnTravelFromOriginToDestination);
            country.setPriceEurOfTravelReturnFromOriginToDestination(priceEurOfTravelReturnFromOriginToDestination);
            country.setOneTenIndex(oneTenIndex);
            return country;
        }
    }
}
