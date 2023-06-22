<style type="text/css">
  body{
  font-size: 12pt;
}
</style>

------------------------------------------------------------------------

## **cophescan-app**

------------------------------------------------------------------------

#### **Key Terms**

> -   **Primary trait/Protein**: Source of the putative causal
>     variants. - Traits from FinnGen and pQTL fine-mapped to obtain the
>     query variants. While PTV (Protein truncating variants) were
>     selected by using a MAF (UKBB) threshold of &gt; 0.001.
> -   **Query variants (QV)**: Variants tested for association against
>     multiple query traits. (CoPheScan Input)
> -   **Query traits (QT)**: All traits (from UKBB) used for the
>     phenome-wide cophescan analysis. Traits from GWAS catalog used
>     with the individual variants. (CoPheScan Input)

------------------------------------------------------------------------

#### **App usage guide**

> ### **I. Explore input data**

#### - Drop down: **Select query variant source**

Select the source of putative variants:

-   FinnGen (v5)

-   pQTL (Ferkingstad et al)

-   PTV - Protein truncating variants (MAF &gt; 0.05 or ClinVar)

-   Individual - TYK2 and SLC39A8 variants

<br>

#### - Tab: **Query variants**

Displays the table containing the putative causal variants from the
selected source (FinnGen or pQTL or PTV or Individual).

**IMPORTANT NOTE**:

Use the Hc\_detected column to select only those variants that were
detected as Hc with cophescan.

<br>

**FinnGen table:**

<table>
<colgroup>
<col style="width: 30%" />
<col style="width: 69%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>queryvariant_38</td>
<td>Query variant hg38 coordinates</td>
</tr>
<tr class="even">
<td>queryvariant_19</td>
<td>Query variant hg19 coordinates</td>
</tr>
<tr class="odd">
<td>primarytrait</td>
<td>fine-mapped FinnGen primary traits (source of chosen variant)</td>
</tr>
<tr class="even">
<td>finn_primary_longname</td>
<td>primary trait description (FinnGen)</td>
</tr>
<tr class="odd">
<td>primary_trait_direction_eff</td>
<td>Direction of effect of the variant for the primary traits</td>
</tr>
<tr class="even">
<td>UKBB_primary_equiv</td>
<td>Corresponding UKBB primary trait</td>
</tr>
<tr class="odd">
<td>UKBB_primary_descrip</td>
<td>primary trait description (UKBB)</td>
</tr>
<tr class="even">
<td>prob</td>
<td>fine-mapping prob</td>
</tr>
<tr class="odd">
<td>rsid</td>
<td>Query variant rsid</td>
</tr>
<tr class="even">
<td>consequence</td>
<td>Query variant consequence</td>
</tr>
<tr class="odd">
<td>consequence_category</td>
<td>Query variant consequence category</td>
</tr>
<tr class="even">
<td>ukbb_minor_allele</td>
<td>Minor allele of the variant in the UKBB dataset</td>
</tr>
<tr class="odd">
<td>ukbb_minor_AF</td>
<td>Minor allele frequency</td>
</tr>
<tr class="even">
<td>ensembl_gene_id</td>
<td>Query variant ensembl gene id annotation from Ensembl biomart
(R)</td>
</tr>
<tr class="odd">
<td>gene_name</td>
<td>Query variant hgnc gene annotation from Ensembl biomart (R)</td>
</tr>
<tr class="even">
<td>rsid_all</td>
<td>Query variant rsid with alleles</td>
</tr>
<tr class="odd">
<td>Hc_detected</td>
<td>Query variant detected in cophescan analysis (true/false)</td>
</tr>
<tr class="even">
<td></td>
<td></td>
</tr>
</tbody>
</table>

<br>

**pQTL table:**

