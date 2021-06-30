version 1.0

task vcfReadcountAnnotator {
  input {
    File vcf
    File bam_readcount_tsv
    String data_type  # one of [DNA, RNA]
    String? variant_type  # one of [snv, indel, all]
    String? sample_name
  }

  runtime {
    docker: "griffithlab/vatools:4.1.0"
    memory: "4GB"
  }

  String outfile = "annotated.bam_readcount.vcf.gz"
  command <<<
    vcf-readcount-annotator -o ~{outfile} \
    ~{vcf} ~{bam_readcount_tsv} ~{data_type} \
    ~{if defined(variant_type) then "-t ~{variant_type}" else ""} \
    ~{if defined(sample_name) then "-s ~{sample_name}" else ""}
  >>>

  output {
    File annotated_bam_readcount_vcf = outfile
  }
}
