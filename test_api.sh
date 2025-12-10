#!/bin/bash

echo "=== 1. GET todos los eventos ==="
curl -s -i http://localhost:8000/api/eventos | head -20
echo -e "\n\n"

echo "=== 2. POST crear nuevo evento ==="
RESPONSE=$(curl -s -X POST http://localhost:8000/api/eventos \
  -H "Content-Type: application/json" \
  -d '{"titulo":"Escuela Pública de Código","descripcion":"Finaliza oficialmente la etapa 2 de actividad 5A","fecha_inicio":"2025-06-01","fecha_fin":"2025-06-11","ubicacion":"Meet"}')
echo "$RESPONSE" | head -20
EVENTO_ID=$(echo "$RESPONSE" | grep -o '"id":[0-9]*' | tail -1 | grep -o '[0-9]*')
echo "ID del evento creado: $EVENTO_ID"
echo -e "\n\n"

echo "=== 3. GET evento específico (id=$EVENTO_ID) ==="
curl -s -i http://localhost:8000/api/eventos/$EVENTO_ID | head -20
echo -e "\n\n"

echo "=== 4. PUT actualizar evento (id=$EVENTO_ID) ==="
curl -s -i -X PUT http://localhost:8000/api/eventos/$EVENTO_ID \
  -H "Content-Type: application/json" \
  -d '{"titulo":"EPC","descripcion":"Finaliza la etapa 3 de actividad 5A","fecha_inicio":"2025-06-09","fecha_fin":"2025-06-11","ubicacion":"Google meet"}' | head -20
echo -e "\n\n"

echo "=== 5. GET evento actualizado (id=$EVENTO_ID) ==="
curl -s -i http://localhost:8000/api/eventos/$EVENTO_ID | head -20
echo -e "\n\n"

echo "=== 6. DELETE evento (id=$EVENTO_ID) ==="
curl -s -i -X DELETE http://localhost:8000/api/eventos/$EVENTO_ID
echo -e "\n\n"

echo "=== 7. Intentar GET evento eliminado (id=$EVENTO_ID) ==="
curl -s -i http://localhost:8000/api/eventos/$EVENTO_ID
