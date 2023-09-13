
process MAGECK_COUNT {

}

process MAGECK {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which mageck >> output.txt
    """
}


process VISPR {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which vispr >> output.txt
    """
}
