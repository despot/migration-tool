package org.example.objectMother;

import org.example.model.Country;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

public class CountryMother {
    public static List<Country> createACountryListWithoutOneTenIndex() {
        return Arrays.asList(
                getChadBuilder().build(),
                getFranceBuilder().build());
    }

    public static List<Country> createACountryListComplete() {
        return Arrays.asList(
                getChadBuilder()
                        .withOneTenIndex(new BigDecimal("1.2")).build(),
                getFranceBuilder()
                        .withOneTenIndex(new BigDecimal("3.4")).build());
    }

    private static Country.CountryBuilder getChadBuilder() {
        return Country.CountryBuilder.aCountry()
                .withId(1L)
                .withName("Chad")
                .withEducationRankingsByPopulation(BigDecimal.valueOf(1.23));
    }

    private static Country.CountryBuilder getFranceBuilder() {
        return Country.CountryBuilder.aCountry()
                .withId(2L)
                .withName("France")
                .withEducationRankingsByPopulation(BigDecimal.valueOf(4.56));
    }
}
