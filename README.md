# doi-attestations

A script that checks whether SBOM and Provenance attestations are present in the `latest` tag of DOI (Docker Official Image).

## Usage

1. Generate a text file with the up-to-date list of DOI. Each line should contain a single DOI. You can use the `doi.txt` from this repo as an example.

```bash
./get-doi.sh > doi.txt
```

2. Run the script to check whether SBOM and Provenance attestations are present in the `latest` tag of DOI.

```bash
sort doi.txt | parallel -j 8 ./check-attestations.sh --image {} > output.txt 2>&1
```

Example of output:

```txt
[❌] SBOM - [❌] Provenance - [debian]
[✅] SBOM - [✅] Provenance - [cassandra]
[✅] SBOM - [✅] Provenance - [docker]
[❌] SBOM - [❌] Provenance - [eclipse-mosquitto]
[❌] SBOM - [❌] Provenance - [eggdrop]
...
```
