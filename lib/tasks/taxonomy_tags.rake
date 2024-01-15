namespace :taxonomy_tags do
  desc "Add taxonomy tags"
  task add_tags: :environment do
    [
      ["Networks", "NW", "Understand how networks can be used to retrieve and share information, and how they come with associated risks"],
      ["Creating Media", "CM", "Select and create a range of media including text, images, sounds, and video"],
      ["Data & Information", "DI", "Understand how data is stored, organised, and used to represent real-world artefacts and scenarios"],
      ["Design & Development", "DD", "Understand the activities involved in planning, creating, and evaluating computing artefacts"],
      ["Computing Systems", "CS", "Understand what a computer is, and how its constituent parts function together as a whole"],
      ["Impact of Technology", "IT", "Understand how individuals, systems, and society as a whole interact with computer systems"],
      ["Algorithms", "AL", "Be able to comprehend, design, create, and evaluate algorithms"],
      ["Programming", "PG", "Create software to allow computers to solve problems"],
      ["Effective Use of tools", "ET", "Use software tools to support computing work"],
      ["Safety & Security", "SS", "Understand risks when using technology, and how to protect individuals and systems"]
    ].each do |strand, abbr, desc|
      TaxonomyTag.find_or_create_by(
        strand: strand,
        abbreviation: abbr,
        description: desc
      )
    end
  end
end
