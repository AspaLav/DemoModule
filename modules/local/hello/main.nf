process HELLO {
    memory '1 GB'  // Adjust memory request here
    
    input:
    val name

    output:
    file "hello.txt"

    script:
    """
    echo "Hello, module!" > hello.txt
    """
}
