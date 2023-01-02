package main

import (
	"fmt"
	"log"
)

func find_least(arr_size int, num_array []int) int {
	least := num_array[0]
	for i := 1; i <= arr_size-1; i++ {
		if least > num_array[i] {
			least = num_array[i]
		}
	}
	return least
}

func main() {

	var arr_size int
	fmt.Print("Define the array's size: ")
	_, err := fmt.Scanf("%d", &arr_size)
	if err != nil {
		log.Fatal(err)
	}
	var arr = make([]int, arr_size)
	fmt.Printf("Next, you need to set the array values for %d elements starting from the zero element.\n", arr_size)
	fmt.Printf("Enter element number %d: ", 0)
	fmt.Scanf("%d", &arr[0])
	for i := 0; i <= arr_size-1; i++ {
		fmt.Printf("Enter element number %d: ", i)
		fmt.Scanf("%d", &arr[i])
	}
	result := find_least(arr_size, arr)
	fmt.Println("The least element has a value =", result)
}
