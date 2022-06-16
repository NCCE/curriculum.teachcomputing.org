task populate_key_stage_titles: :environment do
  key_stages = KeyStage.all
  key_stages.each do |key_stage|
    key_stage.update(title: "Key Stage #{key_stage.level}")
  end
end
