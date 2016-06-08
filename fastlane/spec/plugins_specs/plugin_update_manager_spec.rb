describe Fastlane::PluginUpdateManager do
  describe "#show_update_status" do
    it "does nothing if no updates are available" do
      Fastlane::PluginUpdateManager.show_update_status
    end

    it "prints out a table if updates are avaiable" do
      plugin_name = 'something'
      Fastlane::PluginUpdateManager.server_results[plugin_name] = Gem::Version.new('1.1.0')
      allow(Fastlane::PluginUpdateManager).to receive(:references).and_return({
        plugin_name => {
          version_number: "0.1.1"
        }
      })

      rows = [["something", "0.1.1".red, "1.1.0".green]]
      headings = ["Plugin", "Your Version", "Latest Version"]
      expect(Terminal::Table).to receive(:new).with(title: "Plugin updates available".yellow,
                                                 headings: headings,
                                                     rows: rows)

      Fastlane::PluginUpdateManager.show_update_status
    end
  end
end
