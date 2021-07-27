namespace :connected_world_strands do
  desc 'add connected world strands to database'
  task populate: :environment do
    strands.each do |strand|
      ConnectedWorldStrand.find_or_create_by(strand: strand[:strand], description: strand[:description])
    end
  end

  desc 'link connected world strands to relevant units'
  task link: :environment do
    failed_count = 0
    failed = []
    data_hash = JSON.parse(File.read('TCC-cw-mapping.json'))

    data_hash.each do |entry|
      unit = Unit.find_by(slug: entry['unit_slug'])

      if unit.present?
        strand = ConnectedWorldStrand.find_by(strand: entry['strand'])
        unit.connected_world_strands << strand
      else
        failed_count += 1
        puts "Failed linking: #{entry['unit_slug']}, #{entry['strand']}"
      end
    end

    puts "Total failed: #{failed_count}"
  end

  def strands
    [
      { strand: 'Self-image and identity',
        description: 'This strand explores the differences between online and offline identity beginning with self-awareness, shaping online identities and media influence in propagating stereotypes. It identifies effective routes for reporting and support and explores the impact of online technologies on self-image and behaviour.' },
      { strand: 'Online relationships',
        description: 'This strand explores how technology shapes communication styles and identifies strategies for positive relationships in online communities. It offers opportunities to discuss relationships, respecting, giving and denying consent and behaviours that may lead to harm and how positive online interaction can empower and amplify voice.' },
      { strand: 'Online reputation',
        description: 'This strand explores the concept of reputation and how others may use online information to make judgements. It offers opportunities to develop strategies to manage personal digital content effectively and capitalise on technology’s capacity to create effective positive profiles.' },
      { strand: 'Online bullying',
        description: 'This strand explores bullying and other online aggression and how technology impacts those issues. It offers strategies for effective reporting and intervention and considers how bullying and other aggressive behaviour relates to legislation.' },
      { strand: 'Managing online information',
        description: 'This strand explores how online information is found, viewed and interpreted. It offers strategies for effective searching, critical evaluation of data, the recognition of risks and the management of online threats and challenges. It explores how online threats can pose risks to our physical safety as well as online safety. It also covers learning relevant to ethical publishing.' },
      { strand: 'Health, well-being and lifestyle',
        description: 'This strand explores the impact that technology has on health, well-being and lifestyle e.g. mood, sleep, body health and relationships. It also includes understanding negative behaviours and issues amplified and sustained by online technologies and the strategies for dealing with them.' },
      { strand: 'Privacy and security',
        description: 'This strand explores how personal online information can be used, stored, processed and shared. It offers both behavioural and technical strategies to limit impact on privacy and protect data and systems against compromise.' },
      { strand: 'Copyright and ownership',
        description: 'This strand explores the concept of ownership of online content. It explores strategies for protecting personal content and crediting the rights of others as well as addressing potential consequences of illegal access, download and distribution.' }
    ]
  end
end
