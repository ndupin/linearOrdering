/*********************************************
 * OPL 20.1.0.0 Model
 * Author: nd
 * Creation Date: Dec 25, 2021 at 4:04:23 PM
 *********************************************/


int nbGenes = ...;

range Genes = 1..nbGenes;

int preference [Genes][Genes] = ... ;

dvar boolean x[Genes][Genes];
//dvar float+ x[Genes][Genes];

dvar float+ n[Genes];
//dexpr float n[i in Genes] = nbGenes-1 - sum(j in Genes: j!=i)  x[i][j];


 maximize sum(i,j in Genes:i!=j) preference[i][j]*x[i][j];
 		
 subject to{

   	forall(i,j in Genes :i<j)  x[i][j] + x[j][i] ==1;

   	forall(i in Genes)  x[i][i] <= 0;

  	forall(i,j in Genes: i!=j)   n[j] + (1+nbGenes)*(1-x[i][j]) >= n[i] +1;

	forall(i in Genes)  n[i] + sum(j in Genes: j!=i)  x[i][j]   == nbGenes-1 ;
 
 }
 
execute ECRIT_FICHIER_SORTIE{
    
  var file = new IloOplOutputFile();
  file.open("relax.dat");
  file.write("relax =  ", x,";");
  file.close();

}  

