RNGkind("Mersenne-Twister")
cat(date())
test_that("exercising plotClonePhylog", {
              data(examplesFitnessEffects)
              tmp <-  oncoSimulIndiv(examplesFitnessEffects[["o3"]],
                                     model = "McFL", 
                                     mu = 5e-5,
                                     detectionSize = 1e8, 
                                     detectionDrivers = 3,
                                     sampleEvery = 0.025,
                                     max.num.tries = 10,
                                     keepEvery = 5,
                                     initSize = 2000,
                                     finalTime = 3000,
                                     onlyCancer = FALSE,
                                     keepPhylog = TRUE)
              ## Show only those with N > 10 at end
              plotClonePhylog(tmp, N = 10)
              ## Show only those with N > 1 between times 5 and 1000
              plotClonePhylog(tmp, N = 1, t = c(5, 1000))
              ## Show everything, even if teminal nodes are extinct
              plotClonePhylog(tmp, N = 0)
              ## Show time when first appeared
              plotClonePhylog(tmp, N = 10, timeEvents = TRUE)
              ## This can take a few seconds
              plotClonePhylog(tmp, N = 10, keepEvents = TRUE)
          })
cat(date())

date()
test_that("exercising the fitnessEffects plotting code", {
              data(examplesFitnessEffects)
              plot(examplesFitnessEffects[["cbn1"]])
              cs <-  data.frame(parent = c(rep("Root", 4), "a", "b", "d", "e", "c"),
                 child = c("a", "b", "d", "e", "c", "c", rep("g", 3)),
                 s = 0.1,
                                sh = -0.9,
                                typeDep = "MN")
              cbn1 <- allFitnessEffects(cs)
              plot(cbn1)
              plot(cbn1, "igraph")
              p4 <- data.frame(parent = c(rep("Root", 4), "A", "B", "D", "E", "C", "F"),
                  child = c("A", "B", "D", "E", "C", "C", "F", "F", "G", "G"),
                  s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, 0.2, 0.2, 0.3, 0.3),
                  sh = c(rep(0, 4), c(-.9, -.9), c(-.95, -.95), c(-.99, -.99)),
                  typeDep = c(rep("--", 4), 
                      "XMPN", "XMPN", "MN", "MN", "SM", "SM"))
              fp4m <- allFitnessEffects(p4,
                                        geneToModule = c("Root" = "Root", "A" = "a1",
                                            "B" = "b1, b2", "C" = "c1",
                                            "D" = "d1, d2", "E" = "e1",
                                            "F" = "f1, f2", "G" = "g1"))
              plot(fp4m, expandModules = TRUE)
              plot(fp4m, "igraph", layout = igraph::layout.reingold.tilford, 
                   expandModules = TRUE)
              plot(fp4m, "igraph", layout = igraph::layout.reingold.tilford, 
                   expandModules = TRUE, autofit = TRUE)
              plot(fp4m, expandModules = TRUE, autofit = TRUE)
          })
date()




date()
test_that("stacked, stream, genotypes and some colors", {
      data(examplesFitnessEffects)
      tmp <-  oncoSimulIndiv(examplesFitnessEffects[["o3"]],
                             model = "McFL", 
                             mu = 5e-5,
                             detectionSize = 1e8, 
                             detectionDrivers = 3,
                             sampleEvery = 0.025,
                             max.num.tries = 10,
                             keepEvery = 5,
                             initSize = 2000,
                             finalTime = 3000,
                             onlyCancer = FALSE,
                             keepPhylog = TRUE)
      
      plot(tmp, type = "stacked", show = "genotypes")
      plot(tmp, type = "stream", show = "genotypes")
      plot(tmp, type = "line", show = "genotypes")

      plot(tmp, type = "stacked", show = "drivers")
      plot(tmp, type = "stream", show = "drivers")
      plot(tmp, type = "line", show = "drivers")

      plot(tmp, type = "stacked", order.method = "max")
      plot(tmp, type = "stacked", order.method = "first")

      plot(tmp, type = "stream", order.method = "max")
      plot(tmp, type = "stream", order.method = "first")

      plot(tmp, type = "stream", stream.center = TRUE)
      plot(tmp, type = "stream", stream.center = FALSE)

      plot(tmp, type = "stream", stream.center = TRUE, log = "x")
      plot(tmp, type = "stacked", stream.center = TRUE, log = "x")
      
      plot(tmp, type = "stacked", show = "genotypes",
           breakSortColors = "random")
      plot(tmp, type = "stream", show = "genotypes",
           breakSortColors = "distave")

      plot(tmp, type = "stacked", show = "genotypes", col = rainbow(9))
      plot(tmp, type = "stream", show = "genotypes", col = rainbow(3))
      plot(tmp, type = "line", show = "genotypes", col = rainbow(20))
      
})
date()



