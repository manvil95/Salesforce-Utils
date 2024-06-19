<table>
  <tr>
    <td width="40%" align=center><br><img src="./img/Salesforce-Logo.png" width="200"/><br><br></b><h2>Commands and Scripts for Salesforce</h2><br><br><p><b>Repository with tools, tricks, commands and resources for Salesforce development and administration.</p><br></td>
    <td>
<br>
	    
* ⚙ [**Commands**](#commands)
* ⌨ [**Scripts**](#scripts)
  * [Execute Test in Package on deploy](#execute-test-in-package-on-deploy)
 
  <br>
    </td>
  </tr>

</table>


# Commands

<table>
  <tr>
    <th>Título y Descripción</th>
    <th>Comandos</th>
  </tr>
  <tr>
    <td><b>Retrieve metadata</b></td>
    <td>
      <code>sfdx force:source:retrieve -m CustomObject:CustomObject__c</code><br>
      <code>sfdx force:source:retrieve -m ApexClass:MyApexClass</code><br>
      <code>sfdx force:source:retrieve -m Profile:Admin</code>
    </td>
  </tr>
  <tr>
    <td><b>Save logs beyond debugs logs</b><br>- Enter this command in the VS Code terminal.<br>
	    - Leave it running while performing the desired actions.<br>- Save file in root folder and put in the <code>log.txt</code> file all the logs that are produced.<br>
	    - Also, you can retrieve apex log in VS Code: <code>Ctrl + Shif + P</code> Log: Retrieve Apex Log And Show Analysis.</td>
    <td>
      <code>sfdx force:apex:log:tail --color &gt; log.txt</code>
    </td>
  </tr>
  <tr>
    <td><b>List ORGs</b></td>
    <td>
      <code>sfdx force:org:list</code><br>
      <code>sf org list</code>
    </td>
  </tr>
  <tr>
    <td><b>Show ORG alias and value</b></td>
    <td>
      <code>sfdx alias:list</code>
    </td>
  </tr>
  <tr>
    <td><b>Delete an org</b></td>
    <td>
      <code>sfdx force:org:delete -p -u 'orgName'</code>
    </td>
  </tr>
  <tr>
    <td><b>Show ORG Description</b></td>
    <td>
      <code>sfdx force:org:display</code>
    </td>
  </tr>
  <tr>
    <td><b>Unset Alias ORG</b></td>
    <td>
      <code>sfdx alias:unset YourAlias</code>
    </td>
  </tr>
  <tr>
    <td><b>Create package from source in manifest folder</b></td>
    <td>
      <code>sfdx force source manifest create --source-dir force-app/main/default --output-dir manifest --name=package_source</code>
    </td>
  </tr>
  <tr>
    <td><b>Create package from org in manifest folder</b></td>
    <td>
      <code>sf project generate manifest --from-org OrgName --output-dir manifest --name=package_org</code>
    </td>
  </tr>
  <tr>
    <td><b>Retrieve from package.xml</b></td>
    <td>
      <code>sfdx project retrieve start -o OrgName -x .\Package.xml</code>
    </td>
  </tr>
  <tr>
    <td><b>SalesforceTreeAPI</b></td>
    <td>
      <code>sfdx force:data:tree:import</code>
    </td>
  </tr>
  <tr>
    <td><b>No reconoce ORGs</b><br>Si no reconoce el valor de la ORG<br>Logout all orgs<br>Volver a conectar</td>
    <td>
      <code>sfdx force:org:list</code><br>
      <code>sfdx alias:list</code><br>
      <code>sfdx alias:unset XXXX</code>
    </td>
  </tr>
</table>

# Scripts

## Execute Test in Package on deploy

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
