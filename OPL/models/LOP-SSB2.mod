/*********************************************
 * OPL 20.1.0.0 Model
 * Author: nd
 * Creation Date: Dec 25, 2021 at 4:04:23 PM
 *********************************************/


int nbGenes = ...;

range Genes = 1..nbGenes;

int preference [Genes][Genes] = ... ;

dvar boolean x[Genes][Genes];
dvar boolean y[Genes][Genes];
dvar boolean last[Genes];
dvar boolean first[Genes];

 maximize
	sum(i,j in Genes:i!=j) preference[i][j]*x[i][j];
 		
 subject to{

   	forall(i,j in Genes :i<j)   x[i][j] + x[j][i] ==1;

   	forall(i in Genes)  x[i][i] <= 0;

   	forall(i in Genes)  first[i] + last[i] <= 1;

   	forall(i,j in Genes) 	  y[i][j] <= x[i][j];

  	forall(i,j,k in Genes: i!=j && j!=k)	  x[i][j] + y[j][i] + x[j][k] + x[k][i]<= 2;
  	  
	forall(i in Genes)  first[i] + sum(j in Genes) y[j][i]  == 1;
	
	forall(i in Genes) last[i] + sum(j in Genes) y[i][j]  == 1;    
	
	sum(i in Genes)  first[i]  == 1;
	
	sum(i in Genes)  last[i]  == 1;
  	  
//  	  forall(i,j,k in Genes) x[i][j] + x[j][k] + x[k][i]<= 2;
 }
