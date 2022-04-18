
int nbGenes = ...;

range Genes = 1..nbGenes;

int preference [Genes][Genes] = ... ;

dvar boolean z[Genes][Genes][Genes];
dvar boolean x[Genes][Genes];
dvar boolean y[Genes][Genes];
dvar boolean last[Genes];
dvar boolean first[Genes];

//dexpr float x[i in Genes][j in Genes] = last[j]+ sum(k in Genes) z[i][j][k];
//dexpr float y[i in Genes][j in Genes] = z[i][i][j];

 maximize sum(i,j in Genes:i!=j) preference[i][j]*x[i][j];
 		
 subject to{

   	forall(i,j in Genes)  x[i][j]  == last[j] + sum(k in Genes) z[i][j][k];

   	forall(i,j in Genes :i<j)  x[i][j] + x[j][i] ==1;
   	
   	forall(j,k in Genes)  sum(i in Genes) z[i][j][k] <= nbGenes * y[j][k];

	forall(i in Genes)  first[i] + sum(j in Genes) y[j][i]  == 1;
	
	forall(i in Genes) last[i] + sum(j in Genes) y[i][j]  == 1;    

	sum(i in Genes)  first[i]  == 1;
	
	sum(i in Genes)  last[i]  == 1;

	//sum(i in Genes)  first[i] + last[i]  <= 1;

  	forall(j,k in Genes: j!=k) last[j] + sum(i in Genes)  z[k][j][i]  == sum(i in Genes)  z[k][i][j];

  	forall(j in Genes)  last[j] + sum(i in Genes)  z[j][j][i]  == 1;



 }
