library(brms)
library(dplyr)

#these models were re-generated after manuscript submission for the sake of open publication
#MCMC sampling by nature involves some level of variation each time a model is estimated
#because of this, small differences in estimates between here and the manuscript exist
#none are consequential to conclusions (convergence was good for all models)

## switch costs within interval combinations ####

#voluntary SS
readRDS('./regression-models/voluntary-SwitchCost-SS-mod.rds') %>% summary()

#voluntary SL
readRDS('./regression-models/voluntary-SwitchCost-SL-mod.rds') %>% summary()

#voluntary LS
readRDS('./regression-models/voluntary-SwitchCost-LS-mod.rds') %>% summary()

#voluntary LL
readRDS('./regression-models/voluntary-SwitchCost-LL-mod.rds') %>% summary()

#explicit SS
readRDS('./regression-models/explicit-SwitchCost-SS-mod.rds') %>% summary()

#explicit SL
readRDS('./regression-models/explicit-SwitchCost-SL-mod.rds') %>% summary()

#explicit LS
readRDS('./regression-models/explicit-SwitchCost-LS-mod.rds') %>% summary()

#explicit LL
readRDS('./regression-models/explicit-SwitchCost-LL-mod.rds') %>% summary()


## interval condition comparisons for switch RTs ####

#voluntary SL vs LS
readRDS('./regression-models/voluntary-switchRT-SL-LS-mod.rds') %>% summary()

#voluntary SS vs LS
readRDS('./regression-models/voluntary-switchRT-LS-SS-mod.rds') %>% summary()

#voluntary LL vs SL
readRDS('./regression-models/voluntary-switchRT-LL-SL-mod.rds') %>% summary()

#voluntary SS vs LL
readRDS('./regression-models/voluntary-switchRT-LL-SS-mod.rds') %>% summary()


#explicit SL vs LS
readRDS('./regression-models/explicit-switchRT-SL-LS-mod.rds') %>% summary()

#explicit SS vs LS
readRDS('./regression-models/explicit-switchRT-LS-SS-mod.rds') %>% summary()

#explicit LL vs SL
readRDS('./regression-models/explicit-switchRT-LL-SL-mod.rds') %>% summary()

#explicit SS vs LL
readRDS('./regression-models/explicit-switchRT-LL-SS-mod.rds') %>% summary()


## interval condition comparisons for repeat RTs ####

#voluntary SL vs LS
readRDS('./regression-models/voluntary-repRT-SL-LS-mod.rds') %>% summary()

#voluntary SS vs LS
readRDS('./regression-models/voluntary-repRT-LS-SS-mod.rds') %>% summary()

#voluntary LL vs SL
readRDS('./regression-models/voluntary-repRT-LL-SL-mod.rds') %>% summary()

#voluntary SS vs LL
readRDS('./regression-models/voluntary-repRT-LL-SS-mod.rds') %>% summary()


#explicit SL vs LS
readRDS('./regression-models/explicit-repRT-SL-LS-mod.rds') %>% summary()

#explicit SS vs LS
readRDS('./regression-models/explicit-repRT-LS-SS-mod.rds') %>% summary()

#explicit LL vs SL
readRDS('./regression-models/explicit-repRT-LL-SL-mod.rds') %>% summary()

#explicit SS vs LL
readRDS('./regression-models/explicit-repRT-LL-SS-mod.rds') %>% summary()
