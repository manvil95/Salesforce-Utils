<table>
  <tr>
    <td width="40%" align=center><img src="./img/Salesforce-Logo.png" width="200"/><br><br></b><h2>Commands and Scripts for Salesforce</h2><br><br><p><b>Repository with tools, tricks, commands and resources for Salesforce development and administration.</p></td>
    <td>
<br>
	    
* ⚙ [**Commands and Scripts for Salesforce**](#commands-and-scripts-for-salesforce)
  * [Retrieve metadata](#retrieve-metadata)
  * [Save logs beyond debugs logs](#save-logs-beyond-debugs-logs)
  * [List ORGs](#list-orgs)
  * [Show ORG alias and value](#show-org-alias-and-value)
  * [Delete an org](#delete-an-org)
  * [Show ORG Description](#show-org-description)
  * [Unset Alias ORG](#unset-alias-org)
  * [Create package in manifest folder](#create-package-in-manifest-folder)
  * [Retrieve from package.xml](#retrieve-from-packagexml)
  * [SalesforceTreeAPI](#salesforcetreeapi)
  * [No reconoce ORGs](#no-reconoce-orgs)
* ⌨ [**Scripts**](#scripts)
  * [Execute Test in Package on deploy](#execute-test-in-package-on-deploy)
 
  <br>
    </td>
  </tr>

</table>


## Commands and Scripts for Salesforce

<!--<table>
  <tr>
    <th>Título y Descripción</th>
    <th>Comandos</th>
  </tr>
  <tr>
    <td><b>Retrieve metadata</b></td>
    <td>
      <pre><code>
sfdx force:source:retrieve -m CustomObject:CustomObject__c
sfdx force:source:retrieve -m ApexClass:MyApexClass
sfdx force:source:retrieve -m Profile:Admin
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>Save logs beyond debugs logs</b><br>Enter this command in the VS Code terminal.<br>Leave it running while performing the desired actions.<br>Save file in root folder and put in the <code>log.txt</code> file all the logs that are produced.<br>Also, you can retrieve apex log in VS Code: <code>Ctrl + Shif + P</code> Log: Retrieve Apex Log And Show Analysis.</td>
    <td>
      <code>sfdx force:apex:log:tail --color &gt; log.txt</code>
    </td>
  </tr>
  <tr>
    <td><b>List ORGs</b></td>
    <td>
      <code>sfdx force:org:list</code>
	      <code>sf org list</code>
    </td>
  </tr>
  <tr>
    <td><b>Show ORG alias and value</b></td>
    <td>
      <pre><code>
sfdx alias:list
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>Delete an org</b></td>
    <td>
      <pre><code>
sfdx force:org:delete -p -u 'YOUR_ORG_ALIAS_NAME'
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>Show ORG Description</b></td>
    <td>
      <pre><code>
sfdx force:org:display
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>Unset Alias ORG</b></td>
    <td>
      <pre><code>
sfdx alias:unset YourAlias
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>Create package in manifest folder</b></td>
    <td>
      <pre><code>
sfdx force source manifest create --source-dir force-app/main/default 
	      --output-dir manifest 
	      --name=package
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>Retrieve from package.xml</b></td>
    <td>
      <pre><code>
sfdx project retrieve start -o <Nombre-Org> -x .\Package.xml
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>SalesforceTreeAPI</b></td>
    <td>
      <pre><code>
sfdx force:data:tree:import
      </code></pre>
    </td>
  </tr>
  <tr>
    <td><b>No reconoce ORGs</b><br>Si no reconoce el valor de la ORG<br># Logout all orgs<br># Volver a conectar</td>
    <td>
      <pre><code>
sfdx force:org:list
sfdx alias:list
sfdx alias:unset XXXX
      </code></pre>
    </td>
  </tr>
</table>
-->



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

#### No reconoce ORGs

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
