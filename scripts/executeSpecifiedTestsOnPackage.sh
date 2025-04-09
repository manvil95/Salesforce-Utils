#!/bin/bash
# ------------------- Variable para especificar el nombre de la org según VS Code
DESTINATION="<nameORG>";

# ------------------- Especificar Package.xml, solo debe contener clases APEX y nomenclatura para Test.
# ------------------- Ej.: <nombreClase>_Test, <nombreClase>Test
FILE_PACKAGE="manifest/Package.xml";

# ------------------- Configuración adicional (opcional)
WAIT_TIME=33 # minutos para esperar la ejecución
COVERAGE_FORMATTERS="json-summary" # formato para reportes de cobertura
RESULTS_DIR="test-results" # directorio para resultados

#------------ Variable para montar el comando de ejecucion de clases especificas del Test
APEXTEST_LIST="";

# Procesar Package.xml para obtener tests
while read line; do
    if [[ $line == *'Test'* ]]; then
        line=${line/"<members>"/""};
        line=${line/"</members>"/""};
        if [[ $line != *'DataTestFactory'* ]]; then
            # Formatear para el comando sf (sin comas, múltiples --tests)
            APEXTEST_LIST="$APEXTEST_LIST --tests $line";
        fi
    fi
done < $FILE_PACKAGE

# ------------------- Construir y mostrar el comando
COMMAND="sf project deploy start \
    --manifest ${FILE_PACKAGE} \
    --test-level RunSpecifiedTests \
    ${APEXTEST_LIST} \
    --target-org ${DESTINATION} \
    --dry-run \
    --verbose \
    --wait ${WAIT_TIME} \
    --coverage-formatters ${COVERAGE_FORMATTERS} \
    --results-dir ${RESULTS_DIR} \
    --junit";

echo "Comando a ejecutar:";
echo $COMMAND;

# ------------------- Ejecutar el comando
eval $COMMAND;

# ------------------- Opcional: Mostrar resumen si hay resultados JUnit
if [ -f "${RESULTS_DIR}/junit/junit.xml" ]; then
    echo "=== Resumen de Tests JUnit ===";
    grep -E "(testsuite|testcase|failure)" "${RESULTS_DIR}/junit/junit.xml";
fi