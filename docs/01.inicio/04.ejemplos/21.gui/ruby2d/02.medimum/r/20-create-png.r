# Creamos un gráfico
png("images/private.20-image.png")

# mat1.data <- c(1,2,3,4,5,6,7,8,9)
# mat1 <- matrix(mat1.data,nrow=3,ncol=3,byrow=TRUE)
# draw(mat1)
plot(rnorm(20))

# Cerramos el dispositivo gráfico
dev.off()
