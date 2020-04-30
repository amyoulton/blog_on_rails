Post.delete_all

75.times do 
    created_at = Faker::Date.backward(days: 365 * 2)
    Post.create(
        title: Faker::Hipster.unique.sentence,
        body: Faker::Hipster.paragraph_by_chars(characters: 256, supplemental: false),
        created_at: created_at,
        updated_at: created_at
    )
end