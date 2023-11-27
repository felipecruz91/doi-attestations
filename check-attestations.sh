#!/bin/sh


# Initialize variables
image=""

# Loop through all arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --image)
            # Check if there is a value after the option
            if [[ -n "$2" && ! "$2" =~ ^- ]]; then
                image="$2"
                shift 2  # Shift by 2 to skip both the option and its value
            else
                echo "Error: Missing value for --image option."
                exit 1
            fi
            ;;
        *)
            # Handle other options or arguments if needed
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift  # Move to the next argument
done


SBOM=$(docker buildx imagetools inspect $image --format '{{ json (index .SBOM) }}')
if [ "$SBOM" = "{}" ]; then
    SBOM_CHECK=❌
else
    SBOM_CHECK=✅
fi

Provenance=$(docker buildx imagetools inspect $image --format '{{ json (index .Provenance) }}')
if [ "$Provenance" = "{}" ]; then
    PROVENANCE_CHECK=❌
else
    PROVENANCE_CHECK=✅
fi

echo "[$SBOM_CHECK] SBOM - [$PROVENANCE_CHECK] Provenance - [$image]"
