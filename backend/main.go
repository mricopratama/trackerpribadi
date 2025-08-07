package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

const (
	testEmail    = "test@example.com"
	testPassword = "password123"
)

type AuthRequest struct {
	Email    string `json:"email" binding:"required,email"`
	Password string `json:"password" binding:"required,min=6"`
}

func main() {
	router := gin.Default()

	api := router.Group("/api/v1")
	{
		api.POST("/register", registerHandler)
		api.POST("/login", loginHandler)
	}

	log.Println("Starting server on :8088") 
	if err := router.Run(":8088"); err != nil {
		log.Fatalf("could not run server: %v", err)
	}
}

func registerHandler(c *gin.Context) {
	var req AuthRequest

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	log.Printf("User registration attempt: %s", req.Email)

	c.JSON(http.StatusCreated, gin.H{
		"message": "Registration successful! (Not saved)",
		"user":    req.Email,
	})
}

func loginHandler(c *gin.Context) {
	var req AuthRequest

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if req.Email == testEmail && req.Password == testPassword {
		log.Printf("Successful login for user: %s", req.Email)
		c.JSON(http.StatusOK, gin.H{
			"message": "Login successful!",
			"token":   "placeholder.jwt.token_untuk_pengembangan",
		})
	} else {
		log.Printf("Failed login attempt for user: %s", req.Email)
		c.JSON(http.StatusUnauthorized, gin.H{
			"error": "Invalid email or password",
		})
	}
}
