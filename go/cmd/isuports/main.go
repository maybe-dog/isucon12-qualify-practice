package main

import (
	"fmt"
	"net/http"
	_ "net/http/pprof"
	"runtime"

	isuports "github.com/isucon/isucon12-qualify/webapp/go"
)

func main() {
	// tenantDBの切断
	for _, db := range isuports.TenantDBs {
		defer db.Close()
	}

	// pprof
	runtime.SetBlockProfileRate(1)
	runtime.SetMutexProfileFraction(1)
	go func() {
		fmt.Println(http.ListenAndServe("0.0.0.0:6060", nil))
	}()

	isuports.Run()
}
