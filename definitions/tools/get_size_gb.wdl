version 1.0

workflow get_size_gb {
    input {
        Array[File] files
    }
    output {
        Int size=10 + ceil(size(files, "GB"))
    }
}