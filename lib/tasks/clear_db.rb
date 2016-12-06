Document.destroy_all()
Artwork.destroy_all()
Submitter.all.each do |submitter|
  submitter.increment(:grade)
  submitter.save()
end