<table>
<colgroup>
<col style="width: 26%" />
<col style="width: 73%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>queryvariant_38</td>
<td>Query variant hg38 coordinates</td>
</tr>
<tr class="even">
<td>queryvariant_19</td>
<td>Query variant hg19 coordinates</td>
</tr>
<tr class="odd">
<td>primarytrait</td>
<td>fine-mapped pQTL primary traits (source of chosen variant -
Ferkingstad et al)</td>
</tr>
<tr class="even">
<td>symbol</td>
<td>protein symbol from biomart</td>
</tr>
<tr class="odd">
<td>uniprotswissprot</td>
<td>uniprotswissprot id from biomart</td>
</tr>
<tr class="even">
<td>description</td>
<td>description from biomart</td>
</tr>
<tr class="odd">
<td>primary_trait_direction_eff</td>
<td>Direction of effect of the variant for the protein (Only where
Hc_detected = TRUE)</td>
</tr>
<tr class="even">
<td>PP</td>
<td>posterior probability of fine-mapping</td>
</tr>
<tr class="odd">
<td>set_number</td>
<td>the fine-mapping set number that the variant belongs to</td>
</tr>
<tr class="even">
<td>nsets</td>
<td>Number of sets obtained using fine-mapping</td>
</tr>
<tr class="odd">
<td>rsid</td>
<td>Query variant rsid</td>
</tr>
<tr class="even">
<td>consequence</td>
<td>Query variant consequence</td>
</tr>
<tr class="odd">
<td>consequence_category</td>
<td>Query variant consequence category</td>
</tr>
<tr class="even">
<td>ukbb_minor_allele</td>
<td>Minor allele of the variant in the UKBB dataset</td>
</tr>
<tr class="odd">
<td>ukbb_minor_AF</td>
<td>Minor allele frequency</td>
</tr>
<tr class="even">
<td>ensembl_gene_id</td>
<td>Query variant ensembl gene id annotation from Ensembl biomart
(R)</td>
</tr>
<tr class="odd">
<td>gene_name</td>
<td>Query variant hgnc gene annotation from Ensembl biomart (R)</td>
</tr>
<tr class="even">
<td>rsid_all</td>
<td>Query variant rsid with alleles</td>
</tr>
<tr class="odd">
<td>Hc_detected</td>
<td>Query variant detected in cophescan analysis (true/false)</td>
</tr>
<tr class="even">
<td></td>
<td></td>
</tr>
</tbody>
</table>

<br>

**PTV table:**

<table>
<colgroup>
<col style="width: 32%" />
<col style="width: 67%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>queryvariant_38</td>
<td>Query variant hg38 coordinates</td>
</tr>
<tr class="even">
<td>rsid</td>
<td>Query variant rsid</td>
</tr>
<tr class="odd">
<td>consequence</td>
<td>Query variant consequence</td>
</tr>
<tr class="even">
<td>consequence_category</td>
<td>Query variant consequence category</td>
</tr>
<tr class="odd">
<td>primarytrait</td>
<td>PTVs with MAF &gt;0.001</td>
</tr>
<tr class="even">
<td>queryvariant_19</td>
<td>Query variant hg19 coordinates</td>
</tr>
<tr class="odd">
<td>ensembl_gene_id</td>
<td>Query variant ensembl gene id annotation from Ensembl biomart
(R)</td>
</tr>
<tr class="even">
<td>gene_name</td>
<td>Query variant hgnc gene annotation from Ensembl biomart (R)</td>
</tr>
<tr class="odd">
<td>ukbb_minor_allele</td>
<td>Minor allele of the variant in the UKBB dataset</td>
</tr>
<tr class="even">
<td>ukbb_minor_AF</td>
<td>Minor allele frequency</td>
</tr>
<tr class="odd">
<td>rsid_all</td>
<td>Query variant rsid with alleles</td>
</tr>
<tr class="even">
<td>Hc_detected</td>
<td>Query variant detected in cophescan analysis (true/false)</td>
</tr>
<tr class="odd">
<td><p><br></p>
<p><strong>Individual variants table:</strong></p></td>
<td></td>
</tr>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 27%" />
<col style="width: 72%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>queryvariant_38</td>
<td>Query variant hg38 coordinates</td>
</tr>
<tr class="even">
<td>queryvariant_19</td>
<td>Query variant hg19 coordinates</td>
</tr>
<tr class="odd">
<td>chr</td>
<td>Query variant chromosome</td>
</tr>
<tr class="even">
<td>ref</td>
<td>Reference allele</td>
</tr>
<tr class="odd">
<td>alt</td>
<td>ALT allele</td>
</tr>
<tr class="even">
<td>rsid</td>
<td>Query variant rsid</td>
</tr>
<tr class="odd">
<td>ukbb_minor_allele</td>
<td>Minor allele of the variant in the UKBB dataset</td>
</tr>
<tr class="even">
<td>ukbb_minor_AF</td>
<td>Minor allele frequency</td>
</tr>
<tr class="odd">
<td>consequence</td>
<td>Query variant consequence</td>
</tr>
<tr class="even">
<td>consequence_category</td>
<td>Query variant consequence category</td>
</tr>
<tr class="odd">
<td>gene_name</td>
<td>Query variant hgnc gene annotation from Ensembl biomart (R)</td>
</tr>
<tr class="even">
<td>primarytrait</td>
<td>Individual variant study</td>
</tr>
<tr class="odd">
<td>rsid_all</td>
<td>Query variant rsid with alleles</td>
</tr>
<tr class="even">
<td>Hc_detected</td>
<td>Query variant detected in cophescan analysis (true/false)</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
</tr>
</tbody>
</table>

