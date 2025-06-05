version 1.0

task validate_file_types {
    input {
        Array[File] files
        Array[String] filetypes
    }
    runtime {
        docker: "ubuntu"
    }
    Int file_count = length(files)
    command <<<
        files_bash=(~{sep=' ' files})
        filetypes_bash=(~{sep=" " filetypes})
        for i in {0..~{file_count - 1}}; do
            file_loc=${files_bash[$i]}
            file_type=${filetypes_bash[$i]}
            if [[ $file_loc != *"$file_type" ]]; then
                echo "$file_loc was not of expected file type: $file_type"

                exit 1
            fi
            if [[ ! -f $file_loc ]]; then
                echo "$file_loc does not exist"
                exit 2
            fi
            echo "$file_loc exists and is of the right file type"
        done
    >>>

    output {
        Boolean valid = true
    }
}