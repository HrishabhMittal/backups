package main

import (
	"fmt"
	"os"
    "golang.org/x/term"
)

func getKey() (char byte,code byte) {
    fd:=int(os.Stdin.Fd())
    old,err := term.MakeRaw(fd)
    if err!=nil {
        panic(err)
    }
    defer term.Restore(fd,old)
    buf:=make([]byte,10)
    n,_:=os.Stdin.Read(buf)
    char=buf[0]
    for i:=0;i<n;i++ {
        fmt.Printf("%d,",buf[i])
    }
    fmt.Print("\r\n")
    return
}
func main() {
    var char byte = ' '
    for char!='q' {
        char,_=getKey()
    }
}