<br>

#### - Tab: **UKBB Query traits**

All the UKBB traits used for the phenome-wide analysis performed with
cophescan.

<table style="width:99%;">
<colgroup>
<col style="width: 43%" />
<col style="width: 55%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>phenotype</td>
<td>UKBB phenotype code</td>
</tr>
<tr class="even">
<td>Phenotype Description</td>
<td>description of the phenotype</td>
</tr>
<tr class="odd">
<td>variable_type</td>
<td>binary/categorical trait</td>
</tr>
<tr class="even">
<td>source</td>
<td>source used to assign phenotype coded</td>
</tr>
<tr class="odd">
<td>n_non_missing</td>
<td>Number of non-missing samples</td>
</tr>
<tr class="even">
<td>n_missing</td>
<td>Number of missing samples</td>
</tr>
<tr class="odd">
<td>n_controls</td>
<td>Number of controls</td>
</tr>
<tr class="even">
<td>n_cases</td>
<td>Number of cases</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
</tr>
</tbody>
</table>

<br>

#### - Tab: **GWAS cat Query traits**

All the GWAS catalog traits used for the analysis performed with
cophescan fixed priors on individually selected variants. This tab is
revealed only when the selection: Individual is made from the ‘Select
query variant source’ dropdown.

<table>
<colgroup>
<col style="width: 57%" />
<col style="width: 42%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>First Author</td>
<td>First Author of the study</td>
</tr>
<tr class="even">
<td>Year</td>
<td>Year of the study</td>
</tr>
<tr class="odd">
<td>Reference</td>
<td>Reference ID of the study</td>
</tr>
<tr class="even">
<td>phenotype</td>
<td>phenotype</td>
</tr>
<tr class="odd">
<td>phenotype_description</td>
<td>description of the phenotype</td>
</tr>
<tr class="even">
<td>phenotype_categ</td>
<td>phenotype_category from Open Target Genetics</td>
</tr>
<tr class="odd">
<td>1000genPop</td>
<td>Population</td>
</tr>
<tr class="even">
<td>Subsequent 4 columns: 4_102267552_C_T, 19_10354167_G_A,
19_10352442_G_C, 19_10359299_A_C, 19_10359243_G_A</td>
<td>These 4 columns show if that query variant were found in the
corresponding study.</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

<br>

> #### **II. CoPheScan results**

<br>

#### - Drop down: **Select variant**

Pick the variant that you want to study. Variants can also be searched
by typing in the search box. The variants are tagged with eiher gene
name (from ensembl Biomart) for the FinnGen, PTV and Individual variants
or with protein symbols for the pQTL variants.

<br>

#### - Slider: **ppHc &gt; Hc threshold:**

Set the threshold of ppHc (posterior probability of causal association
of the QV with the QT). The default is 0.6 which is used in the paper.
Query traits with Hc above this threshold are displayed in the table.

<br>

#### - Tab: **Tables**

The green infobox shows the selected variant and clicking the box opens
the variant in Open Target Genetics in a new browser window.

The primary trait info table (yellow) shows in how many fine-mapped
primary traits/proteins the variant was found to be a putative causal
variant and also the direction of effect (beta in the primary trait
summary stat dataset).

