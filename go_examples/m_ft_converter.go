package main

import (
	"fmt"
	"log"
)

// function of convertion m to ft
func m_to_ft(meters float64) float64 {
	return meters * 3.28084
}

// function of convertion ft to m
func ft_to_m(feet float64) float64 {
	return feet * 0.3048
}

func main() {
	fmt.Print("Meters to feet converter. Choose an option:\n")
	fmt.Print("1) meters to feet\n2) feet to meters\n")
	var input int
	var number_input float64
	_, err := fmt.Scanf("%d", &input)
	if err != nil {
		log.Fatal(err)
	}
	// case 1 = m to ft
	// case 2 = ft to
	// everything else = error
	if input == 1 {
		fmt.Print("Enter a value of meters: ")
		_, err := fmt.Scanf("%f", &number_input)
		if err != nil {
			log.Fatal(err)
		}
		result := m_to_ft(number_input)
		fmt.Println(number_input, "meters equals to", result, "feet")
	} else if input == 2 {
		fmt.Print("Enter a value of feet: ")
		_, err := fmt.Scanf("%f", &number_input)
		if err != nil {
			log.Fatal(err)
		}
		result := ft_to_m(number_input)
		fmt.Println(number_input, "feet equals to", result, "meters")
	} else {
		fmt.Println("Wrong input. Please choose options 1 or 2. Program will terminating...	")
	}
}
