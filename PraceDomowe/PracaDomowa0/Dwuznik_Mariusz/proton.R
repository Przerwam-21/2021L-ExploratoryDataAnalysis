install.packages("proton")
library(proton)

proton()

employees
#Etap 1
employees[employees$surname == "Insecure",]
proton(action = "login", login="johnins")

#Etap2
top1000passwords

for(pass in top1000passwords){
response <- proton(action = "login", login="johnins", password=pass)
if(response =='Success! User is logged in!'){
  cat(pass)}
}

table(top1000passwords)

#Etap3

logs

employees[employees$surname=="Pietraszko",]
slap
logs[logs$login=="slap",c("host")]
table(logs[logs$login == "slap",c("host")]) -> tmp
data.frame(tmp)

proton(action ="server",host="194.29.178.16")
#Etap 4 

bash_history

split_bash_history <- strsplit(bash_history," ")

comands <- c()

  for(x in split_bash_history){
    comands <- c(comands,x[[1]])
  }
comands
proton(action = "login",login="slap",password)