*Table content description:*

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 87%" />
</colgroup>
<thead>
<tr class="header">
<th></th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>querysnp</td>
<td>Query variant</td>
</tr>
<tr class="even">
<td>rsid</td>
<td>Query variant rsid</td>
</tr>
<tr class="odd">
<td>consequence_category</td>
<td>Query variant consequence category</td>
</tr>
<tr class="even">
<td>consequence</td>
<td>Query variant consequence from VEP</td>
</tr>
<tr class="odd">
<td>querytrait</td>
<td>Detected Query trait</td>
</tr>
<tr class="even">
<td>qrtrait_descrip</td>
<td>Query trait description</td>
</tr>
<tr class="odd">
<td>log10pval</td>
<td>-log10(pval) of the query trait</td>
</tr>
<tr class="even">
<td>querytrait_direction_eff</td>
<td>the direction of effect of query trait (beta in the query trait
summary stat dataset). Compare with the direction of effect of primary
traits in the yellow table on the top right of the page.</td>
</tr>
<tr class="odd">
<td>Hc.hier.norg</td>
<td>Hc with Hierarchical|SuSIE|no r<sub>g</sub></td>
</tr>
<tr class="even">
<td>Hc.hier.rg</td>
<td>Hc with Hierarchical|SuSIE|with r<sub>g</sub> (Only
UKBB/FinnGen)</td>
</tr>
<tr class="odd">
<td>Hc.hier.rg.all</td>
<td>Hc with Hierarchical|SuSIE|with r<sub>g</sub> (Only PTV: All PTV
variants with MAF &gt;0.001)</td>
</tr>
<tr class="even">
<td>Hc.hier.rg.gnomAD</td>
<td>Hc with Hierarchical|SuSIE|with r<sub>g</sub> (Only PTV: variants
with MAF &gt;0.001 AND homozygous predicted loss of function pLoF
(gnomAD) )</td>
</tr>
<tr class="odd">
<td>Hc.hier.rg.StopGained</td>
<td>Hc with Hierarchical|SuSIE|with r<sub>g</sub> (Only PTV: variants
with MAF &gt;0.001 AND stop gained )</td>
</tr>
<tr class="even">
<td>Hc</td>
<td>Hc with fixed priors (inferred from the FinnGen UKBB model) (Only
Individual)</td>
</tr>
<tr class="odd">
<td>rg</td>
<td>Genetic correlation (r<sub>g</sub>) between the query and primary
traits(Only UKBB/FinnGen)</td>
</tr>
<tr class="even">
<td>ukbbeq_primarytrait_rg</td>
<td>All the primary traits (UKBB traitsequivalent to those from FinnGen)
in high r<sub>g</sub>, resulting in high Hc (Only UKBB/FinnGen).</td>
</tr>
<tr class="odd">
<td>gnomAD</td>
<td>Only for UKBB/PTV results - Shows if the query variant is a
homozygous pLoF (source: gnomAD)</td>
</tr>
<tr class="even">
<td>gene_name</td>
<td>Query variant gene name</td>
</tr>
<tr class="odd">
<td></td>
<td></td>
</tr>
</tbody>
</table>

Buttons to download or copy the selected variant are present at the top
left corner of the table.

**NOTE**:

1.  There are some missing results in the Hc (Hc.hier.norg or
    Hc.hier.sus.rg) columns of the FinnGen results, which is due to one
    of the following reasons:

    -   the Hc being low in one of them. We display the Hc results only
        if the ppHc &gt; 0.6.

    -   the r<sub>g</sub> between the primary and query trait was not
        available and hence the Hc.hier.sus.rg result was not computed.

2.  The plots in the next tab are made using Hc with no genetic
    correlation (Hc.hier.norg).

<br>

#### - Tab: **Plots**

The green infobox shows the selected variant and clicking the box opens
the variant in Open Target Genetics in a new browser window.

The primary trait info table (yellow) shows in how many fine-mapped
primary traits/proteins the variant was found to be a putative causal
variant and also the direction of effect (beta in the primary trait
summary stat dataset).

The interactive plot shows the Hc (with Hierarchical priors|SuSIE for
FinnGen, PTV and pQTL and Fixed priors|SuSIE for Individual variants) Vs
-log10pVal. Hovering over a point shows the query trait which was found
to be associated with the queried SNP.

------------------------------------------------------------------------

<br>

#### Tab: **README**

Help documentation

------------------------------------------------------------------------
