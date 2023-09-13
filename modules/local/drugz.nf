
process DRUGZ {
    output:
        path("output.txt")

    script:
    """
    uname -a >> output.txt
    which drugz.py >> output.txt
    """
}
