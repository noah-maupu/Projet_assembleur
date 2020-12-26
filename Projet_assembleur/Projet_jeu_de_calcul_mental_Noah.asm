	.data
intro:	.asciiz "Bienvenue sur le jeu de calcul mental !\n"
choice: .asciiz "CHOIX DU NIVEAU"
easy:	.asciiz  "Vous avez choisi le niveau facile"
moyen:	.asciiz "Vous avez choisi le niveau moyen"
hard:	.asciiz "Vous avez choisi le niveau difficile"
sortie:	.asciiz "Vous allez sortir du programme"
niv_1:	.asciiz "Tapez 1 pour le niveau facile"
niv_2:	.asciiz "Tapez 2 pour le niveau moyen"
niv_3:	.asciiz "Tapez 3 pour le niveau difficile"
fin_4:	.asciiz "Tapez 4 pour sortir du programme et afficher votre résultat"
score:	.asciiz "Ton score est de"
score_f:.asciiz "Ton score final est de"
com_1: 	.asciiz "Excellent!"
com_2:	.asciiz "Très Bien!"
com_3:	.asciiz "Bien!"
com_4:	.asciiz "Vous pouvez mieux faire!"
com_5: 	.asciiz "Exercez vous à nouveau!"
calc:	.asciiz "Calculer l'addition entre "
et:	.asciiz " et "
rt:	.asciiz "\n"
vrai:	.asciiz "Bonne réponse"
faux:	.asciiz "Mauvaise réponse"
text_1:	.asciiz "La bonne réponse est : "
mess_mauvais_choix:
	.asciiz "Vous avez fait un mauvais choix, veuillez faire un choix valide"
mess_nb_calc:
	.asciiz "Indiquer le nombre d'opération que vous voulez faire"

	.text
main:	
	#Allocation du bloc de pile de la fonction main()
	addiu $sp, $sp, -64
	sw $fp, 60($sp)
	addiu $fp, $sp, 64
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	
	#affichage du message d'intro
	la $a0, intro
	ori $v0, $zero, 4
	syscall
	
	
	
	ori $v0, $zero, 10
	syscall
	
	

		
Fctmultiplication:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	mult $t0,$t1
	
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra		
	
	
