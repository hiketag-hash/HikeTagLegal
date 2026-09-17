#!/bin/bash
set -e

NEW_TAG="1.0.0"
IMAGE="hiketag-legal"
SERVER="hiketag-docker"
TAR="${IMAGE}_${NEW_TAG}.tar"

echo ""
echo "▶ Deploy ${IMAGE}:${NEW_TAG} → ${SERVER}"
echo "────────────────────────────────────"

echo ""
echo "[1/4] Building image pentru linux/amd64..."
docker build --platform linux/amd64 -t "${IMAGE}:${NEW_TAG}" .
echo "      ✓ Build complet"

echo ""
echo "[2/4] Salvare imagine în ${TAR}..."
docker save "${IMAGE}:${NEW_TAG}" -o "${TAR}"
echo "      ✓ Arhivă creată ($(du -sh "${TAR}" | cut -f1))"

echo ""
echo "[3/4] Transfer pe server (${SERVER})..."
scp "${TAR}" "${SERVER}:~"
echo "      ✓ Transfer complet"

echo ""
echo "[4/4] Curățare locală..."
rm -f "${TAR}"
echo "      ✓ Fișier local șters"

echo ""
echo "════════════════════════════════════════"
echo "  Deploy finalizat! Rulează pe server:"
echo ""
echo "  docker load -i ~/${TAR} && rm -f ~/${TAR}"
echo "  docker compose up -d hiketag-legal"
echo ""
echo "  docker compose logs -f hiketag-legal"
echo "════════════════════════════════════════"
echo ""
