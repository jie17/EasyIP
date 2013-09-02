#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define N 3
char *NAME[N],*IP[N],*GW[N],*YM[N],*DNS1[N],*DNS2[N],*NET[N],TEMP[1000];
void DELETE ( char *data )
{
     char *a;
     for ( a=data ; *a!= '\0' ; a++)
     {
         if ( *a == '\n' )
         *a = '\0';
     }
}
void EDIT()
{
	int i,a;
	FILE *add;
	putchar('\n');
	for ( i = 1 ; i <= N ; i++ )
		printf("%d.%s" , i , NAME[i-1] );
	putchar('\n');
	printf("1.Add\n2.Delete\n3.Open with Notepad\n0.Back to Menu\n");
	scanf("%d",&a);
	if ( a == 3 )
		system ("IP.txt");
	if ( a == 0 )
	{
		putchar ( '\n' );
		return;
	}
	EDIT();
}
void CLEAR ()
{
	system ("netsh interface ipv4 set address 本地连接 source=dhcp\nnetsh interface ipv4 set address 无线网络连接 source=dhcp" );
}
void PrintMenu()
{
	int i,choice;
	FILE *fp;
	if ( !( fp = fopen ( "IP.txt" , "r") ) ) exit(0);
	for ( i = 0 ; i < N ; i++ )
	{
		NAME[i] = (char*) malloc ( 20 * sizeof(char) );
		IP[i] = (char*) malloc ( 20 * sizeof(char) );
		GW[i] = (char*) malloc ( 20 * sizeof(char) );
		YM[i] = (char*) malloc ( 20 * sizeof(char) );
		DNS1[i] = (char*) malloc ( 20 * sizeof(char) );
		DNS2[i] = (char*) malloc ( 20 * sizeof(char) );
		NET[i] = (char*) malloc ( 20 * sizeof(char) );
		printf ( "%d:" , i+1 );
		fputs( fgets ( NAME[i] , 20 , fp ) , stdout );
		DELETE ( fgets ( IP[i] , 20 , fp ) );		
		DELETE ( fgets ( GW[i] , 20 , fp ) );
		DELETE ( fgets ( YM[i] , 20 , fp ) );
		DELETE ( fgets ( DNS1[i] , 20 , fp ) );
		DELETE ( fgets ( DNS2[i] , 20 , fp ) );
		DELETE ( fgets ( NET[i] , 20 , fp ) );
	}
	fclose ( fp );
	printf ( "%d:Auto\n%d:Edit\n0:Exit\n" , N+1 ,N+2 );
	scanf( "%d" , &choice );
	if ( choice == 0 ) 
		exit(0);
	if ( choice < N+1 )
	{
		strcpy ( TEMP , "netsh interface ipv4 set dnsservers name=" );
		strcat ( TEMP , NET[choice-1] );
		strcat ( TEMP , " static " );
		strcat ( TEMP , DNS1[choice-1] );
		strcat ( TEMP , " primary validate=no" );
		system(TEMP);
		strcpy ( TEMP , "netsh interface ipv4 add dnsservers ");
		strcat ( TEMP , NET[choice-1] );
		strcat ( TEMP , " ");
		strcat ( TEMP , DNS2[choice-1] );
		strcat ( TEMP , " validate=no\n" );
		system(TEMP);
		strcpy ( TEMP , "netsh interface ipv4 set address ");
		strcat ( TEMP , NET[choice-1] );
		strcat ( TEMP , " static ");
		strcat ( TEMP , IP[choice-1] );
		strcat ( TEMP , " " );
		strcat ( TEMP , YM[choice-1]  );
        	strcat ( TEMP , " " );
		strcat ( TEMP , GW[choice-1]  );
		CLEAR ();
		system(TEMP);
		exit ( 0 );
 	}
	if ( choice == N+1 )
		CLEAR ();
	if ( choice == N+2 )
		EDIT();
	PrintMenu();
}
int main()
{
	while(1)
		PrintMenu();
	return 0;
}
