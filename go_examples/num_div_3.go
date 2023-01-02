package main

import (
	"fmt"
)

func div3_num(first_num int, last_num int) []int {
	var num_arr []int
	num_arr = make([]int, 0, 0)
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			num_arr = append(num_arr, i)
		}
	}
	return num_arr
}
func main() {
	var num []int
	num = div3_num(1, 100)
	fmt.Println(num)
}
