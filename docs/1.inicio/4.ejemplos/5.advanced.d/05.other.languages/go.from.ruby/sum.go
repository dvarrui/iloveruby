package main
import "C"
//export sum
func sum(x, y int) int {
  return x + y
}

func main(){}