test_that("xlab, ylab, ylim, xlim can be passed", {
    data(examplePosets)
    p701 <- examplePosets[["p701"]]
    b1 <- oncoSimulIndiv(p701)
    plot(b1, addtot = TRUE, plotDiversity = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(-1000, 1000), log = "",
         plotDrivers = TRUE, xlim = c(20, 70))
    plot(b1, show = "drivers", type = "stacked",
         xlab = "xlab",
         ylab = "ylab", ylim = c(-1000, 1000),
         xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(b1, show = "drivers", type = "stream",
         addtot = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(-100, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(b1, show = "genotypes",
         addtot = TRUE, plotDiversity = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(1, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(b1, show = "genotypes", type = "stacked",
         xlab = "xlab",
         ylab = "ylab", ylim = c(-1000, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(b1, show = "genotypes", type = "stream",
         addtot = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(-100, 1000),
                  xlim = c(-20, 70),
         plotDrivers = TRUE)
    sa <- 0.1
    sb <- -0.2
    sab <- 0.25
    sac <- -0.1
    sbc <- 0.25
    sv2 <- allFitnessEffects(epistasis = c("-A : B" = sb,
                                           "A : -B" = sa,
                                           "A : C" = sac,
                                           "A:B" = sab,
                                           "-A:B:C" = sbc),
                             geneToModule = c(
                                 "Root" = "Root",
                                 "A" = "a1, a2",
                                 "B" = "b",
                                 "C" = "c"))
    e1 <- oncoSimulIndiv(sv2, model = "McFL",
                         mu = 5e-6,
                         sampleEvery = 0.02,
                         keepEvery = 1,
                         initSize = 2000,
                         finalTime = 3000,
                         onlyCancer = FALSE)
    plot(e1, addtot = TRUE, plotDiversity = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(1, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(e1, show = "drivers", type = "stacked",
         xlab = "xlab",
         ylab = "ylab", ylim = c(-1000, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(e1, show = "drivers", type = "stream",
         addtot = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(-100, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(e1, show = "genotypes",
         addtot = TRUE, plotDiversity = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(-1000, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(e1, show = "genotypes", type = "stacked",
         xlab = "xlab",
         ylab = "ylab", ylim = c(-1000, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
    plot(e1, show = "genotypes", type = "stream",
         addtot = TRUE, xlab = "xlab",
         ylab = "ylab", ylim = c(-100, 1000),
                  xlim = c(20, 70),
         plotDrivers = TRUE)
})


date()
test_that("oncosimul v.1 objects and genotype plotting", {
    data(examplePosets)
    ## An object of class oncosimul
    p705 <- examplePosets[["p705"]]
    p1 <- oncoSimulIndiv(p705, keepEvery = 5)
    ## p1 <- oncoSimulIndiv(p705, model = "McFL",
    ##                      mu = 5e-6,
    ##                      sampleEvery = 0.02,
    ##                      keepEvery = 10,
    ##                      initSize = 2000,
    ##                      finalTime = 3000,
    ##                      onlyCancer = FALSE)
    class(p1)
    plot(p1, type = "stacked", show = "genotypes", thinData = TRUE)
    plot(p1, type = "stream", show = "genotypes", thinData = TRUE)
    plot(p1, type = "line", show = "genotypes", thinData = TRUE)
})
date()




test_that("passing colors", {
    data(examplePosets)
    ## An object of class oncosimul
    p705 <- examplePosets[["p705"]]
    p1 <- oncoSimulIndiv(p705)
    class(p1)
    plot(p1, type = "stacked", show = "genotypes", col = rainbow(8))
    plot(p1, type = "stream", show = "genotypes", col = rainbow(18))
    plot(p1, type = "line", show = "genotypes", col = rainbow(3))
})