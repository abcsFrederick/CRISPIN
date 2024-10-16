class Utils {
    // run spooker for the workflow
    public static String spooker(launch_dir, pipeline_name) {
        def command_string = "spooker ${launch_dir} ${pipeline_name}"
        def out = new StringBuilder()
        def err = new StringBuilder()
        try {
            def command = command_string.execute()
            command.consumeProcessOutput(out, err)
            command.waitFor()
        } catch(IOException e) {
            err = e
        }
        new FileWriter("${launch_dir}/log/spooker.log").with {
            write("${out}\n${err}")
            flush()
        }
        return err
    }
}
