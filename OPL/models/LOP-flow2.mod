
int nbGenes = ...;

range Genes = 1..nbGenes;

int preference [Genes][Genes] = ... ;

dvar boolean z[Genes][Genes][Genes];
dvar boolean x[Genes][Genes];


 maximize sum(i,j in Genes:i!=j) preference[i][j]*x[i][j];
 		
 subject to{

   	forall(i,j in Genes :i<j)  x[i][j] + x[j][i] ==1;

	//forall(i,j,k in Genes: i!=j && j!=k)  x[i][j] + x[j][k] + x[k][i]<= 2;
	
	forall(i in Genes)  x[i][i] + z[i][i][i] + sum(j in Genes) z[i][j][i] + sum(j in Genes) z[j][i][i] + sum(j in Genes) z[i][i][j]  <= 0;

/*
   	forall(i,j,k in Genes: i!=j && j!=k) z[i][j][k] <= x[i][j];
   	forall(i,j,k in Genes: i!=j && j!=k) z[i][j][k] <= x[j][k];
*/
	forall(i,j,k in Genes: i!=j && j!=k) 3 * z[i][j][k] <= x[i][j]+ x[i][k]+ x[j][k];
   	   	
   	forall(i,j,k in Genes: i!=j && j!=k && i!=k)  z[i][j][k] + z[i][k][j] + z[j][i][k] + z[j][k][i] + z[k][i][j] + z[k][j][i] == 1;
   	

 }
