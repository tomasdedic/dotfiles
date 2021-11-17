package main

import (
	"fmt"
	"math/rand"
	"time"
)

type IntRange struct {
	min, max int
}

// get next random value within the interval including min and max
func (ir *IntRange) NextRandom() int {
	return rand.Intn(ir.max-ir.min+1) + ir.min
}

func main() {
	//	const placeOfInterest = "⌘"
	//	25a0-25ff
	//	2633-2727
	var first int
	var last int
	var max int
	// var value32 int32
	max = 20
	kstring := make([]int32, max)
	first = 10240
	last = 10495
	//for i := first; i <= last; i++ {
	//	fmt.Printf("%#c ", i)
	//}
	rand.Seed(time.Now().Unix())
	ir := IntRange{first, last}
	for i := 0; i < max; i++ {
		value32 := int32(ir.NextRandom())
		fmt.Printf("%#c ", value32)
		kstring[i] = value32
	}
	// fmt.Printf("%#c ", kstring)
}
