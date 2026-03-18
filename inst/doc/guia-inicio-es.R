## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----extraccion datos estandar------------------------------------------------
library(synopR)

data_input_vector <- c("AAXX 04003 87736 32965 00000 10204 20106 39982 40074 5//// 333 10266 20158 555 64169 65090 =",
                       "AAXX 01094 87736 NIL=",
                       "AAXX 03183 87736 32965 12708 10254 20052 30005 40098 5//// 80005 333 56000 81270 =")

my_data <- show_synop_data(data_input_vector, wmo_identifier = '87736')

print(my_data)


## ----ventaja wmo_identifier---------------------------------------------------
library(synopR)
# Messages from 87736 and 87016
mixed_synop <- c("AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 60001 82100 333 56600 82818=",
                 "AAXX 04033 87016 41460 83208 10200 20194 39712 40114 50003 70292 888// 333 56699 82810 88615="
                 )

colorado_data <- show_synop_data(mixed_synop, wmo_identifier = '87736', remove_empty_cols = TRUE)
knitr::kable(t(colorado_data))

## ----check synops2, error = TRUE----------------------------------------------
try({
library(synopR)

my_df <- data.frame(syn = c("AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 60001 82100 333 56600 82818=",
                            "AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 60001 82100 333 56600 82818="),
                    second_column = c(5,7))

check_synop(my_df) # Bien

check_synop(my_df$syn) # Mal

})

## ----check synops3------------------------------------------------------------
library(synopR)

check_synop(c("AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 60001 82100 333 56600 82818=",
              "AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 6000182100 333 56600 82818=",
              "AAXX 01183 87736 12465 20000 10326 2021 39974 40064 5//// 60001 82100 333 56600 82818=",
              "AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 60001 82100 333 56600 82818",
              "Not a synop message="))


## ----carga-datos--------------------------------------------------------------
library(synopR)

data_input <- data.frame(synops = c("87736,2026,02,01,03,00,AAXX 01034 87736 NIL=",
                                    "87736,2026,02,01,06,00,AAXX 01064 87736 NIL=",
                                    "87736,2026,02,01,09,00,AAXX 01094 87736 NIL=",
                                    "87736,2026,02,01,12,00,AAXX 01123 87736 12965 31808 10240 20210 39992 40082 5//// 60104 82075 333 10282 20216 56055 82360=",
                                    "87736,2026,02,01,15,00,AAXX 01154 87736 NIL=",
                                    "87736,2026,02,01,18,00,AAXX 01183 87736 12465 20000 10326 20215 39974 40064 5//// 60001 82100 333 56600 82818=",
                                    "87736,2026,02,01,21,00,AAXX 01214 87736 NIL="))

# Escribit `parse_ogimet(data_input)` es incorrecto!
data_from_ogimet <- parse_ogimet(data_input$synops) 

print(data_from_ogimet)

# Se añade la columna 'Year' para el Año
parse_ogimet(data_input$synops) |> show_synop_data(wmo_identifier = 87736, remove_empty_cols = TRUE)

