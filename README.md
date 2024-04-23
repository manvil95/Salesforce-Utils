# Salesforce-Utils

<table>
  <tr>
    <td width="40%" align=center><img src="./img/Salesforce-Logo.png" width="200"/><br><br></b><p><b>Repository with tools, tricks, commands and resources for Salesforce development and administration.</p></td>
    <td>

## _Table of content_

- ⚙ [**LWC**](#lwc)
- 💻 [**Command Issues**](#command-issues)
  - [Useful commands](#useful-commands)
  - [No reconoce orgs](#no-reconoce-orgs)
- 📚 [**SOQL**](#soql)
  - [Chain LIKE and NOT LIKE](#chain-like-and-not-like)
  - [Subquery examples](#subquery-examples)
- [**Apex**](#apex)
  - [Alcanzar límite de queries](#alcanzar-límite-de-queries)
- [**Naming Convention**](#naming-convention)
- [**VS Code Tricks**](#vs-code)
  - [Tricks](#tricks)
  - [UNABLE TO GET ISSUER CERT LOCALLY](#unable-to-get-issuer-cert-locally)
  - [My settings.json](#my-settingsjson)
    </td>
  </tr>

</table>

## LWC

- [Advanced Salesforce LWC debugging with Chrome Developer Tools](https://beyondthecloud.dev/blog/chrome-dev-tools-for-salesforce-lwc-developers)

> [!TIP]
> Evita Visualforce Page. 😊

## Command Issues

### Useful commands

```shell
# Traer datos de la fuente
sfdx force:source:retrieve -m CustomObject:CustomObject__c
sfdx force:source:retrieve -m ApexClass:MyApexClass
sfdx force:source:retrieve -m Profile:Admin

# Si poneis en la terminal de vscode este comando 
sfdx force:apex:log:tail --color > log.txt
# Dejar ejecutando mientras se prueba
# Guarda archivo en carpeta raíz
# mete en el archivo log.txt todos los logs que vayan saliendo

# Listar ORG
sfdx force:org:list

# Mostrar alias y Value de las ORG
sfdx alias:list

# Borrar una org
sfdx force:org:delete -p -u 'YOUR_ORG_ALIAS_NAME'

# Mostrar ORG Description
sfdx force:org:display 

# Unset Alias ORG
sfdx alias:unset YourAlias

# Retrieve a través de package.xml
sfdx project retrieve start -o <Nombre-Org> -x .\Package.xml

 # SalesforceTreeAPI
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

## SOQL

### Chain LIKE and NOT LIKE

```sql
# Forma de encadenar varios LIKE y NOT LIKE
SELECT Name
FROM Object
WHERE (NOT Name LIKE 'ST%')
  AND (NOT Name LIKE 'PA%')

# Bind 
SELECT Name FROM Object
WHERE (NOT Name LIKE 'ST%')
  AND (Name NOT IN :var)
```

### Subquery examples

```sql
SELECT Name 
FROM Account 
WHERE Id NOT IN 
  (
    SELECT AccountId 
    FROM Opportunity 
    WHERE IsClosed = true
  )
```

## Apex

### Alcanzar límite de queries

Si se va a alcanzar el límite de queries por DML en bucle:

  1. Poner método -> último en el Trigger Handler
  2. Controlar con siguiente if y romper proceso.
  3. Invocar framework de control de errores si lo hay

```java

if (Limits.getQueries() < Limits.getLimitQueries() {
  insert sObjectList;
}
else {
  ErrorLog__c.insertError();
  break;
}
```

## Naming convention

### _Object Fields_

| **Field Type**            | **API Name**                 |
|---------------------------|------------------------------|
| Auto Number               | **AUT**_AutoNumberField__c   |
| Boolean                   | **FLG**_BooleanField__c      |
| Currency                  | **DIV**_CurrencyField__c     |
| Date & DateTime           | **DAT**_DateTimeField__c     |
| Email                     | **EMA**_EmailField__c        |
| Formula                   | **FOR**_FormulaField__c      |
| Geolocation               | **GEO**_GeolocationField__c  |
| Lookup                    | **LKP**_LookUpField__c       |
| Multi-Select Picklist     | **MSE**_MultiSelectField__c  |
| Number                    | **NUM**_NumberField__c       |
| Percent                   | **PER**_PercentField__c      |
| Phone                     | **TEL**_PhoneField__c        |
| Picklist                  | **SEL**_PicklistField__c     |
| Roll-Up Summary           | **RUS**_RollUpSummaryField__c|
| Text                      | **TXT**_TextField__c         |
| Time                      | **HOR**_TimeField__c         |
| URL                       | **URL**_URLField__c          |

### _Metadata_

| **Metadata Type**         | **API Name**                 |
|---------------------------|------------------------------|
| Flow                      | **FLW**_FlowName             |
| Lightning Page            | **LP**_PageName              |
| Path                      | **PTH**_PathName             |
| Tab                       | **TAB**_TabName              |
| Validation Rule           | **VR**_PathName              |

### _Trigger and Classes_

| **Metadata Type**         | **API Name**                 |
|---------------------------|------------------------------|
| Trigger                   | **TRG**_TriggerName          |
| Trigger Handler           | **TRG**_ClassName**Handler** |
| Helper                    | **TRG**_ClassName**Helper**  |
| Batch                     | **BATCH**_ClassName          |
| Scheduler                 | **SCH**_ClassName            |
| Test                      | ClassName_**Test**           |

## VS Code

### Tricks

> [!TIP]
> Es recomendable tener la siguiente línea en tu `settings.json` para detectar conflictos antes de desplegar en la ORG.
>
> ```json
> "salesforcedx-vscode-core.detectConflictsAtSync": true,
> ```

### UNABLE TO GET ISSUER CERT LOCALLY

> [!CAUTION]
> Al hacer `sfdx force:org:list` aparece ese error.
>
> **Solución**: agregar variable de entorno `NODE_TLS_REJECT_UNAUTHORIZED = 0`

### My settings.json

```json
{
    "salesforcedx-vscode-apex.java.home": "",
    "editor.fontLigatures": "'ss01', 'cv03', 'zero'",
    "workbench.iconTheme": "material-icon-theme", 
    "git.confirmSync": false,
    "editor.fontFamily": "JetBrains Mono, Victor Mono, Consolas, 'Courier New', monospace",
    "files.autoSave": "afterDelay",
    "editor.indentSize": "tabSize",
    "salesforcedx-vscode-core.detectConflictsAtSync": true,
    "workbench.tree.enableStickyScroll": true,
    "[json]": {
        "editor.defaultFormatter": "vscode.json-language-features"
    },
    "editor.stickyScroll.enabled": true,
    "editor.guides.bracketPairs": true,
    "editor.cursorBlinking": "expand",
    "editor.scrollbar.verticalScrollbarSize": 8,
    "editor.overviewRulerBorder": false,
    "editor.minimap.autohide": true,
    "editor.minimap.maxColumn": 60,
    "editor.glyphMargin": false,
    "apexPMD.runOnFileOpen": true,
    "symbols.hidesExplorerArrows": false,
    "[xml]": {
        "editor.defaultFormatter": "DotJoshJohnson.xml"
    },
    "workbench.productIconTheme": "fluent-icons",
    "xml.symbols.maxItemsComputed": -5000,
    "codesnap.showWindowControls": false,
    "codesnap.shutterAction": "copy",
    "codesnap.target": "window",
    "settingsSync.ignoredExtensions": [
        
    ],
    "window.zoomLevel": 1,
    "security.workspace.trust.untrustedFiles": "open",
    "editor.cursorSmoothCaretAnimation": "on",
    "editor.bracketPairColorization.independentColorPoolPerBracketType": true,
    "terminal.integrated.stickyScroll.enabled": true,
    "editor.stickyScroll.maxLineCount": 10,
    "workbench.tree.stickyScrollMaxItemCount": 10,
    "editor.stickyScroll.defaultModel": "indentationModel",
    "better-comments.tags": [


        {
            "tag": "!",
            "color": "#FF2D00",
            "strikethrough": false,
            "underline": true,
            "backgroundColor": "transparent",
            "bold": true,
            "italic": false
        },
        {
            "tag": "-->",
            "color": "#C848CE",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": true,
            "italic": false
        },
        {
            "tag": "?",
            "color": "#3498DB",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": true,
            "italic": false
        },
        {
            "tag": "//",
            "color": "#474747",
            "strikethrough": true,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": false,
            "italic": false
        },
        {
            "tag": "todo",
            "color": "#FF8C00",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": true,
            "italic": false
        },
        {
            "tag": "*",
            "color": "#98C379",
            "strikethrough": false,
            "underline": false,
            "backgroundColor": "transparent",
            "bold": true,
            "italic": false
        }
    ],
    "workbench.sideBar.location": "right",
    "workbench.colorTheme": "Night Owl",
    "editor.occurrencesHighlight": "multiFile",
    "workbench.colorCustomizations": {
        "editor.lineHighlightBorder": "#ffffff1f"

    },
    "diffEditor.maxComputationTime": 0,
    "prettier.tabWidth": 4,
    "workbench.settings.applyToAllProfiles": [
        
    ]
}
```

<!-- 
> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]  
> Crucial information necessary for users to succeed.

> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.
-->
