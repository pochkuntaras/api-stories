include FactoryBot::Syntax::Methods

DatabaseCleaner.strategy = :truncation, { except: %w(public.schema_migrations) }
DatabaseCleaner.clean

first_story  = create :story, name: 'The first story.'
second_story = create :story, name: 'The second story.'

create_list :article, 2, :standard_text, story: first_story
create_list :article, 3, :photo_album, story: first_story
create_list :article, 2, :interview, story: second_story
create_list :article, 4, :standard_text, story: second_story
