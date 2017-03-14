class CreateMemories < ActiveRecord::Migration[5.0]
  def change
    create_table :memories do |t|
        t.string 'title'
        t.string 'text_content'
        t.string 'audio_content' #not sure how this is going to work yet
        t.timestamps
    end
  end
end
