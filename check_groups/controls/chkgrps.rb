title 'Check user groups'

avGroups = attribute('allowed_groups', default: [], description: 'Allowed groups')
avUsers = attribute('allowed_users', default: [], description: 'Allowed users')

options = {
  group_re: /^(\S+):.*$/,
  assigment_re: /^\s+([^\s]+)\s*$/,
  multiple_values: true
}
fn = 'mygroups.conf'

control 'user-groups-2' do
  impact 0.7
  title 'Check user groups'
  desc 'Check groups for allowed users'

  cfg_file = file(fn)

  if cfg_file.file? and !cfg_file.content.empty?
    cfg = SimpleConfig.new(cfg_file.content, options)
    describe cfg.groups do
      it { should be_subset_of avGroups }
    end
    cfg.groups.each do |grp|
      describe cfg.params[grp].keys do
        it { should be_subset_of avUsers }
      end
    end
  end
end
