plot(jitter(Carbon) ~ jitter(City), xlab = "City (mpg)", ylab = "Carbon footprint (tons per year)", data = fuel)
fit <- lm(Carbon ~ City, data = fuel)
abline(fit)
summary(fit)
res <- residuals(fit)
plot(jitter(res) ~ jitter(City), ylab = "Residuals", xlab = "City",data = fuel)
abline(h = 0)

fcast<- forecast(fit, newdata=data.frame(City=40))
plot(fcast, xlab="City (mpg)",ylab="Carbon footprint (tonsper year)")
points(jitter(Carbon) ~ jitter(City),data = fuel)
summary(fcast) 


confint(fit, level = 0.9)
