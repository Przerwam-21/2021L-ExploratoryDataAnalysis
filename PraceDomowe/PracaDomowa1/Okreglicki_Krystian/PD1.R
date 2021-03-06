#install.packages("PogromcyDanych")
library(PogromcyDanych)
library(dplyr)
#auta2012



##1.  Sprawd� ile jest aut z silnikiem diesla wyprodukowanych w 2007 roku?
dim(auta2012 %>% 
      filter(Rodzaj.paliwa == "olej napedowy (diesel)" & Rok.produkcji == 2007))
# Odp: 11621



##2.  Jakiego koloru auta maj� najmniejszy medianowy przebieg?
auta2012 %>% 
  group_by(Kolor) %>% 
  summarise(mediana = median(Przebieg.w.km, na.rm = TRUE)) %>% 
  arrange(mediana)
# Odp: bia�y-metalic



##3.  Gdy ograniczy� si� tylko do aut wyprodukowanych w 2007, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(Rok.produkcji == 2007) %>% 
  group_by(Marka) %>% 
  summarise(ilosc = n()) %>% 
  arrange(-ilosc)
# Odp: Volkswagen



##4.  Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najta�sza?
auta2012 %>% 
  filter(Rok.produkcji == 2007 & Rodzaj.paliwa == "olej napedowy (diesel)") %>% 
  group_by(Marka) %>% 
  summarise(srednia_cena = mean(Cena.w.PLN)) %>% 
  arrange(srednia_cena)
# Odp: Aixam



##5.  Spo�r�d aut marki Toyota, kt�ry model najbardziej straci�� na cenie pomi�dzy rokiem produkcji 2007 a 2008.
x5_1 <- auta2012 %>% 
  filter(Rok.produkcji == 2007 & Marka == "Toyota") %>%
  group_by(Model) %>%
  summarise(cena_2007 = mean(Cena.w.PLN))
x5_2 <- auta2012 %>% 
  filter(Rok.produkcji == 2008 & Marka == "Toyota") %>%
  group_by(Model) %>%
  summarise(cena_2008 = mean(Cena.w.PLN))
zadanie5 <- x5_1 %>% 
  inner_join(x5_2, by="Model") %>% 
  mutate(roznica = (cena_2008 - cena_2007)) %>% 
  arrange(roznica)
# Odp: Hiace



##6.  W jakiej marce klimatyzacja jest najcz�ciej obecna?
auta2012 %>% 
  mutate(wyposazenie = strsplit(as.character(Wyposazenie.dodatkowe), ", ")) %>% 
  mutate(klimatyzacja = sapply(wyposazenie, function(x) "klimatyzacja" %in% x)) %>% 
  filter(klimatyzacja == TRUE) %>% 
  group_by(Marka) %>% 
  summarise(z_klimatyzacja = n()) %>% 
  arrange(-z_klimatyzacja)
# Odp: Volkswagen



##7.  Gdy ograniczy� si� tylko do aut z silnikiem ponad 100 KM, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(KM > 100) %>% 
  group_by(Marka) %>% 
  summarise(ilosc = n()) %>% 
  arrange(-ilosc)
# Odp: Volkswagen


##8.  Gdy ograniczy� si� tylko do aut o przebiegu poni�ej 50 000 km o silniku diesla, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?
auta2012 %>% 
  filter(Przebieg.w.km < 50000 & Rodzaj.paliwa == "olej napedowy (diesel)")%>% 
  group_by(Marka) %>% 
  summarise(ilosc = n()) %>% 
  arrange(-ilosc)
# Odp: BMW


##9.  Spo�r�d aut marki Toyota wyprodukowanych w 2007 roku, kt�ry model jest �rednio najdro�szy?
auta2012 %>% 
  filter(Rok.produkcji == 2007, Marka=="Toyota") %>% 
  group_by(Model) %>% 
  summarise(sredna_cena = mean(Cena.w.PLN)) %>% 
  arrange(-sredna_cena)
# Odp: Land Cruiser



##10.  Spo�r�d aut marki Toyota, kt�ry model ma najwi�ksz� r�nic� cen gdy por�wna� silniki benzynowe a diesel?
x10_1 <- auta2012 %>% 
  filter(Marka == "Toyota" & Rodzaj.paliwa == "olej napedowy (diesel)") %>%
  group_by(Model) %>%
  summarise(cena_diesel = mean(Cena.w.PLN))
x10_2 <- auta2012 %>% 
  filter(Marka == "Toyota" & Rodzaj.paliwa == "benzyna") %>%
  group_by(Model) %>%
  summarise(cena_benzyna = mean(Cena.w.PLN))
zadanie10 <- x10_1 %>% 
  inner_join(x10_2, by="Model") %>% 
  mutate(roznica = abs(cena_diesel - cena_benzyna)) %>% 
  arrange(-roznica)
# Odp: Camry