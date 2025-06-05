version 1.0

task check_annotated {
  input {
    File vcf_file
  }
  runtime {
    docker: "ubuntu"
  }
  command <<<
    HEADER=$(/bin/zcat ~{vcf_file} | /bin/grep -v "##" | /bin/head -n 2 | cut -f 9)

    if [[ $HEADER == *"GX"* && $HEADER == *"GT"* && $HEADER == *"TX"* ]];
    then
      echo "True"
    else
      echo "False"
    fi
  >>>

  output {
    Boolean is_annotated = read_boolean(stdout())
  }
}