#the output from this script is already saved as vtsmodel-hddm-input-vol and -exp in this folder
#this script is provided for examination of preprocessing that was used to create those files
#running this script again will overwrite those files
#generation and analyses of HDDM models themselves can be found in hddm-analyses.ipnyb 

## read in files ####
setwd("../rawdata")
datafiles=list.files(pattern = ".txt")
for (file in datafiles){
  thisfile<-read.table(file, header = T)
  subj = thisfile[1,1]
  if (subj %% 2 == 0){
    if (subj == 2){
      explicit<-thisfile
    }
    else{
      explicit<-rbind(explicit, thisfile)
    }
  }
  else{
    if (subj == 1){
      voluntary<-thisfile
    }
    else{
      voluntary<-rbind(voluntary, thisfile)
    }
  }
}
setwd("../DDM/")

#set switches correctly for voluntary (already correct for explicit)
library(data.table)
voluntary$sr[voluntary$task != shift(voluntary$task)]<-1
voluntary$sr[voluntary$task == shift(voluntary$task)]<-0
voluntary$sr[voluntary$altRep == -1]<--1

#remove subjects with bad switch rates from voluntary
srtots<-aggregate(sr ~ subj, data = subset(voluntary, altRep > -1), FUN = mean)
badsubs<-srtots$subj[srtots$sr> .8 | srtots$sr < .2]

voluntary<-subset(voluntary, !(subj %in% badsubs))

#remove bad accuracies from both
acctots_exp<-aggregate(task_acc ~ subj, data = explicit, FUN = mean)
badsubs<-acctots_exp$subj[acctots_exp$task_acc < .6]
explicit<-subset(explicit, !(subj %in% badsubs))

acctots_voluntary<-aggregate(task_acc ~ subj, data = voluntary, FUN = mean)
badsubs<-acctots_voluntary$subj[acctots_voluntary$task_acc < .6]
voluntary<-subset(voluntary, !(subj %in% badsubs))


#rename colunms to fit hddm input
colnames(voluntary)[1]<-"subj_idx"
colnames(explicit)[1]<-"subj_idx"
colnames(voluntary)[15]<-"rt"
colnames(explicit)[15]<-"rt"
colnames(voluntary)[16]<-"response"
colnames(explicit)[16]<-"response"

voluntary$condition<-"V"
explicit$condition<-"E"

#remove trials that were neither switches nor repeats
voluntary<-subset(voluntary, sr > -1)
explicit<-subset(explicit, altRep > -1)

#change from 1-0 coding to Switch-Repeat for easier interpetation later on
voluntary$altRep[voluntary$sr == 1]<-"Switch"
voluntary$altRep[voluntary$sr == 0]<-"Repeat"
explicit$sr<-explicit$altRep
explicit$altRep[explicit$sr == 1]<-"Switch"
explicit$altRep[explicit$sr == 0]<-"Repeat"

#create 'intervals' column is the interval combination
#parameters will vary by this variable in the final model
#note that the RCI column is at this point incorrectly named RSI
#it *is* RCI, didn't bother to change it here because that column isn't used in DDM analyses anyway

voluntary$intervals[voluntary$CSI == 100 & voluntary$RSI == 1000]<-"SL"
voluntary$intervals[voluntary$CSI == 100 & voluntary$RSI == 100]<-"SS"
voluntary$intervals[voluntary$CSI == 1000 & voluntary$RSI == 1000]<-"LL"
voluntary$intervals[voluntary$CSI == 1000 & voluntary$RSI == 100]<-"LS"

explicit$intervals[explicit$CSI == 100 & explicit$RSI == 1000]<-"SL"
explicit$intervals[explicit$CSI == 100 & explicit$RSI == 100]<-"SS"
explicit$intervals[explicit$CSI == 1000 & explicit$RSI == 1000]<-"LL"
explicit$intervals[explicit$CSI == 1000 & explicit$RSI == 100]<-"LS"

#remove reponses that are too quick or too slow for analysis
voluntary<-subset(voluntary, rt > 200)
voluntary<-subset(voluntary, rt < 5000)
explicit<-subset(explicit, rt > 200)
explicit<-subset(explicit, rt < 5000)

#convert RT from ms to seconds (format expected by HDDM)
voluntary$rt<-voluntary$rt/1000
explicit$rt<-explicit$rt/1000

write.csv(voluntary, "vtsmodel-hddm-input-exp.csv", row.names = F)
write.csv(explicit, "vtsmodel-hddm-input-vol.csv", row.names = F)
