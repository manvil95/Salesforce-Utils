<table>
  <tr>
    <td width="40%" align=center><img src="./img/Salesforce-Logo.png" width="200"/><br><br></b><h2>Commands and Scripts for Salesforce</h2><br><br><p><b>Repository with tools, tricks, commands and resources for Salesforce development and administration.</p></td>
    <td>

## _Table of content_

- ⚙ [**Commands and Scripts for Salesforce**](#commands-and-scripts-for-salesforce)
  - Still in progress...
    </td>
  </tr>

</table>


## Commands and Scripts for Salesforce

#### Retrieve metadata

```shell
sfdx force:source:retrieve -m CustomObject:CustomObject__c
sfdx force:source:retrieve -m ApexClass:MyApexClass
sfdx force:source:retrieve -m Profile:Admin
```

#### Save logs beyond debugs logs

Enter this command in the VS Code terminal.

Leave it running while performing the desired actions.

Save file in root folder and put in the `log.txt` file all the logs that are produced.

```shell
sfdx force:apex:log:tail --color > log.txt
```

Also, you can retrieve apex log in VS Code: `Ctrl + Shif + P` Log: Retrieve Apex Log And Show Analysis.


#### List ORGs

```shell
sfdx force:org:list
sf org list
```

#### Show ORG alias and value

```shell
sfdx alias:list
```

#### Delete an org

```shell
sfdx force:org:delete -p -u 'YOUR_ORG_ALIAS_NAME'
```

#### Show ORG Description

```shell
sfdx force:org:display 
```

#### Unset Alias ORG

```shell
sfdx alias:unset YourAlias
```

#### Create package in manifest folder

```shell
sfdx force source manifest create --source-dir force-app/main/default --output-dir manifest --name=package
```

#### Retrieve from package.xml

```shell
sfdx project retrieve start -o <Nombre-Org> -x .\Package.xml
```

#### SalesforceTreeAPI

```shell
sfdx force:data:tree:import
```

### No reconoce ORGs

```shell
# Si no reconoce el valor de la ORG
sfdx force:org:list
sfdx alias:list

# Logout all orgs
sfdx alias:unset XXXX

# Volver a conectar
```

### Scripts

#### Execute Test in Package on deploy

```sh
#!/bin/bash
# ------------------- Variable para especificar el nombre de la org según VS Code
DESTINATION="<nameORG>";

# ------------------- Especificar Package.xml, solo debe contener clases APEX y nomenclatura para Test.
# ------------------- Ej.: <nombreClase>_Test, <nombreClase>Test
FILE_PACKAGE="manifest/Package.xml";

#------------ Variable para montar el comando de ejecucion de clases especificas del Test
APEXTEST_LIST="";

while read line;
	do
		if [[ $line == *'Test'* ]];
		then
			line=${line/"<members>"/""};
			line=${line/"</members>"/","};
			if [[ $line != *'DataTestFactory'* ]];
			then
				APEXTEST_LIST="$APEXTEST_LIST$line";
			fi
		fi
	done < $FILE_PACKAGE
	
APEXTEST_LIST=${APEXTEST_LIST%,};

# ------------------- Imprimimos el comando lanzado en la terminal
echo "sfdx force:source:deploy -x "${FILE_PACKAGE}" -l RunSpecifiedTests -r "${APEXTEST_LIST}" -c -u "${DESTINATION}" --verbose";

# ------------------- Comando sfdx para validar clases Apex ejecutando Test Especificos
sfdx force:source:deploy -x ${FILE_PACKAGE} -l RunSpecifiedTests -r ${APEXTEST_LIST} -c -u ${DESTINATION} --verbose;
```
