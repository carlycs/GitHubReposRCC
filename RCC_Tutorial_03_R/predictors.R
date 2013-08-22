###########################################################################################
## DATA Preparation
###########################################################################################
Y.train = Network.train[lower.tri(Network.train)]
Y.valid = Network.valid[lower.tri(Network.valid)]

X.train = NULL
for (i in 1:(dim(DATA.train)[1]-1)){
for (j in (i+1):dim(DATA.train)[1]){
	Gene.i = matrix(DATA.train[i,],95,6,byrow=TRUE)
	Gene.j = matrix(DATA.train[j,],95,6,byrow=TRUE)
	X.ij = c(min(mean(Gene.i), mean(Gene.j)), max(mean(Gene.i), mean(Gene.j)), 
		min(var(DATA.train[i,]), var(DATA.train[j,])), max(var(DATA.train[i,]), var(DATA.train[j,])),
		cor(DATA.train[i,], DATA.train[j,]), cor(apply(Gene.i,2,mean), apply(Gene.j,2,mean)), diag(cor(Gene.i, Gene.j)))
	Gene.i.diff = Gene.i[,-1]-Gene.i[,-6];	Gene.j.diff = Gene.j[,-1]-Gene.j[,-6]
	X.ij = c(X.ij, cor(as.vector(Gene.i.diff), as.vector(Gene.j.diff)), 
		cor(apply(Gene.i.diff,2,mean), apply(Gene.j.diff,2,mean)), diag(cor(Gene.i.diff, Gene.j.diff)))
	X.train = rbind( X.train, X.ij)
}}

X.valid = NULL
for (i in 1:(dim(DATA.valid)[1]-1)){
for (j in (i+1):dim(DATA.valid)[1]){
	Gene.i = matrix(DATA.valid[i,],95,6,byrow=TRUE)
	Gene.j = matrix(DATA.valid[j,],95,6,byrow=TRUE)
	X.ij = c(min(mean(Gene.i), mean(Gene.j)), max(mean(Gene.i), mean(Gene.j)), 
		min(var(DATA.valid[i,]), var(DATA.valid[j,])), max(var(DATA.valid[i,]), var(DATA.valid[j,])),
		cor(DATA.valid[i,], DATA.valid[j,]), cor(apply(Gene.i,2,mean), apply(Gene.j,2,mean)), diag(cor(Gene.i, Gene.j)))
	Gene.i.diff = Gene.i[,-1]-Gene.i[,-6];	Gene.j.diff = Gene.j[,-1]-Gene.j[,-6]
	X.ij = c(X.ij, cor(as.vector(Gene.i.diff), as.vector(Gene.j.diff)), 
		cor(apply(Gene.i.diff,2,mean), apply(Gene.j.diff,2,mean)), diag(cor(Gene.i.diff, Gene.j.diff)))
	X.valid = rbind(X.valid, X.ij)
}}
colnames(X.train) = colnames(X.valid) = c("Mean.min", "Mean.max", "Var.min", "Var.max", 
		"Cor.all", "Cor.time", "Cor.1", "Cor.2", "Cor.3", "Cor.4", "Cor.5", "Cor.6",
		"Cor.all.diff", "Cor.time.diff", 
		"Cor.1.diff", "Cor.2.diff", "Cor.3.diff", "Cor.4.diff", "Cor.5.diff")

