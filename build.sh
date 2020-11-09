set -x

PACK_VERSION=$TRAVIS_TAG

[[ -z $PACK_VERSION ]] && exit

SUFFIX=-$PACK_VERSION
DISPLAY_NAME=Invictus$SUFFIX
RELEASE_FILE=releases/$DISPLAY_NAME.zip

PROJECTID=220720

PACK_FORMAT=$(echo $PACK_VERSION | cut -d. -f1)
# Many ids are red herrings. Weird to have an API without any documentation.
VERSION_DATA=$(curl -X GET "https://minecraft.curseforge.com/api/game/versions" -H "X-Api-Token: $CURSEFORGE_INVICTUS_TOKEN")
if [[ $PACK_FORMAT == 1 ]]; then
  GAME_IDS=$(jq -rc '[.[] | select(((.name | startswith("1.6")) or (.name | startswith("1.7")) or (.name | startswith("1.8"))) and (.gameVersionTypeID==(6, 5, 4))) | .id]' <<< "$VERSION_DATA")
elif [[ $PACK_FORMAT == 2 ]]; then
  GAME_IDS=$(jq -rc '[.[] | select(((.name | startswith("1.9")) or (.name | startswith("1.10"))) and (.gameVersionTypeID==(552, 572))) | .id]' <<< "$VERSION_DATA")
elif [[ $PACK_FORMAT == 3 ]]; then
  GAME_IDS=$(jq -rc '[.[] | select(((.name | startswith("1.11")) or (.name | startswith("1.12"))) and (.gameVersionTypeID==(599, 628))) | .id]' <<< "$VERSION_DATA")
elif [[ $PACK_FORMAT == 4 ]]; then
  GAME_IDS=$(jq -rc '[.[] | select(((.name | startswith("1.13")) or (.name | startswith("1.14"))) and (.gameVersionTypeID==(55023, 64806))) | .id]' <<< "$VERSION_DATA")
elif [[ $PACK_FORMAT == 5 ]]; then
  GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.15")) and (.gameVersionTypeID==68722)) | .id]' <<< "$VERSION_DATA")
elif [[ $PACK_FORMAT == 6 ]]; then
  GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.16")) and (.gameVersionTypeID==70886)) | .id]' <<< "$VERSION_DATA")
elif [[ $PACK_FORMAT == 7 ]]; then
  exit
else
  exit
fi

mkdir -p releases
rm -f "$RELEASE_FILE"
zip -r "$RELEASE_FILE" .  -x "*/\__MACOSX" -x "\.*" -x "build.sh" -x "releases/*" -x "token.txt" -x "run_build.sh"

curl -X POST -H "X-Api-Token: $CURSEFORGE_INVICTUS_TOKEN" -F metadata="{\"changelog\":\"https://github.com/InvictusGraphics/Invictus_Textures/commits/master\",\"changelogType\":\"text\",\"displayName\":\"$DISPLAY_NAME\",\"gameVersions\":$GAME_IDS,\"releaseType\":\"release\"}" -F file=@"$RELEASE_FILE" "https://minecraft.curseforge.com/api/projects/$PROJECTID/upload-file"
