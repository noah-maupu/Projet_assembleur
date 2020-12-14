#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>


/* Programme d'entraînement au calcul mental pour les enfants */



int somme(int a, int b)
{
   return a + b;
}

int difference(int a, int b)
{
   return a - b;
}

int produit(int a, int b)
{
   return a * b;
}

double quotient(int a, int b)
{
   return a / b;
}

int rand_pers()
{
  printf("entrer un entier\n");
  int a;
  scanf("%d", &a);
  return a;
}

int niveau ()
{
  int ChoixDuNiveau;
  printf("CHOIX DU NIVEAU\n");
  printf ("1. niveau facile\n");
  printf ("2. niveau moyen\n");
  printf ("3. niveau difficile\n");
  printf("4. sortie du jeu\n");
  printf("\nVotre choix ? ");
  scanf("%d", &ChoixDuNiveau);
  printf("\n");
return ChoixDuNiveau;

}

//float calc_score()

int main()
{

  int N;
  int res;
  int a;
  int nb_bon_res=0;
  int nb_calc=0;
  while(N!=4)
  {
    N=niveau();
    if (N==4)
    {
      break;
    }
//switch (N)
//  {
    int op_1;
    int op_2;
//    case 1:
    if (N==1)
    {
      printf("Vous avez choisi le niveau facile\n");
      op_1=rand_pers(); //random entre 0 et 100 
      op_2=rand_pers();
      printf("\ncalculer: %d + %d =  \n", op_1, op_2);
      scanf("%d",&a);
      res=somme(op_1, op_2);
      nb_calc+=1;
      if (res==a)
      {
        nb_bon_res+=1;
      }
      printf("res=%d\n", res);
      printf("a=%d\n", a);
    }

//    case 2:
    else if (N==2)
    {
      printf("Vous avez choisi le niveau moyen\n");
      op_1=rand_pers();//random entre 0 et 100
      op_2=rand_pers();
      printf("\ncalculer: %d - %d =  \n", op_1, op_2);
      scanf("%d",&a);
      res=difference(op_1, op_2);
      nb_calc+=1;
      if (res==a)
      {
        nb_bon_res+=1;
      }

    }
    
//    case 3:
    else if (N==3)
    {
      printf("Vous avez choisi le niveau difficile\n");
      op_1=rand_pers(); //random entre 0 et 10
      op_2=rand_pers();
      printf("\ncalculer: %d * %d =  \n", op_1, op_2);
      scanf("%d",&a);
      res=produit(op_1, op_2);
      nb_calc+=1;
      if (res==a)
      {
        nb_bon_res+=1;
      }
      printf("res=%d\n", res);
      printf("a=%d\n", a);
    }

    printf("Ton score est de %d/%d\n\n\n", nb_bon_res, nb_calc);
  }

  float nb_calc_sc=nb_calc;
  float nb_bon_res_sc=nb_bon_res;
  float score=(nb_bon_res_sc/nb_calc_sc)*100;
  printf("Ton score final est de %.2f\n", score);
  if (score>99)
  {
    printf("Excellent!\n");
  }
  else if (score<99 && score>75)
  {
    printf("Très Bien!\n");
  }
  else if (score < 75 && score >50)
  {
    printf("Bien!\n");
  }
  else if (score < 50 && score >25)
  {
    printf("Vous pouvez mieux faire!\n");
  }
  else
  {
    printf("Exercez vous à nouveau!\n");
  }
return 0;
}



 




  /*if (res1==a && res2==b && res3==c && res4==d)
  {
  printf("le score est de 100/100");
  printf(" très bien!\n");
  }

  else if (res1!= a || res2!=b || res3!=c || res4!=d)
  {
  printf(" le score est de 75/100");
  printf("Bien!\n");
  }
  else if ((res1!=a && res2!=b) || (res3!=c && res4!=d) || (res1 !=a && res4!=d) || (res2!=b && res3!=c))
  {
  printf("le score est de 50/100");
  printf("Assez bien\n");
  }
  else if ( (res1!=a && res2!=b && res3!=c) || (res1!= a && res2!=b && res4!=d) )
  {
  printf("le score est de 25/100");
  printf("Vous pouvez mieux faire\n");
  }

  else if ( res1!=a && res2!=b && res3!=c && res4!=d)
  {
  printf("le score est de 0/100");
  printf("Exercez vous à nouveau\n");
  }


       break;
    case 2:
       printf("Vous avez choissi le niveau moyen");
       break;
    case 3:
       printf("Vous avez choissi le niveau difficile");
       break;
    default:
       printf("Vous n'avez pas rentre un nombre correct");
       break;
  }*/

 
/*

  if(N==2)
  {

  }


  if(N==3)
  {

  }

  */
