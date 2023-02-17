package main

import (
	"fmt"
	"net/http"
	"os"
	"strings"

	"github.com/gin-gonic/gin"
)

type Msg struct {
	Message string `json:"message"`
}

func main() {
	gin.SetMode(gin.ReleaseMode)

	router := gin.Default()
	router.GET("/", handler)

	fmt.Println("Go REST service started...")
	router.Run("0.0.0.0:5000")
}

func handler(ctx *gin.Context) {
	environment := os.Getenv("Environment")

	msg := Msg{
		Message: fmt.Sprintf("Hello %s!", strings.TrimSpace(environment)),
	}

	ctx.JSON(http.StatusOK, msg)
}
